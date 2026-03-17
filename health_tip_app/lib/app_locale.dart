import 'package:flutter/material.dart';

/// Global locale notifier — updated by the Settings screen and persisted via
/// SharedPreferences. The [MaterialApp] listens to this to rebuild with the
/// chosen language.
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));
