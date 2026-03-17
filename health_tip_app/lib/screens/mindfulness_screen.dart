import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class _MindfulnessTip {
  final String picture;
  final String title;
  final String description;

  const _MindfulnessTip({
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

List<_MindfulnessTip> _buildTips(AppLocalizations l) => [
      _MindfulnessTip(
        picture: 'assets/images/mental-health/practice.webp',
        title: l.mindfulnessTip1Title,
        description: l.mindfulnessTip1Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/mental-health/self-care-routine.webp',
        title: l.mindfulnessTip2Title,
        description: l.mindfulnessTip2Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/mental-health/journaling.webp',
        title: l.mindfulnessTip3Title,
        description: l.mindfulnessTip3Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/mental-health/connection.webp',
        title: l.mindfulnessTip4Title,
        description: l.mindfulnessTip4Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/stress/Mindful walking.webp',
        title: l.mindfulnessTip5Title,
        description: l.mindfulnessTip5Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/mental-health/negative-thoughts.webp',
        title: l.mindfulnessTip6Title,
        description: l.mindfulnessTip6Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/stress/deep-breathing.webp',
        title: l.mindfulnessTip7Title,
        description: l.mindfulnessTip7Desc,
      ),
      _MindfulnessTip(
        picture: 'assets/images/mental-health/self-care-routine.webp',
        title: l.mindfulnessTip8Title,
        description: l.mindfulnessTip8Desc,
      ),
    ];

class MindfulnessScreen extends StatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  State<MindfulnessScreen> createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
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
          l.topicMindfulness,
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
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: l.searchMindfulnessHint,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isEmpty
                      ? const Icon(Icons.search,
                          color: Colors.black54, size: 26)
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

            // ── Tips list ─────────────────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 56, color: Colors.grey.shade400),
                          const SizedBox(height: 14),
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
                        return _MindfulnessTipCard(
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

class _MindfulnessTipCard extends StatelessWidget {
  const _MindfulnessTipCard({
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

// ── Highlight matching text in amber ─────────────────────────────────────────

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
          backgroundColor: Colors.amber.shade200,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
