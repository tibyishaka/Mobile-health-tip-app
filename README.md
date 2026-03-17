# Health Tip App

A Flutter mobile and web app that helps users discover practical wellness advice across topics such as nutrition, sleep, fitness, mindfulness, mental health, and stress management.

## Overview

Health Tip App is organized around simple, readable health content and category-based discovery. The app currently includes:

- A getting-started interest selection screen
- Bottom navigation with Home, Discover, Daily Tips, and Settings
- Topic-specific tip screens with text and image cards
- Basic authentication UI screens (login and signup)

## Features

- Curated health tip categories:
  - Nutrition
  - Sleep
  - Fitness
  - Mental Health
  - Stress Management
  - Mindfulness
- Topic cards with local assets
- Home feed with article-style cards
- Daily tip with reminder toggle (UI-level)
- Settings page with notification and preference controls (UI-level)
- Flutter web support (run on Chrome)

## Tech Stack

- Flutter
- Dart
- Material 3 widgets
- Local image assets (WebP)

## Project Structure

```
lib/
	main.dart
	models/
		health_tip.dart
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
test/
	widget_test.dart
```

## Prerequisites

- Flutter SDK installed
- A configured Flutter environment (`flutter doctor` shows no blocking issues)
- One of the following:
  - Chrome (for web)
  - Android Studio / Android emulator
  - Xcode (for iOS on macOS)

## Getting Started

1. Clone the repository.
2. Open the project folder:

   `Mobile-health-tip-app/health_tip_app`

3. Install dependencies:

   `flutter pub get`

4. Run the app:

   `flutter run`

### Run on Web (Chrome)

`flutter run -d chrome`

## Testing and Analysis

- Run static analysis:

  `flutter analyze`

- Run tests:

  `flutter test`

## Assets

Assets are declared in `pubspec.yaml` under:

- `assets/images/fitness/`
- `assets/images/mental-health/`
- `assets/images/stress/`

If you add new images, keep them in these directories (or update `pubspec.yaml`) and run:

`flutter pub get`

## Current Status

The project is functional and passes analyzer/tests, with a UI-first architecture suitable for coursework and incremental enhancement.

## Known Limitations

- Some search fields are visual placeholders and do not filter content yet
- Settings and reminder toggles are not persisted across app restarts
- Navigation is partly mixed between named routes and direct route pushes
- Test coverage currently focuses on one primary flow

## Recommended Next Improvements

1. Add persistent local storage for settings and reminder state.
2. Consolidate repeated tip card/list logic into reusable widgets and data sources.
3. Implement real search/filter behavior in Discover and topic screens.
4. Expand widget and integration tests for navigation and forms.
5. Add backend/auth integration if account features are required.

## Version

- Current app version: `1.0.0+1`

## License

No license file is currently included. Add a `LICENSE` file if you plan to share or distribute this project.
