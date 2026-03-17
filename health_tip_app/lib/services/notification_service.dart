import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _remindMeKey = 'remind_me_daily_tips';
  static const int _dailyTipId = 0;

  // ─── Initialise once at app start ────────────────────────────────────────────

  static Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(initSettings);

    // Request POST_NOTIFICATIONS permission on Android 13+
    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();
  }

  // ─── Persistence helpers ──────────────────────────────────────────────────────

  /// Returns the saved reminder preference (defaults to false).
  static Future<bool> getReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_remindMeKey) ?? false;
  }

  /// Persists the reminder preference and schedules / cancels accordingly.
  static Future<void> setReminder(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_remindMeKey, enabled);

    if (enabled) {
      await _scheduleDailyTip();
    } else {
      await _plugin.cancel(_dailyTipId);
    }
  }

  // ─── Scheduling ───────────────────────────────────────────────────────────────

  static Future<void> _scheduleDailyTip() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_health_tips_channel',
      'Daily Health Tips',
      channelDescription:
          'Daily reminders to check your health tip of the day',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.periodicallyShow(
      _dailyTipId,
      '🌿 Daily Health Tip',
      'Your daily health tip is ready! Tap to boost your well-being today.',
      RepeatInterval.daily,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexact,
    );
  }

  // ─── Utility ──────────────────────────────────────────────────────────────────

  /// Cancel every scheduled notification (e.g. on logout).
  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
