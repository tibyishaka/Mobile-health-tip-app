import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Center(
          child: Text(
            'Nutrition',
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
            // Search hint text
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for topics',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                        size: 28,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),

            // Nutrition tips cards
            Expanded(
              child: ListView(
                children: const [
                  NutritionTipCard(
                    picture: 'assets/images/fitness/cons.webp',
                    title: 'Increase fiber intake',
                    description:
                        'Fiber helps regulate digestion and keeps you feeling full longer.',
                  ),
                  SizedBox(height: 15),
                  NutritionTipCard(
                    picture: 'assets/images/fitness/01.webp',
                    title: 'Build balanced meals',
                    description:
                        'Fill your plate with vegetables, lean protein, healthy fats, and complex carbs.',
                  ),
                  SizedBox(height: 15),
                  NutritionTipCard(
                    picture: 'assets/images/fitness/cardio.webp',
                    title: 'Stay hydrated',
                    description:
                        'Drink water consistently throughout the day to support energy and focus.',
                  ),
                  SizedBox(height: 15),
                  NutritionTipCard(
                    picture: 'assets/images/fitness/training.webp',
                    title: 'Choose whole grains',
                    description:
                        'Prefer whole grains like oats, brown rice, and quinoa for lasting energy.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutritionTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const NutritionTipCard({
    super.key,
    required this.title,
    required this.description,
    required this.picture,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green.shade700,
                    height: 1.4,
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
            ),
          ),
        ],
      ),
    );
  }
}
