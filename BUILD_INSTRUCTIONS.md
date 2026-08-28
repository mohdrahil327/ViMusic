# ViMusic Local Build Instructions

## Prerequisites

1. **Java Development Kit (JDK)** - Required
   - ✅ Found: Java 24.0.1
   - Minimum required: Java 11

2. **Android SDK** - Required
   - Install from: https://developer.android.com/studio
   - Or via Android Studio

3. **Gradle** - Included in the project (wrapper)
   - ✅ Project uses Gradle 7.4

## Setup Steps

### Option 1: With Android Studio (Recommended)

1. Download and install Android Studio from https://developer.android.com/studio
2. Open the project in Android Studio
3. Let it sync and download dependencies
4. Build via: Build → Make Project (Ctrl+F9)

### Option 2: Command Line Setup

1. **Set Android SDK path** in `local.properties`:
   ```
   sdk.dir=C:\\Users\\{YourUsername}\\AppData\\Local\\Android\\sdk
   ```
   Or set environment variable:
   ```
   set ANDROID_HOME=C:\Users\{YourUsername}\AppData\Local\Android\sdk
   ```

2. **Run build command**:
   ```bash
   cd C:\Users\raish\.copilot\repos\copilot-worktrees\ViMusic\rahil729-ubiquitous-guide
   .\gradlew build
   ```

3. **For release build**:
   ```bash
   .\gradlew assembleRelease
   ```

## Testing the Bug Fixes

### After successful build:

1. **Install debug APK to emulator/device**:
   ```bash
   .\gradlew installDebug
   ```

2. **Run the app**:
   - Open ViMusic on your device/emulator
   - Test the fixed features:
     - ✅ Play songs from playlists (video ID mismatch fix)
     - ✅ Play songs to verify no "format not playable" errors
     - ✅ Search for tracks (should return results)
     - ✅ Swipe app away from recents (music should stop)

## Build Artifacts

- **Debug APK**: `app/build/outputs/apk/debug/app-debug.apk`
- **Release APK**: `app/build/outputs/apk/release/app-release.apk`

## Troubleshooting

### Error: "SDK location not found"
- Create `local.properties` with: `sdk.dir=C:\\path\\to\\android\\sdk`
- Or set `ANDROID_HOME` environment variable

### Error: "Could not find tools.jar"
- Ensure you have JDK installed (not just JRE)
- Set `JAVA_HOME` environment variable to JDK path

### Build still fails?
- Run: `.\gradlew clean build`
- Check: `.\gradlew --version` to verify Gradle setup
- Check Java: `java -version`

## Bug Fixes Included

✅ **Commit 1** (2a7a4bf): Fix video ID mismatch by prioritizing playlistSetVideoId
✅ **Commit 2** (28e7746): Fix playback, search, and background playback bugs

These fixes address:
1. Songs stuck at 0 seconds playback
2. "Audio not in playable format" errors
3. Search showing no results
4. Music continuing after app removed from recents
