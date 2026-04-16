#!/usr/bin/env bash
# ============================================================
# cleanup-runner-libs.sh — BUG-OCI-001 Fix
# ============================================================
# Cleans up leaked /tmp/.*.so temp files from opencode invocations.
# Originally written by: sin-scheduler (systemd timer)
# Fixed by: A2A-SIN-Desktop-Repair (2026-04-16)
#
# WHY THIS SCRIPT EXISTS:
#   Every `opencode --version` invocation creates a hidden .so file in /tmp/
#   (~4.4 MB each). In a crash storm (6 services × ~55k restarts), this
#   accumulates to 170GB+ and fills the OCI VM root disk.
#
# THE ORIGINAL BUG:
#   The previous script used: rm -f /tmp/.3ba5fec1fe4ff*.so
#   This only matched a specific prefix — ALL other /tmp/.*.so files
#   were leaked, accumulating 53,005 files = 170GB.
#
# THE FIX:
#   Uses Python glob to match ALL /tmp/.*.so files older than 10 minutes.
#   Also cleans /tmp/dotnet-libs/ (1440min+ old).
#
# TIMER: runner-cleanup.timer runs this every 5 minutes.
# LOGGING: All actions logged to syslog via `logger`.
# ============================================================

set -u

LOGTAG="runner-cleanup"
SO_AGE_MINUTES="10"

log() {
    logger -t "$LOGTAG" -- "$*" || true
    printf "%s\n" "$*" >&2 || true
}

# Count /tmp/.*.so files currently present
count_tmp_so() {
    python3 - <<'PY2'
import glob
print(len(glob.glob('/tmp/.*.so')))
PY2
}

# Sum total size of /tmp/.*.so files in GB
sum_tmp_so_gb() {
    python3 - <<'PY2'
import glob, os
size = 0
for f in glob.glob('/tmp/.*.so'):
    try:
        if os.path.isfile(f):
            size += os.path.getsize(f)
    except FileNotFoundError:
        pass
print(f"{size/1024/1024/1024:.2f}")
PY2
}

# === MAIN ===
before_count=$(count_tmp_so)
before_gb=$(sum_tmp_so_gb)

# Delete ALL /tmp/.*.so files older than SO_AGE_MINUTES
# (The Python approach ensures glob matches ALL .so files, not just a prefix)
python3 - <<PY2
import glob, os, time

cutoff = time.time() - (${SO_AGE_MINUTES} * 60)

for f in glob.glob('/tmp/.*.so'):
    try:
        st = os.stat(f)
    except FileNotFoundError:
        continue
    if os.path.isfile(f) and st.st_mtime < cutoff:
        try:
            os.remove(f)
        except Exception:
            pass
PY2

# Additional cleanup: /tmp/dotnet-libs/ (1440min = 24h)
if [ -d /tmp/dotnet-libs ]; then
    find /tmp/dotnet-libs -type f -mmin +1440 -delete 2>/dev/null || true
fi

after_count=$(count_tmp_so)
after_gb=$(sum_tmp_so_gb)
deleted=$((before_count - after_count))
[ "$deleted" -lt 0 ] && deleted=0

log "cleanup tmp-so: deleted=$deleted before_count=$before_count after_count=$after_count before_gb=$before_gb after_gb=$after_gb threshold=${SO_AGE_MINUTES}m"

exit 0