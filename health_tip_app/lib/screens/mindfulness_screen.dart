import 'package:flutter/material.dart';

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

const List<_MindfulnessTip> _allTips = [
  _MindfulnessTip(
    picture: 'assets/images/mental-health/practice.webp',
    title: 'Practice deep breathing',
    description:
        'Take slow, deep breaths for a few minutes to calm the mind and body.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/mental-health/self-care-routine.webp',
    title: 'Try meditation',
    description:
        'Begin with five minutes daily and gradually increase your practice time.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/mental-health/journaling.webp',
    title: 'Journal your thoughts',
    description:
        'Write down thoughts and emotions to increase awareness and reduce stress.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/mental-health/connection.webp',
    title: 'Be present in the moment',
    description:
        'Focus on what you can see, hear, and feel without judging the experience.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/stress/Mindful walking.webp',
    title: 'Mindful walking',
    description:
        'Walk slowly and pay close attention to each step, your breath, and your surroundings.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/mental-health/negative-thoughts.webp',
    title: 'Observe your thoughts',
    description:
        'Notice your thoughts as they arise without attaching to them — let them pass like clouds.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/stress/deep-breathing.webp',
    title: 'Body scan relaxation',
    description:
        'Slowly move your attention through each part of your body, releasing tension as you go.',
  ),
  _MindfulnessTip(
    picture: 'assets/images/mental-health/self-care-routine.webp',
    title: 'Single-tasking',
    description:
        'Focus on one task at a time with full attention instead of multitasking throughout the day.',
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

  List<_MindfulnessTip> get _filteredTips =>
      _allTips.where((tip) => tip.matches(_searchQuery)).toList();

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
            'Mindfulness',
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
            // ── Search bar ────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'Search mindfulness tips…',
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
                      ? 'No results found'
                      : '${filtered.length} result${filtered.length == 1 ? '' : 's'} for "$_searchQuery"',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // ── Tips list ────────────────────────────────────────────────
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
                            'No mindfulness tips found.\nTry a different keyword.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade500,
                              height: 1.5,
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

class _MindfulnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;
  final String query;

  const _MindfulnessTipCard({
    required this.title,
    required this.description,
    required this.picture,
    required this.query,
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
          // ── Text ─────────────────────────────────────────────────────
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
          // ── Image ────────────────────────────────────────────────────
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

/// Renders [text] with occurrences of [query] highlighted in amber.
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
