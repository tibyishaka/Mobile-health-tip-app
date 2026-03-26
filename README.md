# Mobile Health Tip App

A Flutter mobile and web app that helps users discover practical wellness advice across topics such as nutrition, sleep, fitness, mindfulness, mental health, and stress management.

## Overview

Health Tip App is organized around simple, readable health content and category-based discovery. The app currently includes:

- A full suite of UI screens for topic discovery and engagement.
- Firebase integration for basic authentication (login and signup).
- Firebase Cloud Firestore and Storage for backend data and assets.
- Push and local notifications configured via `flutter_local_notifications`.
- App localization (`intl`) and theming support.
- User preference management using `shared_preferences`.

## Features

- **Health Tip Categories:** Nutrition, Sleep, Fitness, Mental Health, Stress Management, Mindfulness.
- **Authentication:** Login and Signup powered by Firebase Auth.
- **Notifications:** Built-in `notification_service.dart` for handling daily tips and local alerts.
- **Home Feed:** Article-style cards displaying curated content.
- **Localization:** Support for multiple app locales.
- **Settings Page:** Controls for notifications and preferences.

## Tech Stack

- **Frontend:** Flutter & Dart, Material 3 widgets
- **Backend & Auth:** Firebase Core, Firebase Auth, Cloud Firestore, Firebase Storage
- **Local Storage:** Shared Preferences
- **Notifications:** Flutter Local Notifications
- **Localization:** Intl

## Project Structure

The Flutter source code is located inside the `health_tip_app/` directory:

```
health_tip_app/
  lib/
    main.dart
    app_locale.dart
    app_theme.dart
    firebase_options.dart
    l10n/
    models/
      health_tip.dart
    services/
      notification_service.dart
    widgets/
      tip_card.dart
    screens/
      getting_started_screen.dart
      main_screen.dart
      home_screen.dart
      discover_screen.dart
      daily_tips_screen.dart
      settings_screen.dart
      nutrition_screen.dart
      sleep_screen.dart
      mindfulness_screen.dart
      fitness_screen.dart
      mental_health_screen.dart
      stress_management_screen.dart
      login_screen.dart
      signup_screen.dart
  assets/
    images/
      fitness/
      mental-health/
      stress/
```

## Prerequisites

- Flutter SDK installed (`environment: sdk: ^3.10.4`)
- A configured Flutter environment (`flutter doctor` shows no blocking issues)
- Android Studio / Android emulator, Xcode (for iOS), or Chrome (for web)

## Getting Started

1. Clone the repository.
2. Change into the Flutter project directory:

   ```bash
   cd health_tip_app
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

### Run on Web (Chrome)

```bash
flutter run -d chrome
```

## Testing and Analysis

- Run static analysis:

  ```bash
  flutter analyze
  ```

- Run tests:

  ```bash
  flutter test
  ```

## Assets

Assets are declared in `pubspec.yaml` under:

- `assets/images/fitness/`
- `assets/images/mental-health/`
- `assets/images/stress/`

If you add new images, keep them in these directories (or update `pubspec.yaml`) and run `flutter pub get`.

## Current Status

The project is functional and passes analyzer/tests. It has been upgraded from a UI-first architecture to include Firebase functionality, notification services, and local storage.

## Version

- Current app version: `1.0.0+1`

