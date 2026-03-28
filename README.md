# Mobile Health Tip App

A Flutter mobile app that helps users discover practical wellness advice across six health categories: Nutrition, Sleep, Fitness, Mental Health, Stress Management, and Mindfulness. The app combines curated static content, AI-generated tips powered by Google Gemini, and a community-driven sharing board — all wrapped in a clean, adaptive green-themed UI with full dark mode and multi-language support.

---

## Features

- **Authentication:** Email/password and Google Sign-In flows powered by Firebase Auth, including email verification and password reset.
- **Health Tip Categories:** Curated tips across Nutrition, Sleep, Fitness, Mental Health, Stress Management, and Mindfulness — localised into English, French, and Spanish.
- **AI-Generated Tips:** Google Gemini (`gemini-2.5-flash`) generates 15 additional tips per category on demand, cached per session.
- **Discover Screen:** A searchable grid of all six topic categories featuring fuzzy search with Levenshtein distance ranking.
- **Community Tips Board:** Users can post, upvote, downvote, and delete tips stored in Cloud Firestore. Posts can be made anonymously or under the user's name.
- **Daily Tips & Reminders:** A featured daily tip card with a toggleable daily push notification via `flutter_local_notifications`.
- **Favorites System:** Users can save favourite tips; favourites are persisted locally via `SharedPreferences`.
- **Unified UI Theme:** A modern green-based design language (`#4CAF82`) that adapts to light and dark modes. Theme choice (Light / Dark / System) is user-selectable.
- **Multi-Language Support:** Full internationalisation via Flutter's gen-l10n tooling — English, French, and Spanish.
- **Settings:** Profile display (from Firestore), notification toggles, theme picker, and language picker.
- **Auto-Logout on Exit:** Users are automatically signed out when the app is closed on mobile platforms.

---

## Navigation Map

```
LoginScreen  ──────────────────► SignupScreen
     │
     ▼
GettingStartedScreen  (interest selection)
     │
     ▼
MainScreen  (Bottom Navigation Bar)
 ├── [Home]      HomeScreen          (featured wellness articles)
 ├── [Discover]  DiscoverScreen ─────► FitnessScreen
 │                              ├────► MentalHealthScreen
 │                              ├────► StressManagementScreen
 │                              ├────► NutritionScreen
 │                              ├────► SleepScreen
 │                              ├────► MindfulnessScreen
 │                              └────► CommunityTipsScreen
 ├── [Daily Tips] DailyTipsScreen    (tip of the day + reminders)
 └── [Settings]  SettingsScreen      (profile, theme, language, logout)
```

---

## Architecture

The app follows a layered architecture separating concerns cleanly across four layers:

```
health_tip_app/lib/
│
├── Presentation (screens/ + widgets/)
│     UI screens and reusable components. Each screen owns its
│     own local state; shared state is consumed via Provider.
│
├── State Management (providers/)
│     TipProvider (ChangeNotifier) manages favourite tip IDs
│     (persisted via SharedPreferences) and per-category Gemini
│     tip caches.
│
├── Services (services/)
│     GeminiService  — calls the Gemini API and maps JSON
│                      responses to HealthTip model objects.
│     NotificationService — schedules and cancels daily local
│                           push notifications.
│
├── Data (data/)
│     TipRepository  — returns the full list of static,
│                      localised HealthTip objects.
│
└── Models (models/)
      HealthTip      — core domain entity (id, title,
                       description, imageAsset, category,
                       isFavorite).
      TipCategory    — enum of the six wellness categories.
```

Global reactive state (theme mode and locale) is held in two `ValueNotifier` instances defined at the top level:
- `appThemeMode` in `app_theme.dart`
- `appLocale` in `app_locale.dart`

Both are listened to by `MaterialApp` directly, so theme and language changes take effect instantly without rebuilding the entire widget tree.

---

## Project Structure

```
Mobile-health-tip-app/
└── health_tip_app/
    ├── lib/
    │   ├── main.dart                        # App entry point, Firebase init, locale migration
    │   ├── app_theme.dart                   # Color palette, light/dark ColorSchemes, ValueNotifier<ThemeMode>
    │   ├── app_locale.dart                  # ValueNotifier<Locale>
    │   ├── firebase_options.dart            # Auto-generated Firebase config
    │   │
    │   ├── models/
    │   │   └── health_tip.dart              # HealthTip entity + TipCategory enum
    │   │
    │   ├── providers/
    │   │   └── tip_provider.dart            # Favourites state + Gemini tip cache
    │   │
    │   ├── services/
    │   │   ├── gemini_service.dart          # Google Gemini API integration
    │   │   └── notification_service.dart    # Daily local push notifications
    │   │
    │   ├── data/
    │   │   └── tip_repository.dart          # Static localised tips for all categories
    │   │
    │   ├── screens/
    │   │   ├── login_screen.dart            # Email + Google sign-in, password reset
    │   │   ├── signup_screen.dart           # Email + Google sign-up, email verification
    │   │   ├── getting_started_screen.dart  # Interest selection onboarding
    │   │   ├── main_screen.dart             # Bottom nav shell (IndexedStack)
    │   │   ├── home_screen.dart             # Featured wellness article cards
    │   │   ├── discover_screen.dart         # Topic grid with fuzzy search
    │   │   ├── daily_tips_screen.dart       # Tip of the day + notification toggle
    │   │   ├── community_tips_screen.dart   # Firestore-backed community board
    │   │   ├── settings_screen.dart         # Profile, theme, language, logout
    │   │   ├── fitness_screen.dart
    │   │   ├── mental_health_screen.dart
    │   │   ├── stress_management_screen.dart
    │   │   ├── nutrition_screen.dart
    │   │   ├── sleep_screen.dart
    │   │   └── mindfulness_screen.dart
    │   │
    │   ├── widgets/
    │   │   ├── tip_card.dart                # Standard tip list card
    │   │   ├── topic_tip_card.dart          # Category-specific tip card
    │   │   ├── unified_tip_card.dart        # Shared card used across screens
    │   │   ├── trending_community_tips.dart # Community tip highlights widget
    │   │   └── custom_search_bar.dart       # Reusable search input
    │   │
    │   └── l10n/
    │       ├── app_en.arb                   # English strings
    │       ├── app_fr.arb                   # French strings
    │       ├── app_es.arb                   # Spanish strings
    │       ├── app_localizations.dart       # Generated base class
    │       ├── app_localizations_en.dart
    │       ├── app_localizations_es.dart
    │       └── app_localizations_fr.dart
    │
    ├── assets/
    │   └── images/
    │       ├── fitness/                     # WebP images for fitness tips
    │       ├── mental-health/               # WebP images for mental health tips
    │       └── stress/                      # WebP images for stress tips
    │
    ├── android/                             # Android platform code + google-services.json
    ├── ios/                                 # iOS platform code
    ├── linux/                               # Linux desktop runner
    ├── macos/                               # macOS desktop runner
    ├── pubspec.yaml
    ├── l10n.yaml                            # Flutter gen-l10n configuration
    ├── analysis_options.yaml
    └── .env                                 # GEMINI_API_KEY (not committed to VCS)
```

---

## Key Dependencies

| Package | Purpose |
|---|---|
| `firebase_core` | Firebase initialisation |
| `firebase_auth` | Authentication |
| `cloud_firestore` | Community tips database |
| `firebase_storage` | Asset storage |
| `google_sign_in` | Google OAuth |
| `google_generative_ai` | Gemini AI tip generation |
| `provider` | State management |
| `flutter_local_notifications` | Daily push notifications |
| `shared_preferences` | Local persistence (favourites, settings) |
| `cached_network_image` | Efficient remote image loading |
| `share_plus` | Content sharing |
| `shimmer` | Loading skeleton UI |
| `flutter_dotenv` | Secure API key loading from `.env` |
| `intl` + `flutter_localizations` | Internationalisation |

---

## Getting Started

### Prerequisites
- Flutter SDK `^3.10.4`
- A Firebase project with Authentication, Firestore, and Storage enabled
- A Google Gemini API key

### Setup

1. **Clone the repository:**
   ```
   git clone https://github.com/your-username/Mobile-health-tip-app.git
   cd Mobile-health-tip-app/health_tip_app
   ```

2. **Install dependencies:**
   ```
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` to `android/app/`
   - Add your `GoogleService-Info.plist` to `ios/Runner/`
   - The `firebase_options.dart` file is already generated; regenerate it with `flutterfire configure` if you use a different Firebase project.

4. **Set up your Gemini API key:**
   Create a `.env` file in the `health_tip_app/` root:
   ```
   GEMINI_API_KEY=your_api_key_here
   ```

5. **Run the app:**
   ```
   flutter run
   ```

---

## Internationalisation

The app supports three locales out of the box:

| Code | Language |
|---|---|
| `en` | English |
| `fr` | Français |
| `es` | Español |

All strings are defined in `.arb` files under `lib/l10n/` and generated using Flutter's built-in `gen-l10n` tool (configured via `l10n.yaml`). The active locale is stored in `SharedPreferences` and applied at startup, with automatic migration from any legacy full-name values (e.g. `"English"` → `"en"`).

---

## Version

- **App version:** `1.0.0+1`
- **Dart SDK:** `^3.10.4`
- **Flutter:** `>=3.10.4`
