import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _ArticleCard(
          title: l.article1Title,
          desc: l.article1Desc,
          readTime: l.article1ReadTime,
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&q=80',
        ),
        const SizedBox(height: 20),
        _ArticleCard(
          title: l.article2Title,
          desc: l.article2Desc,
          readTime: l.article2ReadTime,
          imageUrl:
              'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&q=80',
        ),
        const SizedBox(height: 20),
        _ArticleCard(
          title: l.article3Title,
          desc: l.article3Desc,
          readTime: l.article3ReadTime,
          imageUrl:
              'https://images.unsplash.com/photo-1559825481-12a05cc00344?w=800&q=80',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.title,
    required this.desc,
    required this.readTime,
    required this.imageUrl,
  });

  final String title;
  final String desc;
  final String readTime;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? Colors.black : const Color(0xFFE8F5E9);
    final borderColor = isDark ? Colors.white : Colors.transparent;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final descColor = isDark ? Colors.white : Colors.grey[600];
    final readTimeColor = isDark ? Colors.white : Colors.grey[500];

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 190,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 190,
                  color: cardBg,
                  child: Center(
                    child: CircularProgressIndicator(color: isDark ? Colors.white : const Color(0xFF4CAF82)),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 190,
                color: cardBg,
                child: Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: titleColor,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            desc,
            style: TextStyle(
                fontSize: 13, color: descColor, height: 1.45),
          ),
          const SizedBox(height: 5),
          Text(
            readTime,
            style: TextStyle(fontSize: 12, color: readTimeColor),
          ),
        ],
      ),
    );
  }
}
