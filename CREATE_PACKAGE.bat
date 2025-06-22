@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo    Skyrim Together Portable Package Creator
echo ================================================
echo.

set "SOURCE_DIR=C:\Modding\Skyrim"
set "PACKAGE_DIR=%cd%\SkyrimTogetherPortable"

:: Create package directory
if exist "%PACKAGE_DIR%" (
    echo Removing existing package directory...
    rmdir /s /q "%PACKAGE_DIR%"
)

echo Creating package directory...
mkdir "%PACKAGE_DIR%"

:: Copy MO2 setup
echo Copying Mod Organizer 2...
xcopy "%SOURCE_DIR%\MO2" "%PACKAGE_DIR%\MO2" /e /i /h /y

:: Find Skyrim installation
echo.
echo Please locate your Skyrim Special Edition installation:
echo Common locations:
echo - C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition
echo - C:\Program Files\Steam\steamapps\common\Skyrim Special Edition
echo.
set /p "SKYRIM_PATH=Enter Skyrim path: "

if not exist "%SKYRIM_PATH%\SkyrimSE.exe" (
    echo ERROR: SkyrimSE.exe not found at specified path!
    pause
    exit
)

:: Copy Skyrim
echo Copying Skyrim Special Edition...
xcopy "%SKYRIM_PATH%" "%PACKAGE_DIR%\Skyrim" /e /i /h /y

:: Copy setup files
echo Copying setup files...
copy "INSTALL.bat" "%PACKAGE_DIR%\"
copy "LAUNCH.bat" "%PACKAGE_DIR%\"
copy "README.txt" "%PACKAGE_DIR%\"

echo.
echo ================================================
echo    Package Created Successfully!
echo ================================================
echo.
echo Package location: %PACKAGE_DIR%
echo.
echo To distribute:
echo 1. Archive the entire SkyrimTogetherPortable folder
echo 2. Recipients should extract and run INSTALL.bat
echo.
pause