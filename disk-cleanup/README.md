# Disk Cleanup Tool

This is an automated batch script tool for cleaning C drive junk files.

## Features

- Automatically detects administrator privileges
- Cleans system temporary files (%TEMP%, %TMP%, C:\Windows\Temp)
- Cleans user temporary files (AppData\Local\Temp)
- Cleans system prefetch files
- Empties recycle bin
- Cleans mainstream browser caches (Chrome, Edge, Firefox)
- Cleans Windows update cache
- Cleans system log files
- Cleans Windows Defender cache files
- Deletes Windows.old folder (if exists)
- Cleans volume shadow copies
- Performs system component cleanup

## Instructions

1. Right-click the batch file
2. Select "Run as administrator"
3. Wait for the script to complete execution

## Security Notice

- This script only cleans system-recognized safe junk files
- Will not delete user personal files
- Recommend regular usage to maintain system performance