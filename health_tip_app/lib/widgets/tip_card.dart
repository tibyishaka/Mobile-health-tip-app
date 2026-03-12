import 'package:flutter/material.dart';
import '../models/health_tip.dart';

class TipCard extends StatelessWidget {
  final HealthTip tip;

  const TipCard({super.key, required this.tip});

  Color _getCardColor(String category) {
    switch (category) {
      case 'nutrition':
        return const Color(0xFFE8F5E9);
      case 'sleep':
        return const Color(0xFFFFF3E0);
      case 'mindfulness':
        return const Color(0xFFE1F5FE);
      default:
        return Colors.grey[100]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tip.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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
              color: _getCardColor(tip.category),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                tip.iconPath,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
