#!/bin/bash
# System Update and Cleanup Script

set -euo pipefail

LOG_FILE="/var/log/sys_maintenance.log"

echo "[$(date)] Starting system update and cleanup..." | tee -a "$LOG_FILE"

if command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt upgrade -y 2>>"$LOG_FILE" && echo "[$(date)] System updated successfully." | tee -a "$LOG_FILE"
    sudo apt autoremove -y 2>>"$LOG_FILE" && sudo apt autoclean 2>>"$LOG_FILE" && echo "[$(date)] System cleanup completed." | tee -a "$LOG_FILE"
elif command -v yum >/dev/null 2>&1; then
    sudo yum -y update 2>>"$LOG_FILE" && echo "[$(date)] System updated (yum)." | tee -a "$LOG_FILE"
    # yum handles cleanup differently
else
    echo "[$(date)] WARNING: Package manager not recognized; update skipped." | tee -a "$LOG_FILE"
    exit 2
fi
