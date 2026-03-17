import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class _FitnessTip {
  final String picture;
  final String title;
  final String description;

  const _FitnessTip({
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

List<_FitnessTip> _buildTips(AppLocalizations l) => [
      _FitnessTip(
        picture: 'assets/images/fitness/warm_up.webp',
        title: l.fitnessTip1Title,
        description: l.fitnessTip1Desc,
      ),
      _FitnessTip(
        picture: 'assets/images/fitness/training.webp',
        title: l.fitnessTip2Title,
        description: l.fitnessTip2Desc,
      ),
      _FitnessTip(
        picture: 'assets/images/fitness/cardio.webp',
        title: l.fitnessTip3Title,
        description: l.fitnessTip3Desc,
      ),
      _FitnessTip(
        picture: 'assets/images/fitness/rest-sleep.webp',
        title: l.fitnessTip4Title,
        description: l.fitnessTip4Desc,
      ),
      _FitnessTip(
        picture: 'assets/images/fitness/01.webp',
        title: l.fitnessTip5Title,
        description: l.fitnessTip5Desc,
      ),
      _FitnessTip(
        picture: 'assets/images/fitness/cons.webp',
        title: l.fitnessTip6Title,
        description: l.fitnessTip6Desc,
      ),
    ];

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
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
    final tips =
        allTips.where((tip) => tip.matches(_searchQuery)).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Text(
          l.topicFitness,
          style: const TextStyle(
            color: Colors.black87,
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
                  hintText: l.searchFitnessHint,
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
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

            // ── Results count ─────────────────────────────────────────────
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

            // ── Tip list / empty state ────────────────────────────────────
            Expanded(
              child: tips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
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
                                color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: tips.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = tips[index];
                        return _FitnessTipCard(
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

class FitnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;
  final String searchQuery;

  const FitnessTipCard({
    super.key,
    required this.title,
    required this.description,
    required this.picture,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    return _FitnessTipCard(
      picture: picture,
      title: title,
      description: description,
      searchQuery: searchQuery,
    );
  }
}

class _FitnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;
  final String searchQuery;

  const _FitnessTipCard({
    required this.title,
    required this.description,
    required this.picture,
    this.searchQuery = '',
  });

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
          // Left side – text
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
          // Right side – image
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
                color: Colors.grey.shade300,
                child:
                    const Icon(Icons.image_outlined, color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Highlight helper ──────────────────────────────────────────────────────────

class _HighlightedText extends StatelessWidget {
  final String text;
  final String query;
  final TextStyle baseStyle;

  const _HighlightedText({
    required this.text,
    required this.query,
    required this.baseStyle,
  });

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
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: baseStyle.copyWith(
            backgroundColor: const Color(0xFFFFE082),
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = index + query.length;
    }

    return RichText(text: TextSpan(style: baseStyle, children: spans));
  }
}
