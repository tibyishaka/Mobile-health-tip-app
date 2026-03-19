import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/screens/main_screen.dart';
import 'firebase_options.dart';
import 'package:health_tip_app/app_theme.dart';
import 'package:health_tip_app/app_locale.dart';
import 'package:health_tip_app/screens/getting_started_screen.dart';
import 'package:health_tip_app/screens/login_screen.dart';
import 'package:health_tip_app/screens/mindfulness_screen.dart';
import 'package:health_tip_app/screens/nutrition_screen.dart';
import 'package:health_tip_app/screens/signup_screen.dart';
import 'package:health_tip_app/screens/sleep_screen.dart';
import 'package:health_tip_app/services/notification_service.dart';

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

  runApp(const HealthTipsApp());
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
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF4CAF82),
                  brightness: Brightness.light,
                ),
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF4CAF82),
                  brightness: Brightness.dark,
                ),
                useMaterial3: true,
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
              },
              home: const LoginScreen(),
            );
          },
        );
      },
    );
  }
}

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
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _signOutIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
