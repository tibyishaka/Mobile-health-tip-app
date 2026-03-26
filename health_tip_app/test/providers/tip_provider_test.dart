import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:health_tip_app/providers/tip_provider.dart';

void main() {
  group('TipProvider Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Initial favorite list is empty', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = TipProvider();
      // wait a tick for _loadFavorites to complete natively
      await Future.delayed(Duration.zero);
      expect(provider.favoriteIds.isEmpty, true);
    });

    test('Loads favorites from SharedPreferences correctly', () async {
      SharedPreferences.setMockInitialValues({
        'favorite_tips': ['tip_1', 'tip_2'],
      });
      final provider = TipProvider();
      await Future.delayed(Duration.zero);
      
      expect(provider.favoriteIds.length, 2);
      expect(provider.isFavorite('tip_1'), true);
      expect(provider.isFavorite('tip_2'), true);
      expect(provider.isFavorite('tip_3'), false);
    });

    test('toggleFavorite adds and removes favorites', () async {
      final provider = TipProvider();
      await Future.delayed(Duration.zero);

      expect(provider.isFavorite('tip_1'), false);

      await provider.toggleFavorite('tip_1');
      expect(provider.isFavorite('tip_1'), true);
      expect(provider.favoriteIds.length, 1);

      await provider.toggleFavorite('tip_1');
      expect(provider.isFavorite('tip_1'), false);
      expect(provider.favoriteIds.isEmpty, true);
    });
  });
}
