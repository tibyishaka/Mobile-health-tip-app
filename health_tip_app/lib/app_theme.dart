
import 'package:flutter/material.dart';

// Custom color palette for a clean health app look
class AppColors {
  static const Color primaryBlue = Color(0xFF1976D2); // Main blue
  static const Color accentBlue = Color(0xFF2196F3); // Lighter blue
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFF5F7FA); // Very light blue/gray
  static const Color onPrimary = Color(0xFFFFFFFF); // Text on blue
  static const Color onBackground = Color(0xFF222B45); // Dark text
  static const Color onSurface = Color(0xFF222B45); // Dark text
  static const Color secondary = Color(0xFF64B5F6); // Soft blue
  static const Color error = Color(0xFFD32F2F); // Red for errors
}

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryBlue,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onPrimary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
  background: AppColors.background,
  onBackground: AppColors.onBackground,
  surface: AppColors.surface,
  onSurface: AppColors.onSurface,
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primaryBlue,
  onPrimary: AppColors.onPrimary,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onPrimary,
  error: AppColors.error,
  onError: AppColors.onPrimary,
  background: Color(0xFF121212),
  onBackground: AppColors.background,
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
