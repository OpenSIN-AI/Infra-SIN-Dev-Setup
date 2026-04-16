#!/usr/bin/env bash
# ============================================================
# oci-space-guardian.sh — OCI VM Disk Space Guardian
# ============================================================
# PURPOSE:
#   Monitors OCI VM root disk usage and proactively cleans up
#   cache directories, stale packages, and (optionally) leaked
#   runner temp files to prevent disk-full scenarios.
#
# SCHEDULE:
#   Should be run via cron or systemd timer (e.g., every 15-30min).
#   Also called by cleanup-runner-libs.sh as a fallback layer.
#
# PREVENTION HISTORY:
#   - 2026-04-16: Added call to /usr/local/bin/cleanup-runner-libs.sh
#     as additional fallback layer to catch /tmp/.*.so leaks from
#     opencode --version crash storms (BUG-OCI-001).
# ============================================================

set -euo pipefail
shopt -s nullglob

log() {
    logger -t oci-space-guardian -- "$*" || true
    printf '%s ' "$*"
}

# Remove a cache directory if it exists
cleanup_dir() {
    local path="$1"
    if [ -d "$path" ]; then
        rm -rf "$path"
        log "removed cache: $path"
    fi
}

# Get current root disk usage as integer percentage
current_use_pct() {
    df -P / | awk 'NR==2 {gsub("%", "", $5); print $5+0}'
}

# Get available GB on root disk
current_avail_gb() {
    df -BG --output=avail / | awk 'NR==2 {gsub("G", "", $1); print $1+0}'
}

# === PRE-CLEANup snapshot ===
before_pct="$(current_use_pct)"
before_avail="$(current_avail_gb)"
log "start: root=${before_pct}% avail=${before_avail}G"

# === CLEANUP LAYER 1: Common cache directories ===
cleanup_dir /home/ubuntu/.cache/camoufox
cleanup_dir /home/ubuntu/.npm/_cacache
cleanup_dir /home/ubuntu/.cache/pip
cleanup_dir /home/ubuntu/.cache/node-gyp

# === CLEANUP LAYER 2: Package manager ===
apt-get clean >/dev/null 2>&1 || true

# === CLEANUP LAYER 3: systemd journal (size-based) ===
journalctl --vacuum-size=200M >/dev/null 2>&1 || true

# === CLEANUP LAYER 4: runner temp files (BUG-OCI-001 fallback) ===
# This script handles /tmp/.*.so files from opencode --version invocations.
# It runs every 5 minutes via runner-cleanup.timer, but we call it here
# as an additional safety net in the guardian.
if [ -x /usr/local/bin/cleanup-runner-libs.sh ]; then
    /usr/local/bin/cleanup-runner-libs.sh >/dev/null 2>&1 || true
fi

# === CLEANUP LAYER 5: Docker artifacts (only if disk >= 80%) ===
after_cache_pct="$(current_use_pct)"
if [ "$after_cache_pct" -ge 80 ]; then
    log "disk pressure detected (${after_cache_pct}%), pruning Docker artifacts"
    docker container prune -f >/dev/null 2>&1 || true
    docker image prune -af --filter "until=168h" >/dev/null 2>&1 || true
    docker network prune -f >/dev/null 2>&1 || true
    docker builder prune -af >/dev/null 2>&1 || true
fi

# === POST-CLEANup snapshot ===
after_pct="$(current_use_pct)"
after_avail="$(current_avail_gb)"
if [ "$after_pct" -ge 85 ] && [ -x /usr/local/bin/oci-emergency-disk-guard.sh ]; then
    log "root=${after_pct}% exceeds emergency threshold, invoking emergency guard"
    /usr/local/bin/oci-emergency-disk-guard.sh >/dev/null 2>&1 || true
    after_pct="$(current_use_pct)"
    after_avail="$(current_avail_gb)"
fi
log "done: root=${after_pct}% avail=${after_avail}G"
