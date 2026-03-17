import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class _NutritionTip {
  final String picture;
  final String title;
  final String description;

  const _NutritionTip({
    required this.picture,
    required this.title,
    required this.description,
  });

  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q);
  }
}

List<_NutritionTip> _buildTips(AppLocalizations l) => [
      _NutritionTip(
        picture: 'assets/images/fitness/cons.webp',
        title: l.nutritionTip1Title,
        description: l.nutritionTip1Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/01.webp',
        title: l.nutritionTip2Title,
        description: l.nutritionTip2Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/cardio.webp',
        title: l.nutritionTip3Title,
        description: l.nutritionTip3Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/training.webp',
        title: l.nutritionTip4Title,
        description: l.nutritionTip4Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/warm_up.webp',
        title: l.nutritionTip5Title,
        description: l.nutritionTip5Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/rest-sleep.webp',
        title: l.nutritionTip6Title,
        description: l.nutritionTip6Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/cons.webp',
        title: l.nutritionTip7Title,
        description: l.nutritionTip7Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/01.webp',
        title: l.nutritionTip8Title,
        description: l.nutritionTip8Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/training.webp',
        title: l.nutritionTip9Title,
        description: l.nutritionTip9Desc,
      ),
      _NutritionTip(
        picture: 'assets/images/fitness/cardio.webp',
        title: l.nutritionTip10Title,
        description: l.nutritionTip10Desc,
      ),
    ];

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
    final allTips = _buildTips(l);
    final filtered =
        allTips.where((t) => t.matches(_searchQuery)).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.topicNutrition,
          style: const TextStyle(
            color: Colors.black87,
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
            // ── Search bar ────────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: l.searchNutritionHint,
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isEmpty
                      ? const Icon(Icons.search,
                          color: Colors.black54, size: 28)
                      : IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.black54, size: 24),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Result count ──────────────────────────────────────────────
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  filtered.isEmpty
                      ? l.noResultsFor(_searchQuery)
                      : l.searchResultsCount(
                          filtered.length, _searchQuery),
                  style: TextStyle(
                    fontSize: 13,
                    color: filtered.isEmpty
                        ? Colors.redAccent
                        : Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // ── Tip list / empty state ────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
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
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = filtered[index];
                        return _NutritionTipCard(
                          picture: tip.picture,
                          title: tip.title,
                          description: tip.description,
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

// ── Tip card ─────────────────────────────────────────────────────────────────

class _NutritionTipCard extends StatelessWidget {
  const _NutritionTipCard({
    required this.picture,
    required this.title,
    required this.description,
    required this.searchQuery,
  });

  final String picture;
  final String title;
  final String description;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Text content ───────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HighlightedText(
                  text: title,
                  query: searchQuery,
                  baseStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _HighlightedText(
                  text: description,
                  query: searchQuery,
                  baseStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // ── Thumbnail ──────────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              picture,
              width: 110,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 110,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8DDC8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_outlined,
                    color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Highlight matching substrings ─────────────────────────────────────────────

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({
    required this.text,
    required this.query,
    required this.baseStyle,
  });

  final String text;
  final String query;
  final TextStyle baseStyle;

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Text(text, style: baseStyle);

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start), style: baseStyle));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(
            text: text.substring(start, index), style: baseStyle));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: baseStyle.copyWith(
          backgroundColor: const Color(0xFFFFE082),
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
