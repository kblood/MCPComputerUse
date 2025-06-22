@echo off
echo ================================================
echo    Skyrim Together Reborn Portable Setup
echo ================================================
echo.

:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run as Administrator for VC++ installation
    pause
    exit
)

echo Installing Visual C++ Redistributables...
if exist "redist\vcredist_x64.exe" (
    redist\vcredist_x64.exe /quiet
    echo VC++ Redistributables installed.
) else (
    echo Warning: VC++ Redistributables not found. Please install manually.
)

echo.
echo Setting up file associations...
:: Register .esp and .esm file types for Skyrim
reg add "HKEY_CURRENT_USER\SOFTWARE\Classes\.esp" /ve /d "SkyrimPlugin" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\SOFTWARE\Classes\.esm" /ve /d "SkyrimMaster" /f >nul 2>&1

echo.
echo ================================================
echo    Installation Complete!
echo ================================================
echo.
echo To play:
echo 1. Run LAUNCH.bat
echo 2. Create a new character with Alternate Start
echo 3. Press Right Ctrl in-game for multiplayer
echo.
pause