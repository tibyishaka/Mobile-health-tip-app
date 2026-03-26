import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/models/health_tip.dart';
import 'package:health_tip_app/widgets/tip_card.dart';

void main() {
  group('TipCard Widget Tests', () {
    late HealthTip testTip;

    setUp(() {
      testTip = HealthTip(
        id: '1',
        title: 'Drink Water',
        description: 'Stay hydrated through the day',
        imageAsset: 'assets/images/fitness/cons.webp',
        category: TipCategory.nutrition,
      );
    });

    testWidgets('renders TipCard correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TipCard(tip: testTip),
          ),
        ),
      );

      // Verify basic text is rendered
      expect(find.text('Drink Water'), findsOneWidget);
    });
  });
}
