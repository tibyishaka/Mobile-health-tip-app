import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tip_app/widgets/custom_search_bar.dart';

void main() {
  group('CustomSearchBar Widget Tests', () {
    testWidgets('renders CustomSearchBar correctly', (WidgetTester tester) async {
      final controller = TextEditingController();
      String changedValue = '';
      bool clearTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return CustomSearchBar(
                  controller: controller,
                  hintText: 'Search here...',
                  onChanged: (val) {
                    setState(() {
                      changedValue = val;
                    });
                  },
                  onClear: () {
                    setState(() {
                      clearTapped = true;
                      controller.clear();
                    });
                  },
                );
              }
            ),
          ),
        ),
      );

      // Verify hint text exists
      expect(find.text('Search here...'), findsOneWidget);
      // Wait for suffix icon to be search
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Enter some text
      await tester.enterText(find.byType(TextField), 'health');
      await tester.pump(); // trigger UI rebuild

      // Verify onChanged was called
      expect(changedValue, 'health');

      // Verify clear icon appears and search icon disappears
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);

      // Tap clear icon
      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(clearTapped, true);
      expect(controller.text, isEmpty);
    });
  });
}
