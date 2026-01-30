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