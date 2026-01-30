---
name: memory-cleanup
description: 清理clawdbot记忆文件，只保留session.json和最新时间的.jsonl文件。适用于C:\Users\用户主目录\.clawdbot\agents\main\sessions\目录下的会话文件管理。
---

# Clawdbot Memory Cleanup Skill

This skill is used to clean up clawdbot memory files, keeping only the session.json and the latest .jsonl files, to save storage space and maintain system tidiness.

## Functionality

The skill scans the `C:\Users\%USERNAME%\.clawdbot\agents\main\sessions\` directory and performs the following operations:

1. Retains all `session.json` files
2. Keeps only the latest `.jsonl` file in each session directory
3. Deletes other old `.jsonl` files and unnecessary log files

## Use Cases

- Regular cleanup of clawdbot session history
- Free up disk space
- Maintain session file organization
- Keep only the most important session data

## Script Tools

### Batch Session Cleanup Script

```batch
@echo off
setlocal enabledelayedexpansion

REM Clawdbot Session Cleanup Script
REM Purpose: Clean up session files, keep only session.json and latest .jsonl files

set "SESSIONS_PATH=%USERPROFILE%\.clawdbot\agents\main\sessions"

echo Starting clawdbot session cleanup...
echo Target path: %SESSIONS_PATH%

if not exist "%SESSIONS_PATH%" (
    echo Error: Sessions path does not exist: %SESSIONS_PATH%
    exit /b 1
)

set "count=0"

for /d %%d in ("%SESSIONS_PATH%\*") do (
    echo.
    echo Processing directory: %%~nxd
    
    REM Use PowerShell to get .jsonl files sorted by last write time
    for /f "tokens=*" %%f in ('powershell -command "Get-ChildItem -Path '%%d' -Filter '*.jsonl' -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -ExpandProperty FullName"') do (
        set /a count+=1
        if !count! GTR 1 (
            echo Deleting old .jsonl file: %%~nxf
            del "%%f"
        ) else (
            echo Keeping latest .jsonl file: %%~nxf
        )
    )
    
    REM Reset counter for next directory
    set "count=0"
    
    REM Check if session.json exists
    if exist "%%d\session.json" (
        echo Keeping session.json file
    ) else (
        echo Warning: session.json file does not exist in %%~nxd
    )
)

echo.
echo Cleanup completed!
pause
```

## Usage Methods

1. **Batch method**:
   ```batch
   # Run in Command Prompt
   clean_sessions.bat
   ```

2. **Specify custom path**:
   ```batch
   # Edit the SESSIONS_PATH variable in the script to specify custom path
   ```

## Important Notes

- This operation is irreversible, ensure unwanted session data is backed up
- Always retain session.json files, as they are important session metadata
- Only keep the latest .jsonl file, which contains the most recent conversation history
- It is recommended to run this cleanup regularly to maintain system performance
- If any important sessions need to be retained, back up related directories before cleaning

## Safety Measures

- Script displays files to be deleted before actual deletion
- Retain critical session.json files
- Only delete old .jsonl files, latest files are preserved
- Provide warning messages to remind users of the impact of operations

## Important Notes

- This operation is irreversible, ensure unwanted session data is backed up
- Always retain session.json files, as they are important session metadata
- Only keep the latest .jsonl file, which contains the most recent conversation history
- It is recommended to run this cleanup regularly to maintain system performance
- If any important sessions need to be retained, back up related directories before cleaning

## Safety Measures

- Scripts display files to be deleted before actual deletion
- Retain critical session.json files
- Only delete old .jsonl files, latest files are preserved
- Provide warning messages to remind users of the impact of operations