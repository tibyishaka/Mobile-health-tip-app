import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class _TipData {
  final String picture;
  final String title;
  final String description;

  const _TipData({
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

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  State<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends State<MentalHealthScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_TipData> _buildTips(AppLocalizations l) => [
        _TipData(
          picture: 'assets/images/mental-health/practice.webp',
          title: l.mentalTip1Title,
          description: l.mentalTip1Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/detox.webp',
          title: l.mentalTip2Title,
          description: l.mentalTip2Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/journaling.webp',
          title: l.mentalTip3Title,
          description: l.mentalTip3Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/connection.webp',
          title: l.mentalTip4Title,
          description: l.mentalTip4Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/self-care-routine.webp',
          title: l.mentalTip5Title,
          description: l.mentalTip5Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/negative-thoughts.webp',
          title: l.mentalTip6Title,
          description: l.mentalTip6Desc,
        ),
        _TipData(
          picture: 'assets/images/mental-health/counseling.webp',
          title: l.mentalTip7Title,
          description: l.mentalTip7Desc,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final allTips = _buildTips(l);
    final filtered =
        allTips.where((tip) => tip.matches(_searchQuery)).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.topicMentalHealth,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) =>
                    setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: l.searchMentalHealthHint,
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isEmpty
                      ? const Icon(Icons.search,
                          color: Colors.black54, size: 26)
                      : IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.black54, size: 22),
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

            // ── Tip list ──────────────────────────────────────────────────
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
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final tip = filtered[index];
                        return _MentalHealthTipCard(
                          picture: tip.picture,
                          title: tip.title,
                          description: tip.description,
                          query: _searchQuery,
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

class _MentalHealthTipCard extends StatelessWidget {
  const _MentalHealthTipCard({
    required this.picture,
    required this.title,
    required this.description,
    required this.query,
  });

  final String picture;
  final String title;
  final String description;
  final String query;

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HighlightedText(
                  text: title,
                  query: query,
                  baseStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _HighlightedText(
                  text: description,
                  query: query,
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
                color: const Color(0xFFE8DDC8),
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
          backgroundColor: const Color(0xFFFFEB3B),
          color: Colors.black87,
        ),
      ));
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
