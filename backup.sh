#!/bin/bash
# Automated System Backup Script
# Author: Dibyansu Biswal
# Note: adjust BACKUP_SRC and BACKUP_DEST as needed

set -euo pipefail

BACKUP_SRC="/home"
BACKUP_DEST="/var/backups"
LOG_FILE="/var/log/sys_maintenance.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DEST/backup_$DATE.tar.gz"

mkdir -p "$BACKUP_DEST"

echo "[$(date)] Starting backup: $BACKUP_SRC -> $BACKUP_FILE" | tee -a "$LOG_FILE"

if tar -czf "$BACKUP_FILE" -C / "$(echo "$BACKUP_SRC" | sed 's|^/||')" 2>>"$LOG_FILE"; then
    echo "[$(date)] Backup successful: $BACKUP_FILE" | tee -a "$LOG_FILE"
    exit 0
else
    echo "[$(date)] ERROR: Backup failed!" | tee -a "$LOG_FILE"
    exit 1
fi
