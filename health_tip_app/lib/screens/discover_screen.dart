import 'package:flutter/material.dart';
import 'package:health_tip_app/screens/fitness_screen.dart';
import 'package:health_tip_app/screens/mental_health_screen.dart';
import 'package:health_tip_app/screens/stress_management_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<_DiscoverTopic> _topics = const [
    _DiscoverTopic('Nutrition', 'assets/images/fitness/cons.webp', [
      'diet',
      'food',
      'healthy eating',
      'meal',
    ]),
    _DiscoverTopic('Sleep', 'assets/images/fitness/rest-sleep.webp', [
      'rest',
      'bedtime',
      'insomnia',
      'night',
    ]),
    _DiscoverTopic('Fitness', 'assets/images/fitness/training.webp', [
      'exercise',
      'workout',
      'training',
      'gym',
    ]),
    _DiscoverTopic(
      'Mental Health',
      'assets/images/mental-health/practice.webp',
      ['mind', 'wellbeing', 'emotion', 'anxiety'],
    ),
    _DiscoverTopic(
      'Stress Management',
      'assets/images/stress/deep-breathing.webp',
      ['stress', 'calm', 'relax', 'coping'],
    ),
    _DiscoverTopic(
      'Mindfulness',
      'assets/images/mental-health/self-care-routine.webp',
      ['meditation', 'present', 'awareness', 'focus'],
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_DiscoverTopic> get _filteredTopics {
    final query = _normalize(_query);
    if (query.isEmpty) {
      return _topics;
    }

    final scored = _topics
        .map((topic) => (topic: topic, score: _matchScore(topic, query)))
        .where((entry) => entry.score > 0)
        .toList();

    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.map((entry) => entry.topic).toList();
  }

  int _matchScore(_DiscoverTopic topic, String query) {
    final searchableText = topic.searchable;
    final searchableWords = searchableText
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (searchableText.contains(query)) {
      return 120 - searchableText.indexOf(query).clamp(0, 40);
    }

    if (searchableWords.any((word) => word.startsWith(query))) {
      return 95;
    }

    if (query.contains(' ') && searchableWords.any(query.contains)) {
      return 80;
    }

    if (_isSubsequence(query, searchableText)) {
      return 65;
    }

    final bestDistance = searchableWords
        .map((word) => _levenshteinDistance(query, word))
        .reduce((a, b) => a < b ? a : b);

    if (bestDistance <= 2) {
      return 55 - (bestDistance * 10);
    }

    return 0;
  }

  String _normalize(String value) {
    return value.toLowerCase().trim();
  }

  bool _isSubsequence(String needle, String haystack) {
    if (needle.isEmpty) return true;
    var index = 0;
    for (final char in haystack.split('')) {
      if (char == needle[index]) {
        index++;
        if (index == needle.length) return true;
      }
    }
    return false;
  }

  int _levenshteinDistance(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final previous = List<int>.generate(b.length + 1, (i) => i);

    for (var i = 1; i <= a.length; i++) {
      var current = i;
      for (var j = 1; j <= b.length; j++) {
        final insertCost = current + 1;
        final deleteCost = previous[j] + 1;
        final replaceCost = previous[j - 1] + (a[i - 1] == b[j - 1] ? 0 : 1);

        final next = [
          insertCost,
          deleteCost,
          replaceCost,
        ].reduce((x, y) => x < y ? x : y);
        previous[j - 1] = current;
        current = next;
      }
      previous[b.length] = current;
    }

    return previous[b.length];
  }

  @override
  Widget build(BuildContext context) {
    final filteredTopics = _filteredTopics;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'Search for topics',
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
          if (filteredTopics.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No matching topics found',
                  style: TextStyle(
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
                itemCount: filteredTopics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.86,
                ),
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  return _TopicCard(
                    topic: topic,
                    onTap: () => _handleTopicTap(context, topic.title),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _handleTopicTap(BuildContext context, String topicTitle) {
    Widget? destination;

    switch (topicTitle) {
      case 'Mental Health':
        destination = const MentalHealthScreen();
        break;
      case 'Fitness':
        destination = const FitnessScreen();
        break;
      case 'Stress Management':
        destination = const StressManagementScreen();
        break;
      case 'Nutrition':
        Navigator.of(context).pushNamed('/nutrition');
        return;
      case 'Sleep':
        Navigator.of(context).pushNamed('/sleep');
        return;
      case 'Mindfulness':
        Navigator.of(context).pushNamed('/mindfulness');
        return;
      default:
        destination = null;
    }

    if (destination != null) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => destination!));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$topicTitle details coming soon')));
  }
}

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
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.black45,
                        ),
                      );
                    },
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

class _DiscoverTopic {
  const _DiscoverTopic(this.title, this.imagePath, this.keywords);

  final String title;
  final String imagePath;
  final List<String> keywords;

  String get searchable {
    return '${title.toLowerCase()} ${keywords.join(' ').toLowerCase()}';
  }
}
