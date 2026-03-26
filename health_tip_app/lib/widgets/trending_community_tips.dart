import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrendingCommunityTips extends StatelessWidget {
  final String category;

  const TrendingCommunityTips({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('communityTips')
          .where('category', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final rawTips = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        
        // Filter: upvotes > 50, downvotes < 25
        final trendingTips = rawTips.where((tip) {
          final upvotes = tip['upvotes'] as int? ?? 0;
          final downvotes = tip['downvotes'] as int? ?? 0;
          return upvotes > 50 && downvotes < 25;
        }).toList();

        // Sort by highest score
        trendingTips.sort((a, b) {
          final scoreA = (a['upvotes'] as int? ?? 0) - (a['downvotes'] as int? ?? 0);
          final scoreB = (b['upvotes'] as int? ?? 0) - (b['downvotes'] as int? ?? 0);
          return scoreB.compareTo(scoreA);
        });

        if (trendingTips.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.whatshot, color: Colors.orangeAccent),
                  const SizedBox(width: 8),
                  Text(
                    'Trending Community Tips',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: trendingTips.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final tip = trendingTips[index];
                  final score = (tip['upvotes'] as int? ?? 0) - (tip['downvotes'] as int? ?? 0);

                  return Container(
                    width: 260,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      ),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'TOP RATED',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.keyboard_arrow_up_rounded, color: Color(0xFF4CAF82), size: 16),
                                Text(
                                  '$score',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFF4CAF82),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tip['title'] as String? ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            tip['description'] as String? ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

