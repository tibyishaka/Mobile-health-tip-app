import 'package:flutter/material.dart';

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

  static const List<_TipData> _allTips = [
    _TipData(
      picture: 'assets/images/mental-health/practice.webp',
      title: 'Practice mindfulness',
      description:
          'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/detox.webp',
      title: 'Digital detox',
      description:
          'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/journaling.webp',
      title: 'Gratitude journaling',
      description:
          'Write down three things you\'re grateful for each day to cultivate a positive mindset.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/connection.webp',
      title: 'Connect with others',
      description:
          'Maintain strong social connections by regularly reaching out to friends and family.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/self-care-routine.webp',
      title: 'Self-care routine',
      description:
          'Establish a daily self-care routine that includes activities that nourish your mental well-being.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/negative-thoughts.webp',
      title: 'Limit negative thoughts',
      description:
          'Challenge negative self-talk and replace it with positive affirmations.',
    ),
    _TipData(
      picture: 'assets/images/mental-health/counseling.webp',
      title: 'Seek professional help',
      description:
          'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.',
    ),
  ];

  List<_TipData> get _filteredTips =>
      _allTips.where((tip) => tip.matches(_searchQuery)).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTips;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: const Center(
          child: Text(
            'Mental Health',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search bar ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search mental health tips…',
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

            // ── Results ─────────────────────────────────────────────────────
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
                            'No tips found for "$_searchQuery".',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try a different keyword.',
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

// ── Tip card with optional highlight ────────────────────────────────────────

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
                child: const Icon(Icons.image_outlined, color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Highlights matching substrings in yellow ─────────────────────────────────

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
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

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
        spans.add(
            TextSpan(text: text.substring(start, index), style: baseStyle));
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: baseStyle.copyWith(
            backgroundColor: const Color(0xFFFFEB3B),
            color: Colors.black87,
          ),
        ),
      );
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
