import 'package:flutter/material.dart';

class _SleepTipData {
  final String picture;
  final String title;
  final String description;

  const _SleepTipData({
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

const List<_SleepTipData> _allSleepTips = [
  _SleepTipData(
    picture: 'assets/images/fitness/rest-sleep.webp',
    title: 'Establish a bedtime routine',
    description:
        'Go to bed and wake up at the same time daily, including weekends.',
  ),
  _SleepTipData(
    picture: 'assets/images/mental-health/detox.webp',
    title: 'Limit screen time before bed',
    description:
        'Avoid screens at least one hour before sleep to reduce blue light exposure.',
  ),
  _SleepTipData(
    picture: 'assets/images/fitness/warm_up.webp',
    title: 'Create a wind-down routine',
    description:
        'Use calming habits like light stretching or reading before bedtime.',
  ),
  _SleepTipData(
    picture: 'assets/images/fitness/01.webp',
    title: 'Keep your room cool',
    description:
        'A cool, dark room helps you fall asleep faster and sleep more deeply.',
  ),
  _SleepTipData(
    picture: 'assets/images/stress/deep-breathing.webp',
    title: 'Try deep breathing exercises',
    description:
        'Slow, deep breaths before bed activate the parasympathetic nervous system and promote relaxation.',
  ),
  _SleepTipData(
    picture: 'assets/images/mental-health/practice.webp',
    title: 'Avoid caffeine late in the day',
    description:
        'Caffeine can stay in your system for 6–8 hours, so avoid it after 2 PM for better sleep quality.',
  ),
  _SleepTipData(
    picture: 'assets/images/stress/time-management.webp',
    title: 'Keep a sleep journal',
    description:
        'Track your sleep patterns and habits to identify what helps or hinders your rest.',
  ),
  _SleepTipData(
    picture: 'assets/images/mental-health/self-care-routine.webp',
    title: 'Limit naps during the day',
    description:
        'If you must nap, keep it under 30 minutes and avoid napping late in the afternoon.',
  ),
];

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_SleepTipData> get _filteredTips =>
      _allSleepTips.where((tip) => tip.matches(_searchQuery)).toList();

  void _onSearchChanged(String value) {
    setState(() => _searchQuery = value);
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
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
            'Sleep',
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search sleep tips…',
                  hintStyle:
                      const TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isEmpty
                      ? const Icon(Icons.search,
                          color: Colors.black54, size: 26)
                      : IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.black54, size: 22),
                          onPressed: _clearSearch,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Result count label ───────────────────────────────────────────
            if (_searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  filtered.isEmpty
                      ? 'No results for "$_searchQuery"'
                      : '${filtered.length} result${filtered.length == 1 ? '' : 's'} for "$_searchQuery"',
                  style: TextStyle(
                    fontSize: 13,
                    color: filtered.isEmpty
                        ? Colors.redAccent
                        : Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // ── Tip list ────────────────────────────────────────────────────
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bedtime_off_outlined,
                              size: 60, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            'No sleep tips found.',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try searching with different keywords.',
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
                        return _SleepTipCard(
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

class _SleepTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;
  final String searchQuery;

  const _SleepTipCard({
    required this.title,
    required this.description,
    required this.picture,
    this.searchQuery = '',
  });

  /// Highlights matching text segments in green.
  List<TextSpan> _highlight(String text, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: text)];
    }

    final spans = <TextSpan>[];
    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }
      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            backgroundColor: Color(0xFFB2DFDB),
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = index + query.length;
    }

    return spans;
  }

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
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    children: _highlight(title, searchQuery),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green.shade700,
                      height: 1.4,
                    ),
                    children: _highlight(description, searchQuery),
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
