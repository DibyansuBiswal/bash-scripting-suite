#!/bin/bash
# Log Monitoring Script

set -euo pipefail

LOG_FILE="/var/log/sys_maintenance.log"
SYS_LOG="/var/log/syslog"
if [ ! -f "$SYS_LOG" ]; then
    # fallback for systems using journalctl
    SYS_LOG=""
fi
KEYWORDS=("error" "fail" "critical" "denied")
ALERT_LOG="/var/log/log_alerts.log"
: > "$ALERT_LOG"

echo "[$(date)] Running log monitor..." | tee -a "$LOG_FILE"

if [ -n "$SYS_LOG" ]; then
    for keyword in "${KEYWORDS[@]}"; do
        grep -i -- "$keyword" "$SYS_LOG" >> "$ALERT_LOG" || true
    done
else
    # Use journalctl as a fallback for systems without /var/log/syslog
    for keyword in "${KEYWORDS[@]}"; do
        journalctl -p err -n 1000 | grep -i -- "$keyword" >> "$ALERT_LOG" || true
    done
fi

if [[ -s "$ALERT_LOG" ]]; then
    echo "[$(date)] ALERT: Issues found! See $ALERT_LOG" | tee -a "$LOG_FILE"
    # Example: send user an on-screen notice (customize as needed)
    echo "Alert log contains entries:"
    tail -n 20 "$ALERT_LOG"
    exit 0
else
    echo "[$(date)] No critical logs found." | tee -a "$LOG_FILE"
    exit 0
fi
