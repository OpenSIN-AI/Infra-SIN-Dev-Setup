#!/usr/bin/env bash
# ============================================================
# Log Rotation Cron for OCI VM — BUG-OCI-001 Prevention Layer 2
# ============================================================
# PURPOSE:
#   Rotates syslog and journald logs to prevent disk fill from
#   verbose logging. Part of the BUG-OCI-001 prevention stack.
#
# SCHEDULE:
#   Daily via cron at 03:00 UTC.
#
# ROTATION POLICY:
#   - syslog: keep 7 days
#   - journald: keep 7 days, max 200MB
#   - old kern.log: compress and keep 7 days
#
# DEPLOYMENT:
#   Install as /etc/cron.daily/oci-log-rotation on OCI VM.
#   Make executable: chmod +x /etc/cron.daily/oci-log-rotation
# ============================================================

set -euo pipefail

LOGROTATE_CONF="/etc/logrotate.d/syslog"
SYSLOG_FILES="/var/log/syslog /var/log/kern.log /var/log/auth.log"

log() {
    logger -t oci-log-rotation -- "$*" 2>/dev/null || true
}

log "start: rotating logs"

# Vacuum journald logs (keep 7 days, max 200MB)
journalctl --vacuum-time=7d 2>/dev/null || true
journalctl --vacuum-size=200M 2>/dev/null || true

# Rotate syslog if it exists
if [ -f /var/log/syslog ]; then
    find /var/log -name "syslog*" -type f -mtime +7 -delete 2>/dev/null || true
    find /var/log -name "kern.log*" -type f -mtime +7 -delete 2>/dev/null || true
    find /var/log -name "auth.log*" -type f -mtime +7 -delete 2>/dev/null || true
fi

# Compress any uncompressed old logs
for f in /var/log/*.log; do
    if [ -f "$f" ] && [ ! -f "${f}.gz" ]; then
        gzip -9 "$f" 2>/dev/null || true
    fi
done

log "done: log rotation complete"

exit 0