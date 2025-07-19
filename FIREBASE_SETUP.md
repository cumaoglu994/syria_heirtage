# Firebase Setup Guide

## Current Status
Your app is now configured to run without Firebase configuration files. The app will continue to work for development purposes, but Firebase features (authentication, database, storage, etc.) will not be available.

## To Enable Firebase Features

### 1. Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter your project name (e.g., "syria-heritage")
4. Follow the setup wizard

### 2. Add Android App
1. In Firebase Console, click the Android icon
2. Enter your package name: `com.example.syria_heirtage`
3. Enter app nickname (optional)
4. Click "Register app"
5. Download the `google-services.json` file
6. Place it in `android/app/google-services.json`

### 3. Add iOS App (if needed)
1. In Firebase Console, click the iOS icon
2. Enter your bundle ID: `com.example.syriaHeirtage`
3. Enter app nickname (optional)
4. Click "Register app"
5. Download the `GoogleService-Info.plist` file
6. Place it in `ios/Runner/GoogleService-Info.plist`

### 4. Update Configuration Files
Replace the placeholder values in:
- `android/app/google-services.json`
- `android/app/src/main/res/values/values.xml`

### 5. Enable Firebase Services
In Firebase Console, enable the services you need:
- **Authentication** - for user login/signup
- **Firestore Database** - for storing app data
- **Storage** - for storing images/files
- **Analytics** - for app usage analytics
- **Messaging** - for push notifications

### 6. Update App Configuration
Update `lib/core/config/app_config.dart` with your Firebase project settings.

## Testing Firebase
After setup, run the app and check the console output:
- If you see "Firebase initialized successfully", Firebase is working
- If you see "Firebase initialization failed", check your configuration files

## Troubleshooting
- Ensure `google-services.json` is in the correct location
- Check that package names match exactly
- Verify Firebase project settings
- Make sure all required Firebase services are enabled

## Development vs Production
- **Development**: App works without Firebase (current setup)
- **Production**: Requires proper Firebase configuration for full functionality 