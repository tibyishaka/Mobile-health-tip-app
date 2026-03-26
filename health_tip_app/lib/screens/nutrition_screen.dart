import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/widgets/custom_search_bar.dart';
import 'package:health_tip_app/widgets/unified_tip_card.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/data/tip_repository.dart';
import 'package:health_tip_app/widgets/trending_community_tips.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final allTips = TipRepository.getAllTips(
      l,
    ).where((t) => t.category == TipCategory.nutrition).toList();
    final filtered = allTips.where((tip) => tip.matches(_searchQuery)).toList();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.topicNutrition,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: _searchController,
              hintText: l.searchNutritionHint,
              onChanged: (value) => setState(() => _searchQuery = value),
              onClear: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
            ),
            const SizedBox(height: 20),
            if (_searchQuery.isEmpty) TrendingCommunityTips(category: 'Nutrition'),

            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  filtered.isEmpty
                      ? l.noResultsFor(_searchQuery)
                      : l.searchResultsCount(filtered.length, _searchQuery),
                  style: TextStyle(
                    fontSize: 13,
                    color: filtered.isEmpty
                        ? Colors.redAccent
                        : Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 56,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l.noTipsFound,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l.tryDifferentKeyword,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return UnifiedTipCard(
                          tip: filtered[index],
                          searchQuery: _searchQuery,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

