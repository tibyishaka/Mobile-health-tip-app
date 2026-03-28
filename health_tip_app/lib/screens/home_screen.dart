import 'package:flutter/material.dart';
import 'package:health_tip_app/l10n/app_localizations.dart';
import 'package:health_tip_app/screens/article_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // Article bodies are editorial content — kept in English as a
    // CMS would normally supply them. Titles and summaries remain localised.
    final articles = [
      _ArticleData(
        title: l.article1Title,
        desc: l.article1Desc,
        readTime: l.article1ReadTime,
        imageUrl:
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&q=80',
        body: '''
Good nutrition is one of the most powerful tools you have for maintaining long-term health. What you eat directly affects your energy levels, immune function, mood, cognitive performance, and your risk of developing chronic diseases.

A balanced diet is built around whole foods: vegetables, fruits, legumes, whole grains, lean proteins, and healthy fats like those found in avocados, nuts, seeds, and olive oil. These foods are rich in fibre, vitamins, minerals, and phytonutrients that work synergistically to protect your body.

Ultra-processed foods — such as packaged snacks, sugary drinks, and fast food — are the primary driver of the global rise in obesity, type 2 diabetes, and cardiovascular disease. They tend to be calorie-dense, nutritionally poor, and engineered to make you eat more than your body needs.

Hydration is equally important. Most adults need 2–3 litres of water per day. Dehydration, even at 1–2%, impairs concentration, mood, and physical performance. Replace sugary beverages with water, herbal teas, or sparkling water.

Meal timing also matters. Eating at consistent times helps regulate your circadian rhythm and blood sugar. Skipping breakfast regularly has been associated with higher cortisol levels and poorer metabolic outcomes for many people, though individual responses vary.

Practical tips to improve your diet today:
• Fill half your plate with colourful vegetables at every meal.
• Choose whole grains (oats, brown rice, quinoa) over refined grains.
• Eat a palm-sized portion of protein at each meal to support satiety and muscle maintenance.
• Snack on nuts, seeds, or fruit instead of packaged products.
• Cook at home more often — you control the ingredients.
• Read food labels: anything with more than 5 ingredients or ingredients you can not pronounce deserves scrutiny.

Small, consistent changes compound over time. You do not need a perfect diet — you need a better average.
''',
      ),
      _ArticleData(
        title: l.article2Title,
        desc: l.article2Desc,
        readTime: l.article2ReadTime,
        imageUrl:
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&q=80',
        body: '''
Sleep is not a luxury — it is a biological necessity as fundamental as food and water. During sleep, your brain consolidates memories, your body repairs tissues, your immune system produces protective cytokines, and your hormonal systems reset. Chronic sleep deprivation is linked to increased risk of heart disease, obesity, type 2 diabetes, depression, and dementia.

Adults need 7–9 hours of quality sleep per night. Yet surveys consistently show that a large proportion of the population is chronically under-slept, often by choice — sacrificing sleep for work, screens, or entertainment.

The science of sleep hygiene:

Consistency is the single most important factor. Going to bed and waking at the same time every day — including weekends — anchors your circadian rhythm, the internal 24-hour clock that governs virtually every biological function.

Light is your most powerful circadian cue. Bright light in the morning (ideally natural sunlight within an hour of waking) advances your rhythm and boosts alertness and mood. Blue light from screens in the evening suppresses melatonin production, delaying sleep onset. Use Night Mode or blue-light-blocking glasses from sunset onward.

Temperature matters. Your core body temperature needs to drop 1–3°C to initiate sleep. A cool bedroom (16–19°C is optimal for most people) facilitates this. A warm bath or shower 1–2 hours before bed paradoxically helps by pulling blood to the skin surface and accelerating the core temperature drop.

Caffeine has a half-life of approximately 5–7 hours, meaning a 3 pm coffee still has half its dose circulating at 9 pm. Cutting off caffeine by early afternoon measurably improves sleep quality.

Alcohol is a sedative, not a sleep aid. While it may help you fall asleep faster, it fragments sleep architecture in the second half of the night, suppressing REM sleep and leaving you less restored.

If you cannot fall asleep within 20 minutes, get out of bed and do something calm in dim light until you feel sleepy. This avoids conditioning your brain to associate the bed with wakefulness.
''',
      ),
      _ArticleData(
        title: l.article3Title,
        desc: l.article3Desc,
        readTime: l.article3ReadTime,
        imageUrl:
            'https://images.unsplash.com/photo-1559825481-12a05cc00344?w=800&q=80',
        body: '''
The science on mindfulness and meditation has matured significantly over the past two decades. What was once considered alternative practice is now supported by robust evidence from neuroscience, clinical psychology, and medicine.

Mindfulness is the practice of deliberately directing your attention to present-moment experience — thoughts, sensations, emotions — with openness and without judgment. It does not require you to empty your mind or sit in silence for an hour. Even 10 minutes of daily practice produces measurable changes.

What the research shows:

Stress reduction: Mindfulness-Based Stress Reduction (MBSR), an 8-week structured programme, consistently reduces self-reported stress, anxiety, and cortisol levels. Meta-analyses show effect sizes comparable to antidepressants for mild-to-moderate anxiety.

Neuroplasticity: Regular meditation thickens the prefrontal cortex (associated with executive function and emotional regulation) and shrinks the amygdala (the brain's threat-detection centre). These structural changes have been observed after as little as 8 weeks of consistent practice.

Pain management: Mindfulness reduces the emotional suffering component of chronic pain. Studies with chronic pain patients show significant reductions in pain-related disability and opioid use.

Immune function: Several studies show that mindfulness practice increases antibody production in response to vaccination and reduces inflammatory markers.

How to start today:
• Begin with just 5 minutes of focused breathing each morning.
• Use a free app like Insight Timer or simply set a timer.
• When your mind wanders (and it will — that is not failure, that is the practice), gently return attention to the breath.
• Body scan meditations are particularly effective for sleep.
• Mindful eating, walking, and listening are ways to integrate mindfulness into daily life without extra time.

Consistency matters far more than duration. Five minutes every day outperforms 45 minutes once a week.
''',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final article = articles[index];
        return _ArticleCard(
          data: article,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailScreen(
                article: ArticleDetail(
                  title: article.title,
                  desc: article.desc,
                  readTime: article.readTime,
                  imageUrl: article.imageUrl,
                  body: article.body,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Internal data class ──────────────────────────────────────────────────────

class _ArticleData {
  final String title;
  final String desc;
  final String readTime;
  final String imageUrl;
  final String body;

  const _ArticleData({
    required this.title,
    required this.desc,
    required this.readTime,
    required this.imageUrl,
    required this.body,
  });
}

// ── Article card widget ──────────────────────────────────────────────────────

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.data, required this.onTap});

  final _ArticleData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? Colors.black : const Color(0xFFE8F5E9);
    final borderColor = isDark ? Colors.white : Colors.transparent;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final descColor = isDark ? Colors.white : Colors.grey[600];
    final readTimeColor = isDark ? Colors.white : Colors.grey[500];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
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
              // Hero image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  data.imageUrl,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      height: 190,
                      color: cardBg,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF4CAF82),
                        ),
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

              // Title
              Text(
                data.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 5),

              // Description
              Text(
                data.desc,
                style: TextStyle(fontSize: 13, color: descColor, height: 1.45),
              ),
              const SizedBox(height: 8),

              // Footer row: read time + tap hint
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.readTime,
                    style: TextStyle(fontSize: 12, color: readTimeColor),
                  ),
                  Row(
                    children: [
                      Text(
                        'Read more',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4CAF82),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11,
                        color: Color(0xFF4CAF82),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
