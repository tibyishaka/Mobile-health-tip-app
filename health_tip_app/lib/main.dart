import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:health_tip_app/app_theme.dart';
import 'package:health_tip_app/screens/getting_started_screen.dart';
import 'package:health_tip_app/screens/login_screen.dart';
import 'package:health_tip_app/screens/mindfulness_screen.dart';
import 'package:health_tip_app/screens/nutrition_screen.dart';
import 'package:health_tip_app/screens/signup_screen.dart';
import 'package:health_tip_app/screens/sleep_screen.dart';
import 'package:health_tip_app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  runApp(const HealthTipsApp());
}

class HealthTipsApp extends StatelessWidget {
  const HealthTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Health Tips',
          debugShowCheckedModeBanner: false,
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
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/getting-started': (context) => const GettingStartedScreen(),
            '/nutrition': (context) => const NutritionScreen(),
            '/sleep': (context) => const SleepScreen(),
            '/mindfulness': (context) => const MindfulnessScreen(),
          },
          home: const LoginScreen(),
        );
      },
    );
  }
}
