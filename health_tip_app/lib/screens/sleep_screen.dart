import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/widgets/custom_search_bar.dart';
import 'package:health_tip_app/widgets/unified_tip_card.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/data/tip_repository.dart';
import 'package:health_tip_app/widgets/trending_community_tips.dart';
import 'package:provider/provider.dart';
import 'package:health_tip_app/providers/tip_provider.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TipProvider>(
        context,
        listen: false,
      ).fetchGeminiTipsForCategory(TipCategory.sleep);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final tipProvider = Provider.of<TipProvider>(context);
    final geminiTips = tipProvider.getGeminiTips(TipCategory.sleep);

    final allTips =
        TipRepository.getAllTips(
            l,
          ).where((t) => t.category == TipCategory.sleep).toList()
          ..addAll(geminiTips);

    final filtered = allTips.where((t) => t.matches(_searchQuery)).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.topicSleep,
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
              hintText: l.searchSleepHint,
              onChanged: _onSearchChanged,
              onClear: _clearSearch,
            ),
            const SizedBox(height: 20),
            if (_searchQuery.isEmpty) TrendingCommunityTips(category: 'Sleep'),
            if (tipProvider.isLoadingGemini(TipCategory.sleep) &&
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
                            Icons.bedtime_off_outlined,
                            size: 60,
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
                              fontSize: 13,
                              color: Colors.grey.shade500,
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
