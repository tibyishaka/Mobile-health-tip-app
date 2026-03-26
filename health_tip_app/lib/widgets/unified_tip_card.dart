import 'package:flutter/material.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/providers/tip_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UnifiedTipCard extends StatelessWidget {
  final HealthTip tip;
  final String searchQuery;

  const UnifiedTipCard({super.key, required this.tip, this.searchQuery = ''});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: Colors.white, width: 1.0) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HighlightedText(
                  text: tip.title,
                  query: searchQuery,
                  baseStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _HighlightedText(
                  text: tip.description,
                  query: searchQuery,
                  baseStyle: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.green.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Consumer<TipProvider>(
                      builder: (context, provider, _) {
                        final isFavorite = provider.isFavorite(tip.id);
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? Colors.red
                                : (isDark ? Colors.white70 : Colors.grey),
                            size: 20,
                          ),
                          onPressed: () => provider.toggleFavorite(tip.id),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          visualDensity: VisualDensity.compact,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: isDark ? Colors.white70 : Colors.grey,
                        size: 20,
                      ),
                      onPressed: () {
                        Share.share(
                          '${tip.title}\n\n${tip.description}\n\nShared via Health Tips App',
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Hero(
            tag: tip.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: tip.imageAsset.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: tip.imageAsset,
                      width: 110,
                      height: 90,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 110,
                        height: 90,
                        color: const Color(0xFFE8DDC8),
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 110,
                        height: 90,
                        color: const Color(0xFFE8DDC8),
                        child: const Icon(Icons.image_outlined, color: Colors.black45),
                      ),
                    )
                  : Image.asset(
                      tip.imageAsset,
                      width: 110,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 110,
                        height: 90,
                        color: const Color(0xFFE8DDC8),
                        child: const Icon(
                          Icons.image_outlined,
                          color: Colors.black45,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

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

    final spans = <TextSpan>[];
    final lower = text.toLowerCase();
    final lowerQ = query.toLowerCase();
    int start = 0;

    while (true) {
      final idx = lower.indexOf(lowerQ, start);
      if (idx == -1) {
        spans.add(TextSpan(text: text.substring(start), style: baseStyle));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: text.substring(start, idx), style: baseStyle));
      }
      spans.add(
        TextSpan(
          text: text.substring(idx, idx + query.length),
          style: baseStyle.copyWith(
            backgroundColor: const Color(0xFFB2DFDB),
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = idx + query.length;
    }
    return RichText(text: TextSpan(children: spans));
  }
}
