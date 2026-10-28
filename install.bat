@echo off
setlocal EnableExtensions
set "SRC=%~dp0"
set "DST=%USERPROFILE%\Documents\Paradox Interactive\Hearts of Iron IV\mod"

echo ============================================
echo  Subject No Army - installer
 echo ============================================
echo.

if not exist "%DST%" (
    echo [ERROR] HOI4 mod folder not found:
    echo   %DST%
    echo Run the game once first, then retry.
    pause
    exit /b 1
)

echo Copying mod files ...
xcopy "%SRC%Subject_No_Army" "%DST%\Subject_No_Army\" /E /I /Y >nul
if errorlevel 1 (
    echo [ERROR] failed to copy mod folder.
    pause
    exit /b 1
)
copy /Y "%SRC%Subject_No_Army.mod" "%DST%\Subject_No_Army.mod" >nul
if errorlevel 1 (
    echo [ERROR] failed to copy .mod file.
    pause
    exit /b 1
)
echo Copy OK.
echo.
echo Next steps:
echo   1) Close Hearts of Iron IV if it is running.
echo   2) Open Paradox Launcher PlaySet and enable "Subject No Army",
echo      OR choose Y below to update dlc_load.json right now.
echo.

choice /C YN /M "Update dlc_load.json to enable the mod now"
if errorlevel 2 goto done

powershell -NoProfile -ExecutionPolicy Bypass -Command "$p = Join-Path $env:USERPROFILE 'Documents\Paradox Interactive\Hearts of Iron IV\dlc_load.json'; if (Test-Path $p) { Copy-Item $p ($p + '.bak') -Force; $j = Get-Content $p -Raw | ConvertFrom-Json; $l = @($j.enabled_mods); if ($l -notcontains 'mod/Subject_No_Army.mod') { $l += 'mod/Subject_No_Army.mod' }; $j.enabled_mods = $l; $j | ConvertTo-Json -Depth 6 | Set-Content $p -Encoding UTF8; Write-Host 'dlc_load.json updated (backup: .bak)' } else { Write-Host 'dlc_load.json not found - enable mod in launcher instead.' }"

:done
echo.
echo Done. Launch the game and load your save to test.
echo See the README file in this folder for details.
pause
