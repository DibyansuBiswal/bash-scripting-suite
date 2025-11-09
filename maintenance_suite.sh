#!/bin/bash
# Maintenance Suite Menu
set -euo pipefail

LOG_FILE="/var/log/sys_maintenance.log"

while true; do
    clear
    echo "======================================"
    echo "  System Maintenance Suite"
    echo "======================================"
    echo "1. Run System Backup"
    echo "2. Perform System Update and Cleanup"
    echo "3. Monitor System Logs"
    echo "4. View Maintenance Log"
    echo "5. Exit"
    echo "======================================"
    read -p "Enter your choice [1-5]: " choice

    case $choice in
        1) sudo bash "$(dirname "$0")/backup.sh" ;;
        2) sudo bash "$(dirname "$0")/update_cleanup.sh" ;;
        3) sudo bash "$(dirname "$0")/log_monitor.sh" ;;
        4) sudo less "$LOG_FILE" ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice! Try again." ;;
    esac
    read -p "Press Enter to continue..."
done
