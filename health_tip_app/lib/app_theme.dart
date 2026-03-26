import 'package:flutter/material.dart';

// Custom color palette for a clean health app look
class AppColors {
  static const Color primaryGreen = Color(0xFF4CAF82); // Main green from login
  static const Color accentGreen = Color(0xFF2D8653); // Darker green from login
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF5F7FA); // Very light blue/gray
  static const Color onPrimary = Color(0xFFFFFFFF); // Text on green
  static const Color onBackground = Color(0xFF222B45); // Dark text
  static const Color onSurface = Color(0xFF222B45); // Dark text
  static const Color secondary = Color(0xFF81C784); // Soft green
  static const Color error = Color(0xFFD32F2F); // Red for errors
}

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryGreen,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onPrimary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primaryGreen,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onPrimary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
  surface: Color(0xFF1E1E1E),
  onSurface: AppColors.background,
);

final ValueNotifier<ThemeMode> appThemeMode = ValueNotifier(ThemeMode.system);

String themeModeLabel(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return 'Light';
    case ThemeMode.dark:
      return 'Dark';
    case ThemeMode.system:
      return 'System';
  }
}

ThemeMode themeModeFromLabel(String label) {
  switch (label) {
    case 'Light':
      return ThemeMode.light;
    case 'Dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}
