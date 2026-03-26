import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/widgets/custom_search_bar.dart';
import 'package:health_tip_app/widgets/unified_tip_card.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/data/tip_repository.dart';
import 'package:health_tip_app/widgets/trending_community_tips.dart';
import 'package:provider/provider.dart';
import 'package:health_tip_app/providers/tip_provider.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TipProvider>(
        context,
        listen: false,
      ).fetchGeminiTipsForCategory(TipCategory.fitness);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tipProvider = Provider.of<TipProvider>(context);
    final geminiTips = tipProvider.getGeminiTips(TipCategory.fitness);

    final allTips =
        TipRepository.getAllTips(
            l,
          ).where((t) => t.category == TipCategory.fitness).toList()
          ..addAll(geminiTips);

    final tips = allTips.where((tip) => tip.matches(_searchQuery)).toList();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: Text(
          l.topicFitness,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: _searchController,
              hintText: l.searchFitnessHint,
              onChanged: (value) => setState(() => _searchQuery = value),
              onClear: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
            ),
            const SizedBox(height: 20),
            if (_searchQuery.isEmpty)
              TrendingCommunityTips(category: 'Fitness'),

            if (tipProvider.isLoadingGemini(TipCategory.fitness) &&
                _searchQuery.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text("Generating AI Tips..."),
                    ],
                  ),
                ),
              ),

            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  tips.isEmpty
                      ? l.noResultsFor(_searchQuery)
                      : l.searchResultsCount(tips.length, _searchQuery),
                  style: TextStyle(
                    fontSize: 13,
                    color: tips.isEmpty
                        ? Colors.redAccent
                        : Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            Expanded(
              child: tips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 56,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l.noTipsFound,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l.tryDifferentKeyword,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: tips.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return UnifiedTipCard(
                          tip: tips[index],
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
