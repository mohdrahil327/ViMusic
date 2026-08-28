@echo off
REM ViMusic Build Script for Windows

echo.
echo ====================================
echo  ViMusic Build Script
echo ====================================
echo.

REM Check if Android SDK path is provided as argument
if not "%1"=="" (
    echo Setting Android SDK path to: %1
    echo sdk.dir=%1> local.properties
    echo local.properties created.
    echo.
)

REM Check if local.properties exists
if not exist "local.properties" (
    echo ERROR: local.properties not found!
    echo.
    echo Usage: build.bat "C:\path\to\android\sdk"
    echo.
    echo Example: build.bat "C:\Users\%USERNAME%\AppData\Local\Android\sdk"
    echo.
    pause
    exit /b 1
)

echo Checking Java version...
java -version
echo.

echo Running Gradle build...
echo.

call gradlew.bat build -x test --no-daemon

if %ERRORLEVEL% equ 0 (
    echo.
    echo ====================================
    echo  BUILD SUCCESSFUL!
    echo ====================================
    echo.
    echo Debug APK: app\build\outputs\apk\debug\app-debug.apk
    echo.
    echo To install on device:
    echo   gradlew.bat installDebug
    echo.
) else (
    echo.
    echo ====================================
    echo  BUILD FAILED!
    echo ====================================
    echo.
    echo Check the errors above and ensure:
    echo  1. local.properties has correct sdk.dir path
    echo  2. Android SDK is properly installed
    echo  3. Java is properly installed and in PATH
    echo.
    pause
    exit /b 1
)

pause
