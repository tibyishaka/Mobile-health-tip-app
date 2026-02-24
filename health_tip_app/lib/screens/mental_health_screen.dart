import 'package:flutter/material.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Center(
          child: Text(
            'Mental Health',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body:  Padding(
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

            // Mental Health Tips Cards
            Expanded(
              child: ListView(
                children: const [
                  // Card 1
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/practice.webp',
                    title: 'Practice mindfulness',
                    description: 'Take 10 minutes daily to focus on the present moment through meditation or deep breathing exercises.',
                  ),
                  SizedBox(height: 15),

                  // Card 2
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/detox.webp',
                    title: 'Digital detox',
                    description: 'Set aside time each day to disconnect from screens and engage in offline activities you enjoy.',
                  ),
                  SizedBox(height: 15),

                  // Card 3
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/journaling.webp',
                    title: 'Gratitude journaling',
                    description: 'Write down three things you\'re grateful for each day to cultivate a positive mindset.',
                  ),
                  SizedBox(height: 15),

                  // Card 4
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/connection.webp',
                    title: 'Connect with others',
                    description: 'Maintain strong social connections by regularly reaching out to friends and family.',
                  ),
                  SizedBox(height: 15),

                  // Card 5
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/self-care-routine.webp',
                    title: 'Self-care routine',
                    description: 'Establish a daily self-care routine that includes activities that nourish your mental well-being.',
                  ),
                  SizedBox(height: 15),

                  // Card 6
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/negative-thoughts.webp',
                    title: 'Limit negative thoughts',
                    description: 'Challenge negative self-talk and replace it with positive affirmations.',
                  ),
                  SizedBox(height: 15),

                  // Card 7
                  MentalHealthTipCard(
                    picture: 'assets/images/mental-health/counseling.webp',
                    title: 'Seek professional help',
                    description: 'Don\'t hesitate to consult a mental health professional when feeling overwhelmed.',
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

class MentalHealthTipCard extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const MentalHealthTipCard({
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