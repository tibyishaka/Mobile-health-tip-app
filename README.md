# Mobile Health Tip App

A Flutter mobile and web app that helps users discover practical wellness advice across topics such as nutrition, sleep, fitness, mindfulness, mental health, and stress management.

## Overview

Health Tip App is organized around simple, readable health content and category-based discovery. The app integrates a vibrant community aspect where users can share, upvote, and downvote health tips. It currently includes:

- A full suite of UI screens unified under a modern, adaptive green theme.
- A functional Community tips board backed by Firebase Firestore.
- Dynamic injection of trending community tips into discovery sections.
- Firebase integration for authentication (login and signup), backend data, and asset storage.
- Push and local notifications configured via flutter_local_notifications.
- App localization with multi-language support (English, French, Spanish).
- User preference state management using Provider and shared_preferences.
- Comprehensive Unit and Widget testing.

## Features

- **Unified UI Theme:** A clean, modern green-based design language that adapts beautifully to both light and dark modes.
- **Health Tip Categories:** Curated content split across Nutrition, Sleep, Fitness, Mental Health, Stress Management, and Mindfulness.
- **Community Tips & Voting:** Users can submit tips to a community feed and upvote/downvote existing tips.
- **Trending Integration:** Highly rated community tips are automatically highlighted in their respective discovery categories.
- **Authentication:** Login and Signup flows securely powered by Firebase Auth.
- **Favorites System:** Users can save their favorite tips using isolated state providers.
- **Notifications:** Built-in notification_service.dart for handling daily tips and local alerts.

## Project Structure

The Flutter source code is located inside the health_tip_app/ directory:

\health_tip_app/
  lib/
    main.dart
    app_theme.dart
    data/
      tip_repository.dart
    models/
      health_tip.dart
    providers/
      tip_provider.dart
    widgets/
      tip_card.dart
      topic_tip_card.dart
      trending_community_tips.dart
      custom_search_bar.dart
    screens/
      getting_started_screen.dart
      discover_screen.dart
      daily_tips_screen.dart
      community_tips_screen.dart
      settings_screen.dart
      nutrition_screen.dart
      sleep_screen.dart
      mindfulness_screen.dart
      fitness_screen.dart
      mental_health_screen.dart
      stress_management_screen.dart
      login_screen.dart
  test/
    models/
    providers/
    widgets/
\
## Getting Started

1. Clone the repository.
2. Change into the Flutter project directory:
   cd health_tip_app
3. Install dependencies:
   flutter pub get
4. Run the app:
   flutter run

## Current Status

The project is fully functional, passes all analyzers and flutter_test pipelines, and includes advanced state-driven UX like favorite toggling and community leaderboards. 

## Version
- Current app version: 1.0.0+1
