import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/models/health_tip.dart';

void main() {
  group('HealthTip Model Unit Tests', () {
    test('should create HealthTip with all required fields', () {
      final tip = HealthTip(
        id: '1',
        title: 'Drink Water',
        description: 'Stay hydrated by drinking 8 glasses of water daily',
        imageAsset: 'assets/images/fitness/cons.webp',
        category: TipCategory.nutrition,
      );

      expect(tip.title, 'Drink Water');
      expect(tip.description, 'Stay hydrated by drinking 8 glasses of water daily');
      expect(tip.imageAsset, 'assets/images/fitness/cons.webp');
      expect(tip.category, TipCategory.nutrition);
    });

    test('should create HealthTip with different categories', () {
      final nutritionTip = HealthTip(
        id: '2',
        title: 'Eat Vegetables',
        description: 'Include 5 servings of vegetables daily',
        imageAsset: 'assets/images/fitness/cons.webp',
        category: TipCategory.nutrition,
      );

      final sleepTip = HealthTip(
        id: '3',
        title: 'Sleep Early',
        description: 'Get 7-8 hours of sleep each night',
        imageAsset: 'assets/images/fitness/rest-sleep.webp',
        category: TipCategory.sleep,
      );

      final mindfulnessTip = HealthTip(
        id: '4',
        title: 'Meditate Daily',
        description: 'Practice 10 minutes of meditation',
        imageAsset: 'assets/images/mental-health/self-care-routine.webp',
        category: TipCategory.mindfulness,
      );

      expect(nutritionTip.category, TipCategory.nutrition);
      expect(sleepTip.category, TipCategory.sleep);
      expect(mindfulnessTip.category, TipCategory.mindfulness);
    });

    test('should handle empty strings in fields', () {
      final tip = HealthTip(
        id: '',
        title: '',
        description: '',
        imageAsset: '',
        category: TipCategory.fitness,
      );

      expect(tip.title, '');
      expect(tip.description, '');
      expect(tip.imageAsset, '');
      expect(tip.category, TipCategory.fitness);
    });

    test('should handle long text in description', () {
      final longDescription = 'A' * 500;
      final tip = HealthTip(
        id: '5',
        title: 'Long Tip',
        description: longDescription,
        imageAsset: 'assets/images/placeholder.webp',
        category: TipCategory.mentalHealth,
      );

      expect(tip.description.length, 500);
      expect(tip.description, longDescription);
    });

    test('should handle special characters in fields', () {
      final tip = HealthTip(
        id: '6',
        title: 'Test & Special <chars>',
        description: 'Description with "quotes" and \'apostrophes\'',
        imageAsset: 'assets/images/special.webp',
        category: TipCategory.stressManagement,
      );

      expect(tip.title, contains('&'));
      expect(tip.title, contains('<chars>'));
      expect(tip.description, contains('"quotes"'));
      expect(tip.imageAsset, 'assets/images/special.webp');
    });
  });
}
