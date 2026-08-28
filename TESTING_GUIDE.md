# ViMusic Bug Fixes - Testing & Setup Guide

## Quick Start

You're on the branch `rahil729-vimusic-task` with 4 bug fixes ready to test.

### Windows (PowerShell)
```powershell
# Run the automated test script
.\test-local.ps1
```

### Linux/macOS (Bash)
```bash
# Make script executable and run
chmod +x test-local.sh
./test-local.sh
```

---

## Manual Setup (If Automated Script Fails)

### Prerequisites
- ✅ Java JDK 11+ (required)
- Android SDK (required)
- Git (you already have this)

### Configure Android SDK

**Option A: Environment Variable (Linux/macOS)**
```bash
export ANDROID_HOME=/path/to/android/sdk
```

**Option B: Environment Variable (PowerShell)**
```powershell
$env:ANDROID_HOME = "C:\path\to\android\sdk"
```

**Option C: local.properties File**
Create `local.properties` in the project root:
```properties
sdk.dir=C:\Users\YourName\AppData\Local\Android\sdk
```

### Build the Project

```bash
# Clean and build
./gradlew clean build -x test

# Or use the batch file (Windows)
./build.bat "C:\path\to\android\sdk"
```

---

## Testing the Bug Fixes

After successful build, test each fix:

### ✅ Fix 1: Video ID Mismatch Error
**What to test:** Play songs from playlists or radio
- Open a playlist
- Play a song
- Should NOT see: "The returned video ID doesn't match the requested one"
- Should play without error

**File Changed:** `innertube/Innertube.kt`

### ✅ Fix 2: Playback Stuck at 0 Seconds
**What to test:** Play various songs
- Play different songs
- Should NOT see: "Couldn't find a playable audio format"
- Should NOT get stuck at 0:00
- Should play smoothly

**File Changed:** `innertube/models/PlayerResponse.kt`

### ✅ Fix 3: Search Showing No Results
**What to test:** Search functionality
- Open search
- Search for a track (e.g., "Never Gonna Give You Up")
- Should show results immediately
- Should NOT show "No items found"
- Should NOT show infinite loading

**File Changed:** `innertube/requests/SearchPage.kt`

### ✅ Fix 4: Background Playback After App Close
**What to test:** App lifecycle
- Play a song
- Swipe app away from recent apps (clear from recents)
- Music should STOP immediately
- App should not restart music in background

**File Changed:** `service/PlayerService.kt`

---

## Debug Commands

If you encounter issues, use these commands:

```bash
# Full build with detailed output
./gradlew clean build --stacktrace

# Install to device
./gradlew installDebug

# Run on emulator
./gradlew :app:run

# Check gradle version
./gradlew --version

# View all tasks
./gradlew tasks
```

---

## Project Structure

```
.
├── app/                          # Main Android app
├── innertube/                    # YouTube API client
├── BUILD_INSTRUCTIONS.md         # Detailed setup guide
├── BUILD_INSTRUCTIONS.md         # Build help
├── build.bat                     # Windows build script
├── test-local.ps1               # PowerShell test script
├── test-local.sh                # Bash test script
└── local.properties.template     # SDK config template
```

---

## Commits in This Branch

```
75026ce - Add automated testing scripts for local development
c85412d - Add local build instructions and helper scripts
28e7746 - Fix playback, search, and background playback bugs
2a7a4bf - Fix video ID mismatch by prioritizing playlistSetVideoId
```

---

## Troubleshooting

### "SDK location not found"
```
Create local.properties:
sdk.dir=C:\Users\YourName\AppData\Local\Android\sdk
```

### "Could not find tools.jar"
```
Make sure you have JDK installed (not just JRE)
Set JAVA_HOME to your JDK installation path
```

### Build still fails after setup
```bash
# Clean gradle cache
./gradlew clean

# Try building again
./gradlew build --stacktrace

# Check if Android SDK is properly installed
$env:ANDROID_HOME  # PowerShell
echo $ANDROID_HOME # Bash
```

### Emulator not found
```bash
# List available emulators
emulator -list-avds

# Start an emulator
emulator -avd <emulator_name>
```

---

## Need Help?

1. Read `BUILD_INSTRUCTIONS.md` for detailed setup
2. Check Android Studio for SDK installation
3. Verify Java: `java -version`
4. Verify Gradle: `./gradlew --version`

---

## Summary

| Bug | Fix | Status |
|-----|-----|--------|
| Video ID Mismatch | Prioritize playlistSetVideoId | ✅ Fixed |
| Playback @ 0s | Fallback to any audio format | ✅ Fixed |
| No Search Results | Use first non-empty shelf | ✅ Fixed |
| Background Playback | Stop service on task removal | ✅ Fixed |

All fixes are ready for testing! 🚀
