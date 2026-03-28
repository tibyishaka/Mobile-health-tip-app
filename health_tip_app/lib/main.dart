import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/screens/main_screen.dart';
import 'firebase_options.dart';
import 'package:health_tip_app/app_theme.dart';
import 'package:health_tip_app/app_locale.dart';
import 'package:health_tip_app/screens/getting_started_screen.dart';
import 'package:health_tip_app/screens/login_screen.dart';
import 'package:health_tip_app/screens/fitness_screen.dart';
import 'package:health_tip_app/screens/mental_health_screen.dart';
import 'package:health_tip_app/screens/stress_management_screen.dart';
import 'package:health_tip_app/screens/mindfulness_screen.dart';
import 'package:health_tip_app/screens/nutrition_screen.dart';
import 'package:health_tip_app/screens/signup_screen.dart';
import 'package:health_tip_app/screens/sleep_screen.dart';
import 'package:health_tip_app/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:health_tip_app/providers/tip_provider.dart';

/// Converts legacy full-name language strings ('English', 'French', 'Spanish')
/// that were saved before the l10n migration into valid BCP-47 codes.
/// Already-valid codes ('en', 'fr', 'es') are returned unchanged.
String _migrateLocaleCode(String raw) {
  switch (raw.toLowerCase()) {
    case 'english':
      return 'en';
    case 'french':
    case 'français':
      return 'fr';
    case 'spanish':
    case 'español':
      return 'es';
    default:
      return ['en', 'fr', 'es'].contains(raw) ? raw : 'en';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();

  // Restore saved locale, migrating any old full-name value to a BCP-47 code.
  final prefs = await SharedPreferences.getInstance();
  final rawLang = prefs.getString('app_language') ?? 'en';
  final langCode = _migrateLocaleCode(rawLang);
  if (langCode != rawLang) {
    // Write the normalised code back so future reads are already clean.
    await prefs.setString('app_language', langCode);
  }
  appLocale.value = Locale(langCode);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TipProvider())],
      child: const HealthTipsApp(),
    ),
  );
}

class HealthTipsApp extends StatelessWidget {
  const HealthTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AutoLogoutOnExit(child: _AppShell());
  }
}

class _AppShell extends StatelessWidget {
  const _AppShell();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, mode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: appLocale,
          builder: (context, locale, _) {
            return MaterialApp(
              title: 'Health Tips',
              debugShowCheckedModeBanner: false,

              // ── Localisation ──────────────────────────────────────────────
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,

              // ── Theme ─────────────────────────────────────────────────────
              themeMode: mode,
              theme: ThemeData(
                colorScheme: lightColorScheme,
                useMaterial3: true,
                scaffoldBackgroundColor: lightColorScheme.background,
                appBarTheme: AppBarTheme(
                  backgroundColor: lightColorScheme.primary,
                  foregroundColor: lightColorScheme.onPrimary,
                  elevation: 0,
                  iconTheme: IconThemeData(color: lightColorScheme.onPrimary),
                  titleTextStyle: TextStyle(
                    color: lightColorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                textTheme: ThemeData.light().textTheme.apply(
                  bodyColor: lightColorScheme.onBackground,
                  displayColor: lightColorScheme.onBackground,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: lightColorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: lightColorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: lightColorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                buttonTheme: ButtonThemeData(
                  buttonColor: lightColorScheme.primary,
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                useMaterial3: true,
                scaffoldBackgroundColor: darkColorScheme.background,
                appBarTheme: AppBarTheme(
                  backgroundColor: darkColorScheme.primary,
                  foregroundColor: darkColorScheme.onPrimary,
                  elevation: 0,
                  iconTheme: IconThemeData(color: darkColorScheme.onPrimary),
                  titleTextStyle: TextStyle(
                    color: darkColorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: darkColorScheme.onBackground,
                  displayColor: darkColorScheme.onBackground,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: darkColorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: darkColorScheme.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: darkColorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                buttonTheme: ButtonThemeData(
                  buttonColor: darkColorScheme.primary,
                  textTheme: ButtonTextTheme.primary,
                ),
              ),

              // ── Routes ────────────────────────────────────────────────────
              routes: {
                '/login': (context) => const LoginScreen(),
                '/signup': (context) => const SignupScreen(),
                '/getting-started': (context) => const GettingStartedScreen(),
                '/main': (context) => const MainScreen(),
                '/nutrition': (context) => const NutritionScreen(),
                '/sleep': (context) => const SleepScreen(),
                '/mindfulness': (context) => const MindfulnessScreen(),
                '/fitness': (context) => const FitnessScreen(),
                '/mental-health': (context) => const MentalHealthScreen(),
                '/stress-management': (context) =>
                    const StressManagementScreen(),
              },
              // Auth-aware home: skip the login screen for already-signed-in users.
              home: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  // Still resolving — show a neutral splash
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const _SplashScreen();
                  }
                  // No user → show login
                  if (snapshot.data == null) {
                    return const LoginScreen();
                  }
                  // User is logged in → check onboarding flag
                  return _AuthenticatedRouter(user: snapshot.data!);
                },
              ),
            );
          },
        );
      },
    );
  }
}

// ── Splash shown while auth state is resolving ────────────────────────────────

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: Color(0xFF4CAF82))),
    );
  }
}

// ── Routes already-authenticated users past the login screen ─────────────────
//
// Checks Firestore for the `showGettingStarted` flag so users who signed up
// but closed the app before completing onboarding are still directed there.

class _AuthenticatedRouter extends StatefulWidget {
  const _AuthenticatedRouter({required this.user});

  final User user;

  @override
  State<_AuthenticatedRouter> createState() => _AuthenticatedRouterState();
}

class _AuthenticatedRouterState extends State<_AuthenticatedRouter> {
  late Future<Widget> _destinationFuture;

  @override
  void initState() {
    super.initState();
    _destinationFuture = _resolveDestination();
  }

  Future<Widget> _resolveDestination() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.uid)
          .get();
      final data = doc.data();
      if (data?['showGettingStarted'] == true) {
        return const GettingStartedScreen();
      }
    } catch (_) {
      // If Firestore is unreachable, default to main screen.
    }
    return const MainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _destinationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _SplashScreen();
        }
        return snapshot.data ?? const MainScreen();
      },
    );
  }
}

// ── Auto-logout on app close (mobile only) ────────────────────────────────────

class _AutoLogoutOnExit extends StatefulWidget {
  const _AutoLogoutOnExit({required this.child});

  final Widget child;

  @override
  State<_AutoLogoutOnExit> createState() => _AutoLogoutOnExitState();
}

class _AutoLogoutOnExitState extends State<_AutoLogoutOnExit>
    with WidgetsBindingObserver {
  bool _isSigningOut = false;

  bool get _isPhonePlatform {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _signOutIfNeeded() async {
    if (!_isPhonePlatform || _isSigningOut) return;
    if (FirebaseAuth.instance.currentUser == null) return;

    _isSigningOut = true;
    try {
      await FirebaseAuth.instance.signOut();
    } finally {
      _isSigningOut = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // `detached` fires reliably on Android; `paused` covers iOS app-close.
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      _signOutIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
