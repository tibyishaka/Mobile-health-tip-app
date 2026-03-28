# Mobile Health Tip App

A Flutter mobile app that helps users discover practical wellness advice across six health
categories: Nutrition, Sleep, Fitness, Mental Health, Stress Management, and Mindfulness.
The app combines curated static content, AI-generated tips powered by Google Gemini, and
a community-driven sharing board — all wrapped in a clean, adaptive green-themed UI with
full dark mode, a Favourites screen, article deep-dives, and multi-language support.

---

## Features

### Authentication
- Email/password sign-in and sign-up with client-side validation.
- Google Sign-In (OAuth 2.0) on both mobile and web.
- Email verification gate on login — unverified users are prompted to resend the link.
- Password reset via Firebase Auth email flow.
- **Auth-state-aware routing:** a `StreamBuilder` on `authStateChanges()` at the app root
  means already-signed-in users go straight to `MainScreen` on cold start — the login
  screen is never shown unnecessarily.
- Auto-logout when the app is closed on mobile (fires on both `AppLifecycleState.detached`
  for Android and `AppLifecycleState.paused` for iOS).

### Health Tip Categories
- Six curated categories: **Nutrition, Sleep, Fitness, Mental Health, Stress Management,
  and Mindfulness.**
- Each category screen combines static localised tips (from `TipRepository`) with
  15 AI-generated tips fetched on demand from Google Gemini.
- Per-category in-screen search with live result count and empty-state messaging.
- **Trending Community Tips** widget at the top of each category screen — surfaces
  community posts with ≥ 5 upvotes and a net score ≥ 3.

### AI-Generated Tips (Gemini)
- Model: `gemini-2.5-flash` via the `google_generative_ai` package.
- Tips are generated lazily when a category screen is opened and cached in `TipProvider`
  for the session.
- Stable, deterministic tip IDs (`gemini_<category>_<titleHashCode>`) so Favourites
  survive across sessions.
- Per-category error state exposed through `TipProvider.getGeminiError()` for graceful
  failure handling in the UI.
- API key loaded securely from a `.env` file via `flutter_dotenv` — never hard-coded.

### Discover Screen
- Searchable 2×N grid of all six topic categories.
- Fuzzy search with Levenshtein distance ranking — typos and partial matches are handled
  gracefully.
- Includes a shortcut button to the Community Tips board.

### Community Tips Board
- Firestore-backed board where users post, vote, and delete wellness tips.
- **Category filter chips** at the top to browse All / Nutrition / Sleep / Fitness /
  Mental Health / Stress Management / Mindfulness.
- **Per-user vote tracking** using `upvoterIds` / `downvoterIds` Firestore arrays.
  Votes toggle on a second tap; switching sides removes the previous vote automatically.
  Spam voting is not possible.
- **Pagination** — loads 20 tips at a time with a "Load More" button at the bottom.
- **Delete with confirmation** — a two-action `AlertDialog` must be confirmed before a
  tip is removed from Firestore.
- **Character limits** — title capped at 100 characters, description at 500, both with
  live counters that turn red near the limit.
- Posts can be made anonymously or under the user's display name.
- Author field rendered correctly on every card.

### Daily Tips Screen
- Features a **rotating tip of the day** — uses the day-of-year modulo the total number
  of static tips so a genuinely different tip is shown each calendar day.
- Displays the tip's category label, title, description, and image.
- Toggleable daily push notification via `flutter_local_notifications`; state persisted
  in `SharedPreferences`.

### Favourites
- Heart button on every tip card (static and AI-generated).
- **Dedicated Favourites tab** in the bottom navigation bar — shows all saved static and
  Gemini tips in one place.
- Favourites persist locally via `SharedPreferences` and survive app restarts.
- Because Gemini tip IDs are now stable, AI tip favourites are also preserved across
  sessions.

### Home Screen — Article Deep-Dives
- Three featured wellness article cards (Nutrition, Sleep, Mindfulness).
- Each card is **fully tappable** and navigates to `ArticleDetailScreen`.
- `ArticleDetailScreen` features a collapsing `SliverAppBar` hero image, read-time badge,
  article title, italic summary, full editorial body text, and a share button.

### Settings
- **Profile card** — shows display name (from Firestore `users` doc), email, and
  member-since date.
- **Edit name** — pencil icon next to the display name opens a dialog that updates both
  Firebase Auth `displayName` and the Firestore `users` document.
- **Daily Tip Reminder** — real notification toggle wired directly to `NotificationService`,
  replacing the previous cosmetic-only toggles.
- **Notification preferences** — three additional preference switches (New Tips, New
  Features, Updates) persisted to `SharedPreferences` for future push-notification use.
- **Theme picker** — Light / Dark / System, applied instantly via `ValueNotifier<ThemeMode>`.
- **Language picker** — English / Français / Español, applied instantly with locale
  migration for any legacy full-name values stored in `SharedPreferences`.
- **Log out** with confirmation dialog.
- **Delete Account** (Danger Zone) — two-step flow: initial confirmation + type `DELETE`
  to verify. Removes the Firestore user document and the Firebase Auth account, then
  cancels all scheduled notifications.

### Onboarding
- `GettingStartedScreen` — interest selection grid shown once to new users.
- Selected interests are **saved to Firestore** (`interests: [...]`) alongside the
  `showGettingStarted: false` flag.
- Font sizes corrected to readable sizes (title: 24pt, subtitle: 14pt).

### UI & Theming
- Material 3 design with a green-based colour palette (`#4CAF82` / `#2D8653`).
- Full light and dark mode support across all screens.
- Theme and locale changes take effect instantly via top-level `ValueNotifier` instances —
  no app restart required.
- Hero animations on tip card images.
- Shimmer loading placeholders via the `shimmer` package.
- Cached network images via `cached_network_image`.

### Internationalisation
- Three supported locales: **English (`en`)**, **Français (`fr`)**, **Español (`es`)**.
- All UI strings defined in `.arb` files under `lib/l10n/`, generated with Flutter's
  built-in `gen-l10n` tooling.
- Locale stored in `SharedPreferences`; migrates legacy full-name values automatically
  (e.g. `"English"` → `"en"`).

### Security
- Firestore Security Rules enforce authentication on all reads and writes.
- Community tip creates validate required fields, character lengths, and zero-start vote
  counters server-side.
- Votes can only modify the four vote-related fields — authors cannot be impersonated via
  a vote update.
- Only a tip's original author may delete it.
- Users can only write to their own profile document.
- API keys, `google-services.json`, `GoogleService-Info.plist`, and `firebase_options.dart`
  are all excluded from version control via `.gitignore`.

---

## Navigation Map

```
LoginScreen ────────────────────────────────► SignupScreen
     │
     │  (StreamBuilder on authStateChanges —
     │   skips login for already-signed-in users)
     │
     ▼
GettingStartedScreen  (interest selection — new users only)
     │
     ▼
MainScreen  (Bottom Navigation Bar — 5 tabs)
 │
 ├── [Home]        HomeScreen ──────────────► ArticleDetailScreen
 │
 ├── [Discover]    DiscoverScreen ───────────► FitnessScreen
 │                               ├───────────► MentalHealthScreen
 │                               ├───────────► StressManagementScreen
 │                               ├───────────► NutritionScreen
 │                               ├───────────► SleepScreen
 │                               ├───────────► MindfulnessScreen
 │                               └───────────► CommunityTipsScreen
 │
 ├── [Daily Tips]  DailyTipsScreen
 │
 ├── [Favourites]  FavoritesScreen
 │
 └── [Settings]    SettingsScreen
```

---

## Architecture

The app follows a layered architecture separating concerns across four layers:

```
health_tip_app/lib/
│
├── Presentation  (screens/ + widgets/)
│     UI screens and reusable components. Each screen owns its
│     own local state; shared state is consumed via Provider.
│
├── State Management  (providers/)
│     TipProvider (ChangeNotifier) manages:
│       • Favourite tip IDs (persisted via SharedPreferences)
│       • Per-category Gemini tip caches
│       • Per-category Gemini error states
│       • getAllCachedCategories() for the Favourites screen
│
├── Services  (services/)
│     GeminiService       — calls Gemini API, maps JSON to HealthTip
│                           objects, assigns stable category-scoped IDs,
│                           and cycles category-appropriate image assets.
│     NotificationService — schedules / cancels the daily local push
│                           notification; persists toggle state.
│
├── Data  (data/)
│     TipRepository — returns the full list of static, localised
│                     HealthTip objects for all six categories.
│
└── Models  (models/)
      HealthTip    — core domain entity (id, title, description,
                     imageAsset, category, isFavorite).
      TipCategory  — enum of the six wellness categories.
```

Global reactive state is held in two `ValueNotifier` instances defined at the top level:

| Notifier | File | Controls |
|---|---|---|
| `appThemeMode` | `app_theme.dart` | `ThemeMode` (Light / Dark / System) |
| `appLocale` | `app_locale.dart` | `Locale` (en / fr / es) |

Both are listened to by `MaterialApp` directly so changes apply instantly app-wide.

---

## Project Structure

```
Mobile-health-tip-app/
└── health_tip_app/
    ├── lib/
    │   ├── main.dart                         # Entry point · Firebase init · auth-state router
    │   ├── app_theme.dart                    # Color palette · light/dark ColorSchemes · ValueNotifier<ThemeMode>
    │   ├── app_locale.dart                   # ValueNotifier<Locale>
    │   ├── firebase_options.dart             # Auto-generated Firebase config (gitignored)
    │   │
    │   ├── models/
    │   │   └── health_tip.dart               # HealthTip entity + TipCategory enum
    │   │
    │   ├── providers/
    │   │   └── tip_provider.dart             # Favourites · Gemini cache · error state · cached categories
    │   │
    │   ├── services/
    │   │   ├── gemini_service.dart           # Gemini API · stable tip IDs · image pool assignment
    │   │   └── notification_service.dart     # Daily local push notifications
    │   │
    │   ├── data/
    │   │   └── tip_repository.dart           # Static localised tips for all six categories
    │   │
    │   ├── screens/
    │   │   ├── login_screen.dart             # Email + Google sign-in · password reset
    │   │   ├── signup_screen.dart            # Email + Google sign-up · email verification
    │   │   ├── getting_started_screen.dart   # Interest selection · saves to Firestore
    │   │   ├── main_screen.dart              # 5-tab bottom nav shell (IndexedStack)
    │   │   ├── home_screen.dart              # Featured wellness article cards
    │   │   ├── article_detail_screen.dart    # Full article view with hero image + share
    │   │   ├── discover_screen.dart          # Topic grid with Levenshtein fuzzy search
    │   │   ├── daily_tips_screen.dart        # Day-rotating tip of the day + reminder toggle
    │   │   ├── favorites_screen.dart         # All favourited static + Gemini tips
    │   │   ├── community_tips_screen.dart    # Firestore board · category filter · vote tracking · pagination
    │   │   ├── settings_screen.dart          # Profile edit · notifications · theme · language · delete account
    │   │   ├── fitness_screen.dart
    │   │   ├── mental_health_screen.dart
    │   │   ├── stress_management_screen.dart
    │   │   ├── nutrition_screen.dart
    │   │   ├── sleep_screen.dart
    │   │   └── mindfulness_screen.dart
    │   │
    │   ├── widgets/
    │   │   ├── unified_tip_card.dart         # Shared tip card with favourite + share actions
    │   │   ├── trending_community_tips.dart  # Horizontal scroll of top-rated community tips
    │   │   ├── custom_search_bar.dart        # Reusable search input with clear button
    │   │   └── tip_card.dart                 # Legacy tip card (retained for reference)
    │   │
    │   └── l10n/
    │       ├── app_en.arb                    # English strings
    │       ├── app_fr.arb                    # French strings
    │       ├── app_es.arb                    # Spanish strings
    │       ├── app_localizations.dart        # Generated base class
    │       ├── app_localizations_en.dart
    │       ├── app_localizations_es.dart
    │       └── app_localizations_fr.dart
    │
    ├── assets/
    │   └── images/
    │       ├── fitness/                      # WebP images for fitness tips
    │       ├── mental-health/                # WebP images for mental health tips
    │       └── stress/                       # WebP images for stress tips
    │
    ├── android/                              # Android platform code + google-services.json (gitignored)
    ├── ios/                                  # iOS platform code + GoogleService-Info.plist (gitignored)
    ├── firestore.rules                       # Firestore Security Rules (RBAC)
    ├── pubspec.yaml
    ├── l10n.yaml                             # Flutter gen-l10n configuration
    ├── analysis_options.yaml
    └── .env                                  # GEMINI_API_KEY — not committed to VCS
```

---

## Key Dependencies

| Package | Version | Purpose |
|---|---|---|
| `firebase_core` | ^4.5.0 | Firebase initialisation |
| `firebase_auth` | ^6.2.0 | Authentication |
| `cloud_firestore` | ^6.1.3 | Community tips database + user profiles |
| `firebase_storage` | ^13.1.0 | Asset storage |
| `google_sign_in` | ^6.2.2 | Google OAuth |
| `google_generative_ai` | ^0.4.7 | Gemini AI tip generation |
| `provider` | ^6.1.5+1 | State management |
| `flutter_local_notifications` | ^17.2.4 | Daily push notifications |
| `shared_preferences` | ^2.3.3 | Local persistence (favourites, settings, locale) |
| `cached_network_image` | ^3.4.1 | Efficient remote image loading |
| `share_plus` | ^12.0.1 | Content sharing |
| `shimmer` | ^3.0.0 | Loading skeleton UI |
| `flutter_dotenv` | ^6.0.0 | Secure API key loading from `.env` |
| `intl` | ^0.20.2 | Date formatting + internationalisation support |
| `flutter_localizations` | SDK | Localisation delegates |

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.10.4`
- Dart SDK `^3.10.4`
- A Firebase project with **Authentication**, **Cloud Firestore**, and **Storage** enabled
- A Google Gemini API key ([get one here](https://aistudio.google.com/app/apikey))

### Setup

**1. Clone the repository**

```bash
git clone https://github.com/tibyishaka/Mobile-health-tip-app.git
cd Mobile-health-tip-app/health_tip_app
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Configure Firebase**

- Download `google-services.json` from your Firebase project console and place it at
  `android/app/google-services.json`.
- Download `GoogleService-Info.plist` and place it at `ios/Runner/GoogleService-Info.plist`.
- The `firebase_options.dart` file is gitignored. Regenerate it with:

```bash
flutterfire configure
```

**4. Deploy Firestore Security Rules**

The repository includes `firestore.rules`. Deploy it to your Firebase project:

```bash
firebase deploy --only firestore:rules
```

**5. Set up your Gemini API key**

Create a `.env` file in the `health_tip_app/` root directory:

```
GEMINI_API_KEY=your_api_key_here
```

This file is listed in `.gitignore` and will never be committed.

**6. Run the app**

```bash
flutter run
```

**7. Build a release APK (Android)**

```bash
flutter build apk --release
```

---

## Firestore Security Rules

`firestore.rules` implements a Role-Based Access Control (RBAC) model:

| Collection | Read | Create | Update | Delete |
|---|---|---|---|---|
| `users` | Any authenticated user | Owner only | Owner only | Owner only |
| `communityTips` | Any authenticated user | Authenticated + `authorId == uid` + field validation | Author (any field) OR any authenticated user (vote fields only) | Author only |
| Everything else | Denied | Denied | Denied | Denied |

Vote updates are restricted to only the four vote-related fields
(`upvotes`, `downvotes`, `upvoterIds`, `downvoterIds`) via an `affectedKeys().hasOnly()`
check, preventing vote requests from silently overwriting tip content.

On `create`, the rules server-side enforce:
- All required fields are present.
- `title` is between 1 and 100 characters.
- `description` is between 1 and 500 characters.
- `upvotes` and `downvotes` both start at `0`.

---

## Internationalisation

The app supports three locales out of the box:

| Code | Language |
|---|---|
| `en` | English |
| `fr` | Français |
| `es` | Español |

All UI strings are defined in `.arb` files under `lib/l10n/` and generated using Flutter's
built-in `gen-l10n` tool configured via `l10n.yaml`. The active locale is stored in
`SharedPreferences` and applied at startup, with automatic migration from any legacy
full-name values (e.g. `"English"` → `"en"`).

To add a new locale:
1. Create `lib/l10n/app_<code>.arb` with all required keys.
2. Add the locale code to `supportedLocales` in `main.dart`.
3. Add it to the `_languages` map in `settings_screen.dart`.
4. Run `flutter gen-l10n`.

---

## Environment Variables

| Variable | Required | Description |
|---|---|---|
| `GEMINI_API_KEY` | Yes | Google Gemini API key loaded via `flutter_dotenv` |

Create `.env` in the `health_tip_app/` root. This file must never be committed.

---

## Version

| Property | Value |
|---|---|
| App version | `1.0.0+1` |
| Dart SDK | `^3.10.4` |
| Flutter | `>=3.10.4` |