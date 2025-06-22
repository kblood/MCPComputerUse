@echo off
cd /d "%~dp0"

echo ================================================
echo    Launching Skyrim Together Reborn
echo ================================================
echo.

:: Set environment variables for portable mode
set SKYRIM_PATH=%cd%\Skyrim
set MO2_PATH=%cd%\MO2

:: Check if Skyrim exists
if not exist "%SKYRIM_PATH%\SkyrimSE.exe" (
    echo ERROR: Skyrim not found at %SKYRIM_PATH%
    echo Please ensure Skyrim is in the Skyrim folder.
    pause
    exit
)

:: Check if MO2 exists
if not exist "%MO2_PATH%\ModOrganizer.exe" (
    echo ERROR: Mod Organizer 2 not found at %MO2_PATH%
    echo Please ensure MO2 is properly installed.
    pause
    exit
)

echo Starting Mod Organizer 2...
echo Profile: Skyrim Together
echo.

:: Launch MO2 with the Skyrim Together profile
start "" "%MO2_PATH%\ModOrganizer.exe" -p "Skyrim Together"

echo MO2 launched. Use the SkyrimTogether executable from MO2.
echo.
echo Instructions:
echo 1. In MO2, select "SkyrimTogether" from the executable dropdown
echo 2. Click Run
echo 3. Create new character or load past-Helgen save
echo 4. Press Right Ctrl for multiplayer menu
echo.
pause