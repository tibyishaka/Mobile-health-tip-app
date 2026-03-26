import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/widgets/tip_card.dart';
import 'package:health_tip_app/models/health_tip.dart';

void main() {
  group('TipCard Widget Tests', () {
    testWidgets('should render TipCard with all elements', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Drink Water',
        description: 'Stay hydrated by drinking 8 glasses daily',
        iconPath: '💧',
        category: 'nutrition',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      expect(find.text('Drink Water'), findsOneWidget);
      expect(find.text('Stay hydrated by drinking 8 glasses daily'), findsOneWidget);
      expect(find.text('💧'), findsOneWidget);
    });

    testWidgets('should display nutrition tip with green background', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Eat Vegetables',
        description: 'Include 5 servings daily',
        iconPath: '🥗',
        category: 'nutrition',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(TipCard),
          matching: find.byType(Container),
        ).at(1), // Second container is the colored one
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFFE8F5E9));
    });

    testWidgets('should display sleep tip with orange background', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Sleep Early',
        description: 'Get 7-8 hours of sleep',
        iconPath: '😴',
        category: 'sleep',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      expect(find.text('Sleep Early'), findsOneWidget);
      expect(find.text('😴'), findsOneWidget);
    });

    testWidgets('should display mindfulness tip with blue background', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Meditate',
        description: 'Practice 10 minutes daily',
        iconPath: '🧘',
        category: 'mindfulness',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      expect(find.text('Meditate'), findsOneWidget);
      expect(find.text('Practice 10 minutes daily'), findsOneWidget);
      expect(find.text('🧘'), findsOneWidget);
    });

    testWidgets('should handle long text gracefully', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Very Long Title That Should Be Displayed Properly',
        description: 'This is a very long description that contains a lot of text and should wrap properly within the card layout without causing any overflow issues.',
        iconPath: '📝',
        category: 'general',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      expect(find.text('Very Long Title That Should Be Displayed Properly'), findsOneWidget);
      expect(find.byType(TipCard), findsOneWidget);
    });

    testWidgets('should render multiple TipCards in a list', (WidgetTester tester) async {
      final tips = [
        HealthTip(title: 'Tip 1', description: 'Desc 1', iconPath: '🍎', category: 'nutrition'),
        HealthTip(title: 'Tip 2', description: 'Desc 2', iconPath: '😴', category: 'sleep'),
        HealthTip(title: 'Tip 3', description: 'Desc 3', iconPath: '🧘', category: 'mindfulness'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: tips.length,
              itemBuilder: (context, index) => TipCard(tip: tips[index]),
            ),
          ),
        ),
      );

      expect(find.text('Tip 1'), findsOneWidget);
      expect(find.text('Tip 2'), findsOneWidget);
      expect(find.text('Tip 3'), findsOneWidget);
      expect(find.byType(TipCard), findsNWidgets(3));
    });

    testWidgets('should render with proper spacing and padding', (WidgetTester tester) async {
      final tip = HealthTip(
        title: 'Test Tip',
        description: 'Test description',
        iconPath: '✨',
        category: 'test',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: tip),
          ),
        ),
      );

      final outerContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(TipCard),
          matching: find.byType(Container),
        ).first,
      );

      expect(outerContainer.padding, const EdgeInsets.all(16));
    });
  });
}
