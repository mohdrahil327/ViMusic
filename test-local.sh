#!/bin/bash
# ViMusic Local Testing Script
# This script helps you build and test the bug fixes

set -e

echo "=========================================="
echo "  ViMusic Bug Fixes - Local Testing"
echo "=========================================="
echo ""

# Step 1: Check Java
echo "[Step 1] Checking Java installation..."
if ! command -v java &> /dev/null; then
    echo "❌ Java not found! Please install Java JDK 11 or higher."
    exit 1
fi
JAVA_VERSION=$(java -version 2>&1 | head -1)
echo "✅ Found: $JAVA_VERSION"
echo ""

# Step 2: Check Android SDK
echo "[Step 2] Checking Android SDK..."
if [ -z "$ANDROID_HOME" ] && [ ! -f "local.properties" ]; then
    echo "❌ Android SDK not configured!"
    echo ""
    echo "Please do one of the following:"
    echo "  1. Set ANDROID_HOME environment variable:"
    echo "     export ANDROID_HOME=/path/to/android/sdk"
    echo ""
    echo "  2. Or create local.properties file with:"
    echo "     sdk.dir=/path/to/android/sdk"
    echo ""
    exit 1
fi
echo "✅ Android SDK configured"
echo ""

# Step 3: Check for gradle wrapper
echo "[Step 3] Checking Gradle wrapper..."
if [ ! -f "gradlew" ]; then
    echo "❌ Gradle wrapper not found!"
    exit 1
fi
echo "✅ Gradle wrapper found"
echo ""

# Step 4: Clean build
echo "[Step 4] Building project (this may take several minutes)..."
echo ""
chmod +x gradlew
./gradlew clean build -x test --no-daemon

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "  ✅ BUILD SUCCESSFUL!"
    echo "=========================================="
    echo ""
    echo "Bug fixes compiled successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Install debug APK:"
    echo "     ./gradlew installDebug"
    echo ""
    echo "  2. Run on device/emulator:"
    echo "     ./gradlew :app:run"
    echo ""
    echo "Test the fixes:"
    echo "  ✓ Play songs from playlists (video ID fix)"
    echo "  ✓ Check for 'audio format not playable' errors"
    echo "  ✓ Search for tracks (should show results)"
    echo "  ✓ Remove app from recents (music should stop)"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "  ❌ BUILD FAILED!"
    echo "=========================================="
    echo ""
    echo "Troubleshooting:"
    echo "  1. Verify Android SDK path is correct"
    echo "  2. Check Java version (need JDK, not just JRE)"
    echo "  3. Run: ./gradlew clean build --stacktrace"
    echo ""
    exit 1
fi
