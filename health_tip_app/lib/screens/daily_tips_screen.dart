import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/services/notification_service.dart';
import 'package:health_tip_app/data/tip_repository.dart';
import 'package:health_tip_app/models/health_tip.dart';

class DailyTipsScreen extends StatefulWidget {
  const DailyTipsScreen({super.key});

  @override
  State<DailyTipsScreen> createState() => _DailyTipsScreenState();
}

class _DailyTipsScreenState extends State<DailyTipsScreen> {
  bool _remindMe = false;
  bool _loadingReminder = true;

  @override
  void initState() {
    super.initState();
    _loadReminderState();
  }

  Future<void> _loadReminderState() async {
    final enabled = await NotificationService.getReminderEnabled();
    if (mounted) {
      setState(() {
        _remindMe = enabled;
        _loadingReminder = false;
      });
    }
  }

  Future<void> _toggleReminder(bool value) async {
    final l = AppLocalizations.of(context)!;
    setState(() => _remindMe = value);
    await NotificationService.setReminder(value);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? l.remindersEnabled : l.remindersDisabled),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Picks a different tip each calendar day, cycling through all static tips.
  HealthTip _getTodaysTip(AppLocalizations l) {
    final allTips = TipRepository.getAllTips(l);
    final dayOfYear = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return allTips[dayOfYear % allTips.length];
  }

  String _categoryLabel(TipCategory category, AppLocalizations l) {
    switch (category) {
      case TipCategory.fitness:
        return l.topicFitness;
      case TipCategory.nutrition:
        return l.topicNutrition;
      case TipCategory.mentalHealth:
        return l.topicMentalHealth;
      case TipCategory.sleep:
        return l.topicSleep;
      case TipCategory.stressManagement:
        return l.topicStressManagement;
      case TipCategory.mindfulness:
        return l.topicMindfulness;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final todaysTip = _getTodaysTip(l);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Text(
            l.tipOfTheDay,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),

          // Daily tip card — rotates every day
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                width: 1,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Image.asset(
                    todaysTip.imageAsset,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 200,
                      color: const Color(0xFF4CAF82).withOpacity(0.15),
                      child: const Center(
                        child: Icon(
                          Icons.spa,
                          size: 64,
                          color: Color(0xFF4CAF82),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF82).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _categoryLabel(todaysTip.category, l).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4CAF82),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        todaysTip.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        todaysTip.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Remind Me card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                width: 1,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF82).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications_active_rounded,
                        color: Color(0xFF4CAF82),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.remindMe,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l.remindMeSubtitle,
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _loadingReminder
                        ? const SizedBox(
                            width: 50,
                            height: 24,
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFF4CAF82),
                                ),
                              ),
                            ),
                          )
                        : Switch(
                            value: _remindMe,
                            onChanged: _toggleReminder,
                            activeColor: Colors.white,
                            activeTrackColor: const Color(0xFF4CAF82),
                            inactiveThumbColor: isDark
                                ? Colors.grey.shade400
                                : Colors.white,
                            inactiveTrackColor: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300,
                          ),
                  ],
                ),
                if (_remindMe) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      height: 1,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xFF4CAF82),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.reminderBannerText,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
