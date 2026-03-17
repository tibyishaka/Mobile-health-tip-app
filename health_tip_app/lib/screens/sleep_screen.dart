import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

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

List<_SleepTipData> _buildSleepTips(AppLocalizations l) => [
      _SleepTipData(
        picture: 'assets/images/fitness/rest-sleep.webp',
        title: l.sleepTip1Title,
        description: l.sleepTip1Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/mental-health/detox.webp',
        title: l.sleepTip2Title,
        description: l.sleepTip2Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/fitness/warm_up.webp',
        title: l.sleepTip3Title,
        description: l.sleepTip3Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/fitness/01.webp',
        title: l.sleepTip4Title,
        description: l.sleepTip4Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/stress/deep-breathing.webp',
        title: l.sleepTip5Title,
        description: l.sleepTip5Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/mental-health/practice.webp',
        title: l.sleepTip6Title,
        description: l.sleepTip6Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/stress/time-management.webp',
        title: l.sleepTip7Title,
        description: l.sleepTip7Desc,
      ),
      _SleepTipData(
        picture: 'assets/images/mental-health/self-care-routine.webp',
        title: l.sleepTip8Title,
        description: l.sleepTip8Desc,
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

  void _onSearchChanged(String value) => setState(() => _searchQuery = value);

  void _clearSearch() {
    _searchController.clear();
    setState(() => _searchQuery = '');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final allTips = _buildSleepTips(l);
    final filtered =
        allTips.where((t) => t.matches(_searchQuery)).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l.topicSleep,
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
            // ── Search bar ──────────────────────────────────────────────────
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: l.searchSleepHint,
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

// ── Tip card ─────────────────────────────────────────────────────────────────

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

  List<TextSpan> _highlight(String text, String query, TextStyle base) {
    if (query.isEmpty) return [TextSpan(text: text, style: base)];

    final spans = <TextSpan>[];
    final lower = text.toLowerCase();
    final lowerQ = query.toLowerCase();
    int start = 0;

    while (true) {
      final idx = lower.indexOf(lowerQ, start);
      if (idx == -1) {
        spans.add(TextSpan(text: text.substring(start), style: base));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: text.substring(start, idx), style: base));
      }
      spans.add(TextSpan(
        text: text.substring(idx, idx + query.length),
        style: base.copyWith(
          backgroundColor: const Color(0xFFB2DFDB),
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = idx + query.length;
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black87,
    );
    final descStyle = TextStyle(
      fontSize: 14,
      color: Colors.green.shade700,
      height: 1.4,
    );

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
                RichText(
                  text: TextSpan(
                    children: _highlight(title, searchQuery, titleStyle),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: _highlight(description, searchQuery, descStyle),
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
