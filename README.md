# Maintenance Suite for System Maintenance (Bash)

## Files included
- backup.sh            : Automated backup script (adjust BACKUP_SRC / BACKUP_DEST)
- update_cleanup.sh    : System update + cleanup script (supports apt and yum)
- log_monitor.sh       : Scans syslog or journalctl for critical keywords
- maintenance_suite.sh : Menu to run the above tasks
- sample_sys_maintenance.log : A short sample log showing expected output

## Usage
1. Copy all files to a directory on the target Linux machine.
2. Make scripts executable: `chmod +x *.sh`
3. Run the menu:
   - `sudo ./maintenance_suite.sh`
   or run individual scripts:
   - `sudo ./backup.sh`
   - `sudo ./update_cleanup.sh`
   - `sudo ./log_monitor.sh`

## Notes
- Scripts log to `/var/log/sys_maintenance.log` and ` /var/log/log_alerts.log`.
- The backup script writes backups to `/var/backups` by default. Adjust variables near the top of each script to match your environment.
- On systems without /var/log/syslog, log_monitor.sh uses `journalctl`.
- These scripts require sudo privileges for package management and writing to /var/log or /var/backups.
