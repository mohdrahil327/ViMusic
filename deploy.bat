@echo off
REM ViMusic Bug Fixes Deployment Script
REM This script pushes your fixes to your GitHub account
REM GitHub Username: rahil729

setlocal enabledelayedexpansion

echo.
echo ========================================
echo  ViMusic Bug Fixes - GitHub Deployment
echo ========================================
echo.
echo GitHub Username: rahil729
echo Branch: rahil729-vimusic-task
echo.

REM Step 1: Check if fork exists
echo [Step 1] Checking GitHub fork...
echo.
echo To proceed, you need to:
echo.
echo 1. Go to: https://github.com/vfsfitvnm/ViMusic
echo 2. Click the "Fork" button (top-right)
echo 3. GitHub will create: github.com/rahil729/ViMusic
echo.
echo Press any key when you've forked the repository...
pause

REM Step 2: Update remote
echo.
echo [Step 2] Updating remote repository URL...
git remote set-url origin https://github.com/rahil729/ViMusic.git
echo ✅ Remote updated to: https://github.com/rahil729/ViMusic.git
echo.

REM Step 3: Push to fork
echo [Step 3] Pushing changes to your fork...
echo This may take a minute...
echo.
git push origin rahil729-vimusic-task -v

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================
    echo  ✅ DEPLOYMENT SUCCESSFUL!
    echo ========================================
    echo.
    echo Your bug fixes are now online at:
    echo https://github.com/rahil729/ViMusic/tree/rahil729-vimusic-task
    echo.
    echo Next steps:
    echo 1. Visit the URL above to see your branch
    echo 2. Share the link with anyone who wants the fixes
    echo 3. They can clone it: 
    echo    git clone -b rahil729-vimusic-task https://github.com/rahil729/ViMusic.git
    echo.
    echo Or they can view the code, create pull requests, etc.
    echo.
) else (
    echo.
    echo ========================================
    echo  ⚠️  DEPLOYMENT FAILED
    echo ========================================
    echo.
    echo Troubleshooting:
    echo 1. Make sure you've forked the repo first
    echo 2. Check your internet connection
    echo 3. Verify GitHub credentials
    echo.
    pause
    exit /b 1
)

pause
