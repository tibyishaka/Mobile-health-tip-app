import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/models/health_tip.dart';

void main() {
  group('HealthTip Model Unit Tests', () {
    test('should create HealthTip with all required fields', () {
      final tip = HealthTip(
        title: 'Drink Water',
        description: 'Stay hydrated by drinking 8 glasses of water daily',
        iconPath: '💧',
        category: 'nutrition',
      );

      expect(tip.title, 'Drink Water');
      expect(tip.description, 'Stay hydrated by drinking 8 glasses of water daily');
      expect(tip.iconPath, '💧');
      expect(tip.category, 'nutrition');
    });

    test('should create HealthTip with different categories', () {
      final nutritionTip = HealthTip(
        title: 'Eat Vegetables',
        description: 'Include 5 servings of vegetables daily',
        iconPath: '🥗',
        category: 'nutrition',
      );

      final sleepTip = HealthTip(
        title: 'Sleep Early',
        description: 'Get 7-8 hours of sleep each night',
        iconPath: '😴',
        category: 'sleep',
      );

      final mindfulnessTip = HealthTip(
        title: 'Meditate Daily',
        description: 'Practice 10 minutes of meditation',
        iconPath: '🧘',
        category: 'mindfulness',
      );

      expect(nutritionTip.category, 'nutrition');
      expect(sleepTip.category, 'sleep');
      expect(mindfulnessTip.category, 'mindfulness');
    });

    test('should handle empty strings in fields', () {
      final tip = HealthTip(
        title: '',
        description: '',
        iconPath: '',
        category: '',
      );

      expect(tip.title, '');
      expect(tip.description, '');
      expect(tip.iconPath, '');
      expect(tip.category, '');
    });

    test('should handle long text in description', () {
      final longDescription = 'A' * 500;
      final tip = HealthTip(
        title: 'Long Tip',
        description: longDescription,
        iconPath: '📝',
        category: 'general',
      );

      expect(tip.description.length, 500);
      expect(tip.description, longDescription);
    });

    test('should handle special characters in fields', () {
      final tip = HealthTip(
        title: 'Test & Special <chars>',
        description: 'Description with "quotes" and \'apostrophes\'',
        iconPath: '🌟✨🎉',
        category: 'special-category',
      );

      expect(tip.title, contains('&'));
      expect(tip.title, contains('<chars>'));
      expect(tip.description, contains('"quotes"'));
      expect(tip.iconPath, '🌟✨🎉');
    });
  });
}
