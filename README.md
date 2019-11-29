# PowerShell Apache Log Rotation Script

This PowerShell script has been created to automate the rotation of Apache HTTP Server log files when it's running on Microsoft Windows.

## apache-powershell-logrotate.ps1

This script first stops the Apache HTTP Server service because when running on Windows the log files are locked. The files are then datestamped and moved to a different location, and the server service started again.

As a cleanup task, the script also deletes logfiles that are older than a user defined period in days.