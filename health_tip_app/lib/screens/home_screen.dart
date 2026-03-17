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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            height: 190,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 190,
                color: const Color(0xFFE8F5E9),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF4CAF82)),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 190,
              color: const Color(0xFFE8F5E9),
              child: const Icon(
                Icons.image_outlined,
                size: 48,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          desc,
          style: TextStyle(
              fontSize: 13, color: Colors.grey[600], height: 1.45),
        ),
        const SizedBox(height: 5),
        Text(
          readTime,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
      ],
    );
  }
}
