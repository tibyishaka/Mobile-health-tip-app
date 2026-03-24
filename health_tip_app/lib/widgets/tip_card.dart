import 'package:flutter/material.dart';
import '../models/health_tip.dart';
import '../app_theme.dart';

class TipCard extends StatelessWidget {
  final HealthTip tip;

  const TipCard({super.key, required this.tip});

  Color _getCardColor(BuildContext context, String category) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (category) {
      case 'nutrition':
        return const Color(0xFF4CAF82); // Green for nutrition
      case 'sleep':
        return AppColors.accentBlue; // Blue for sleep
      case 'mindfulness':
        return AppColors.secondary; // Soft blue for mindfulness
      default:
        return colorScheme.surface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? Colors.black : const Color(0xFFE8F5E9); // Light green for light mode
    final cardText = isDark ? Colors.white : colorScheme.primary;
    final descText = isDark ? Colors.white : colorScheme.onSurface.withOpacity(0.8);
    final borderColor = isDark ? Colors.white : const Color(0xFFB2DFDB); // Soft green border in light mode
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : cardText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tip.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : descText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              color: isDark ? Colors.black : const Color(0xFFC8E6C9), // Lighter green for icon background
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.2),
            ),
            child: Center(
              child: Text(
                tip.iconPath,
                style: TextStyle(fontSize: 40, color: isDark ? Colors.white : colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
