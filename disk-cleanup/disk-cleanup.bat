@echo off
title Windows 系统垃圾清理工具
echo Windows 系统垃圾清理工具
echo ========================

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 此程序需要管理员权限才能安全清理系统中的垃圾文件
    echo 请右键点击脚本文件并选择"以管理员身份运行"。
    pause
    exit /b
)
:: 清理临时文件
echo.
echo 正在清理系统临时文件...
echo 使用系统清理工具清理临时文件...
cleanmgr /sagerun:1

echo 清理系统临时文件...
for %%d in ("%TEMP%" "%TMP%" "C:\Windows\Temp") do (
    del /f /s /q "%%d\*" >nul 2>&1
    echo 清理目录: %%d
)

echo 清理用户临时文件...
for /f "tokens=2 delims==" %%a in ('set USERPROFILE 2^>nul') do (
    del /f /s /q "%%a\AppData\Local\Temp\*" >nul 2>&1
    echo 清理目录: %%a\AppData\Local\Temp
)

echo 清理预取文件...
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
echo 预取文件清理完毕。

:: 清空回收站
echo.
echo 正在清空回收站...
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue | Out-Null"
if %errorlevel%==0 (
    echo 回收站已清空。
) else (
    echo 清空回收站时发生错误，可能需要管理员权限。
)

:: 清理浏览器缓存
echo.
echo 正在清理浏览器缓存...
for /f "tokens=2 delims==" %%a in ('set USERPROFILE 2^>nul') do (
    del /f /s /q "%%a\AppData\Local\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
    del /f /s /q "%%a\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
    for /d %%d in ("%%a\AppData\Local\Mozilla\Firefox\Profiles\*") do (
        del /f /s /q "%%d\cache2\*" >nul 2>&1
    )
)
echo 浏览器缓存清理完毕。

:: 清理 Windows 更新缓存
echo.
echo 正在清理 Windows 更新缓存...
cleanmgr /sagerun:3
net stop wuauserv >nul 2>&1
del /f /s /q "%windir%\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
dism /online /cleanup-image /startcomponentcleanup /resetbase >nul 2>&1
cleanmgr /sagerun:8 >nul 2>&1
cleanmgr /sagerun:9 >nul 2>&1
cleanmgr /sagerun:10 >nul 2>&1
echo Windows 更新缓存清理完毕。

:: 清理 Windows 垃圾文件
echo.
echo 正在清理 Windows 垃圾文件...
if exist "C:\Windows.old" (
    rmdir /s /q "C:\Windows.old" >nul 2>&1
    echo Windows.old 文件夹已被删除。
) else (
    echo Windows.old 文件夹不存在。
)
vssadmin delete shadows /all /quiet >nul 2>&1
echo Windows 垃圾文件清理完毕。

:: 清理系统日志文件
echo.
echo 正在清理系统日志文件...
cleanmgr /sagerun:5 >nul 2>&1
cleanmgr /sagerun:7 >nul 2>&1
powershell -Command "wevtutil el | Foreach-Object {wevtutil cl ""$_""}" >nul 2>&1
del /f /s /q "C:\Windows\Logs\CBS\*" >nul 2>&1
echo 系统日志文件清理完毕。

:: 清理 Windows Defender 文件
echo.
echo 正在清理 Windows Defender 文件...
cleanmgr /sagerun:4 >nul 2>&1
echo Windows Defender 文件清理完毕。

:: 清理 IIS 日志
echo.
echo 正在清理 IIS 日志...
cleanmgr /sagerun:6 >nul 2>&1
echo IIS 日志清理完毕。

echo.
echo 所有清理任务已完成。
pause
exit /b