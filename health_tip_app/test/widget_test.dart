// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:health_tip_app/main.dart';

void main() {
  testWidgets('Sign in flows to getting started then main navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HealthTipsApp());

    expect(find.text('Health Care Tips'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Select Your Interests'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Health Tips'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Daily Tips'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Discover'));
    await tester.pump();

    expect(find.text('Search for topics'), findsOneWidget);
    expect(find.text('Nutrition'), findsOneWidget);
  });
}
