import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_tip_app/providers/tip_provider.dart';
import 'package:health_tip_app/data/tip_repository.dart';
import 'package:health_tip_app/widgets/unified_tip_card.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<TipProvider>(
      builder: (context, provider, _) {
        final favoriteIds = provider.favoriteIds;

        // Gather all static tips that match favorited IDs
        final allStaticTips = TipRepository.getAllTips(l);
        final favoritedStaticTips = allStaticTips
            .where((t) => favoriteIds.contains(t.id))
            .toList();

        // Also gather favorited Gemini tips from the provider cache
        final favoritedGeminiTips = <dynamic>[];
        for (final category in provider.getAllCachedCategories()) {
          for (final tip in provider.getGeminiTips(category)) {
            if (favoriteIds.contains(tip.id)) {
              favoritedGeminiTips.add(tip);
            }
          }
        }

        final allFavorited = [...favoritedStaticTips, ...favoritedGeminiTips];

        if (allFavorited.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite_border_rounded,
                  size: 72,
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
                const SizedBox(height: 20),
                Text(
                  'No favourites yet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the ♥ on any tip to save it here.',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: allFavorited.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return UnifiedTipCard(tip: allFavorited[index]);
          },
        );
      },
    );
  }
}
