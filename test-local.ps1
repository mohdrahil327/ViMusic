# ViMusic Local Testing Script for PowerShell
# This script helps you build and test the bug fixes

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=========================================="
Write-Host "  ViMusic Bug Fixes - Local Testing"
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

# Step 1: Check Java
Write-Host "[Step 1] Checking Java installation..." -ForegroundColor Cyan
try {
    $javaVersion = java -version 2>&1 | Select-Object -First 1
    Write-Host "✅ Found: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Java not found! Please install Java JDK 11 or higher." -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Check Android SDK
Write-Host "[Step 2] Checking Android SDK..." -ForegroundColor Cyan
$androidHome = $env:ANDROID_HOME
$hasLocalProps = Test-Path "local.properties"

if ([string]::IsNullOrEmpty($androidHome) -and -not $hasLocalProps) {
    Write-Host "❌ Android SDK not configured!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please do one of the following:" -ForegroundColor Yellow
    Write-Host "  1. Set ANDROID_HOME environment variable:"
    Write-Host "     `$env:ANDROID_HOME = 'C:\path\to\android\sdk'"
    Write-Host ""
    Write-Host "  2. Or create local.properties file with:"
    Write-Host "     sdk.dir=C:\path\to\android\sdk"
    Write-Host ""
    exit 1
}
Write-Host "✅ Android SDK configured" -ForegroundColor Green
Write-Host ""

# Step 3: Check for gradle wrapper
Write-Host "[Step 3] Checking Gradle wrapper..." -ForegroundColor Cyan
if (-not (Test-Path "gradlew.bat")) {
    Write-Host "❌ Gradle wrapper not found!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Gradle wrapper found" -ForegroundColor Green
Write-Host ""

# Step 4: Clean build
Write-Host "[Step 4] Building project (this may take several minutes)..." -ForegroundColor Cyan
Write-Host ""

& ".\gradlew.bat" clean build -x test --no-daemon

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "=========================================="
    Write-Host "  ✅ BUILD SUCCESSFUL!" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Bug fixes compiled successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "  1. Install debug APK:"
    Write-Host "     .\gradlew.bat installDebug"
    Write-Host ""
    Write-Host "  2. Run on device/emulator:"
    Write-Host "     .\gradlew.bat :app:run"
    Write-Host ""
    Write-Host "Test the fixes:" -ForegroundColor Cyan
    Write-Host "  ✓ Play songs from playlists (video ID fix)"
    Write-Host "  ✓ Check for 'audio format not playable' errors"
    Write-Host "  ✓ Search for tracks (should show results)"
    Write-Host "  ✓ Remove app from recents (music should stop)"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "=========================================="
    Write-Host "  ❌ BUILD FAILED!" -ForegroundColor Red
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Troubleshooting:" -ForegroundColor Yellow
    Write-Host "  1. Verify Android SDK path is correct"
    Write-Host "  2. Check Java version (need JDK, not just JRE)"
    Write-Host "  3. Run: .\gradlew.bat clean build --stacktrace"
    Write-Host ""
    exit 1
}
