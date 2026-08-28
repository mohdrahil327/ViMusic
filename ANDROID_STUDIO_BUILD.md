# Building ViMusic APK in Android Studio

## Quick Steps:

1. **Open Project in Android Studio**
   - File → Open → Select the project root folder

2. **Wait for Gradle Sync**
   - Android Studio will automatically start syncing dependencies
   - Wait for "Gradle build finished" message at bottom
   - This may take 2-5 minutes on first load

3. **Build the APK**
   - Go to: Build → Build Bundle(s) / APK(s) → Build APK(s)
   - Android Studio will compile and generate the APK
   - This takes 2-10 minutes depending on your machine

4. **Find Your APK**
   - After build completes, you'll see a notification
   - Click "locate" or find it at:
   ```
   app/build/outputs/apk/debug/app-debug.apk
   ```

## If You Get Gradle Errors:

1. **Clean and Rebuild**
   - Build → Clean Project
   - Build → Build APK(s) again

2. **Invalidate Caches**
   - File → Invalidate Caches → Invalidate and Restart
   - Let it reload and sync again

3. **Check Java Version**
   - Android Studio uses its own embedded Java (JBR)
   - It should handle compatibility automatically

## Installation on Device/Emulator:

Once APK is built:
- Connect your Android device (USB debugging enabled) OR open an emulator
- Click the notification in Android Studio or use:
  ```
  Run → Run 'app'
  ```

## Notes:
- The app-debug.apk contains all bug fixes for ViMusic
- This is a development build (debug version)
- Size should be ~25-35 MB
