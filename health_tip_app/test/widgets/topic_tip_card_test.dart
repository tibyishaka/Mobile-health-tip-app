import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/widgets/topic_tip_card.dart';

void main() {
  group('TopicTipCard Widget Tests', () {
    testWidgets('renders TopicTipCard correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TopicTipCard(
              title: 'Healthy Mind',
              description: 'Stay positive and practice mindfulness.',
              picture: 'assets/images/mental-health/practice.webp',
            ),
          ),
        ),
      );

      // Verify title is rendered
      expect(find.text('Healthy Mind'), findsOneWidget);

      // Verify description is rendered
      expect(find.text('Stay positive and practice mindfulness.'), findsOneWidget);

      // Verify image is rendered
      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
    });
  });
}
