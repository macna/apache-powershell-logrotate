# Define where Apache writes the log files
$logFiles = "C:\path\to\logs"

# Define the location the log files should be archived to
$logArchive = "C:\path\to\archive"

# Define for how many days we should retain logs in the archive location

# Stop the Apache HTTP Server service, using a wildcard to find it by name
Get-Service -Name Apache* | Stop-Service

# Datestamp the current log files and move them to the archive location
Get-ChildItem -Path $logFiles -Filter *.log | ForEach-Object {
	$newName = "$($_.DirectoryName)\$(Get-Date -Format yyyy-MM-dd)-$($_.BaseName)$($_.Extension)"
	Rename-Item -Path $_.FullName -NewName $newName
	Move-Item -Path $newName -Destination $logArchive
	}

# Start the Apache HTTP Server service, again using a wildcard to find it
Get-Service -Name Apache* | Start-Service

Get-ChildItem -Path $logArchive | Where-Object {$_.CreationTime -lt $logLimit} | Remove-Item -Force