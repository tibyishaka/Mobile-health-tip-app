// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:health_tip_app/main.dart';

void main() {
  testWidgets('Home screen with bottom navigation renders', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HealthTipsApp());

    expect(find.text('Health Tips'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Daily Tips'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.text('Discover'));
    await tester.pump();

    expect(find.text('Discover Wellness'), findsOneWidget);
  });
}
