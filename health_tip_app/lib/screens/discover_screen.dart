import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Build topic list from localised strings ────────────────────────────────

  List<_DiscoverTopic> _buildTopics(AppLocalizations l) => [
    _DiscoverTopic(
      routeKey: 'Nutrition',
      title: l.topicNutrition,
      imagePath: 'assets/images/fitness/cons.webp',
      keywords: l.discoverNutritionKeywords,
    ),
    _DiscoverTopic(
      routeKey: 'Sleep',
      title: l.topicSleep,
      imagePath: 'assets/images/fitness/rest-sleep.webp',
      keywords: l.discoverSleepKeywords,
    ),
    _DiscoverTopic(
      routeKey: 'Fitness',
      title: l.topicFitness,
      imagePath: 'assets/images/fitness/training.webp',
      keywords: l.discoverFitnessKeywords,
    ),
    _DiscoverTopic(
      routeKey: 'Mental Health',
      title: l.topicMentalHealth,
      imagePath: 'assets/images/mental-health/practice.webp',
      keywords: l.discoverMentalHealthKeywords,
    ),
    _DiscoverTopic(
      routeKey: 'Stress Management',
      title: l.topicStressManagement,
      imagePath: 'assets/images/stress/deep-breathing.webp',
      keywords: l.discoverStressKeywords,
    ),
    _DiscoverTopic(
      routeKey: 'Mindfulness',
      title: l.topicMindfulness,
      imagePath: 'assets/images/mental-health/self-care-routine.webp',
      keywords: l.discoverMindfulnessKeywords,
    ),
  ];

  // ── Fuzzy search ──────────────────────────────────────────────────────────

  List<_DiscoverTopic> _filteredTopics(List<_DiscoverTopic> all) {
    final query = _normalize(_query);
    if (query.isEmpty) return all;

    final scored =
        all
            .map((t) => (topic: t, score: _matchScore(t, query)))
            .where((e) => e.score > 0)
            .toList()
          ..sort((a, b) => b.score.compareTo(a.score));

    return scored.map((e) => e.topic).toList();
  }

  int _matchScore(_DiscoverTopic topic, String query) {
    final searchable = topic.searchable;
    final words = searchable
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();

    if (searchable.contains(query)) {
      return 120 - searchable.indexOf(query).clamp(0, 40);
    }
    if (words.any((w) => w.startsWith(query))) return 95;
    if (query.contains(' ') && words.any(query.contains)) return 80;
    if (_isSubsequence(query, searchable)) return 65;

    final best = words
        .map((w) => _levenshtein(query, w))
        .reduce((a, b) => a < b ? a : b);
    if (best <= 2) return 55 - best * 10;
    return 0;
  }

  String _normalize(String v) => v.toLowerCase().trim();

  bool _isSubsequence(String needle, String haystack) {
    if (needle.isEmpty) return true;
    var i = 0;
    for (final ch in haystack.split('')) {
      if (ch == needle[i] && ++i == needle.length) return true;
    }
    return false;
  }

  int _levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;
    final prev = List<int>.generate(b.length + 1, (i) => i);
    for (var i = 1; i <= a.length; i++) {
      var cur = i;
      for (var j = 1; j <= b.length; j++) {
        final next = [
          cur + 1,
          prev[j] + 1,
          prev[j - 1] + (a[i - 1] == b[j - 1] ? 0 : 1),
        ].reduce((x, y) => x < y ? x : y);
        prev[j - 1] = cur;
        cur = next;
      }
      prev[b.length] = cur;
    }
    return prev[b.length];
  }

  // ── Navigation ────────────────────────────────────────────────────────────

  void _handleTopicTap(
    BuildContext context,
    _DiscoverTopic topic,
    AppLocalizations l,
  ) {
    String? routeName;

    switch (topic.routeKey) {
      case 'Mental Health':
        routeName = '/mental-health';
        break;
      case 'Fitness':
        routeName = '/fitness';
        break;
      case 'Stress Management':
        routeName = '/stress-management';
        break;
      case 'Nutrition':
        routeName = '/nutrition';
        break;
      case 'Sleep':
        routeName = '/sleep';
        break;
      case 'Mindfulness':
        routeName = '/mindfulness';
        break;
    }

    if (routeName != null) {
      Navigator.of(context).pushNamed(routeName);
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l.topicComingSoon(topic.title))));
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final allTopics = _buildTopics(l);
    final filtered = _filteredTopics(allTopics);

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Column(
        children: [
          // ── Search bar ────────────────────────────────────────────────────
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: l.searchTopicsHint,
              hintStyle: TextStyle(color: Colors.green.shade300, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFDDE5DE),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              suffixIcon: _query.isEmpty
                  ? const Icon(Icons.search, color: Colors.black54)
                  : IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Results ───────────────────────────────────────────────────────
          if (filtered.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  l.noMatchingTopics,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.86,
                ),
                itemBuilder: (context, index) {
                  final topic = filtered[index];
                  return _TopicCard(
                    topic: topic,
                    onTap: () => _handleTopicTap(context, topic, l),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Topic card ───────────────────────────────────────────────────────────────

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.onTap});

  final _DiscoverTopic topic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: const Color(0xFFE8DDC8),
                  child: Image.asset(
                    topic.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, _, _) => const Center(
                      child: Icon(Icons.image_outlined, color: Colors.black45),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              topic.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────

class _DiscoverTopic {
  const _DiscoverTopic({
    required this.routeKey,
    required this.title,
    required this.imagePath,
    required this.keywords,
  });

  /// Fixed English key used only for routing — never shown to the user.
  final String routeKey;

  /// Localised display name.
  final String title;

  final String imagePath;

  /// Space-separated localised keywords used for fuzzy search.
  final String keywords;

  /// Combined text the search algorithm runs against.
  String get searchable => '${title.toLowerCase()} ${keywords.toLowerCase()}';
}
