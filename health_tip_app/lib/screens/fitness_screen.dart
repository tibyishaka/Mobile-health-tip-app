import 'package:flutter/material.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'Fitness',
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300, // light grey background
                  borderRadius: BorderRadius.circular(15), // rounded corners
                ),
                child:  TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for topics',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.black54, size: 28),
                      onPressed:(){}
                    ),
                  ),
                )
                ),
              ),


            // Fitness Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  FitnessTipCard(
                    picture:'assets/images/warm_up.webp',
                    title: 'Start with warm-up',
                    description: 'Always begin your workout with 5-10 minutes of light cardio and dynamic stretches to prevent injuries.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  FitnessTipCard(
                    picture:'assets/images/training.webp',
                    title: 'Strength training basics',
                    description: 'Incorporate strength training 2-3 times per week focusing on major muscle groups for balanced development.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  FitnessTipCard(
                    picture:'assets/images/cardio.webp',
                    title: 'Cardio for heart health',
                    description: 'Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  FitnessTipCard(
                    picture:'assets/images/rest-sleep.webp',
                    title: 'Rest and recovery',
                    description: 'Take rest days between intense workouts to allow muscles to repair and grow stronger.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  FitnessTipCard(
                    picture:'assets/images/01.webp',
                    title: 'Proper form matters',
                    description: 'Focus on correct form rather than heavy weights to maximize results and prevent injuries.',
                  ),

                  // Card 6
                  FitnessTipCard(
                    picture:'assets/images/cons.webp',
                    title: 'Stay consistent',
                    description: 'Create a workout schedule that you can maintain long-term rather than occasional intense sessions.',
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

class FitnessTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const FitnessTipCard({
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

              // LEFT SIDE (TEXTS)
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

              // RIGHT SIDE (IMAGE)
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