import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nav_lab/task1_5.dart';

void main() {
  testWidgets('Home screen displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Check that the Home screen is displayed.
    expect(find.text('Home'), findsOneWidget);

    // The root screen cannot go back.
    expect(find.text('Nothing to go back to'), findsOneWidget);

    // Check that the navigation button exists.
    expect(find.text('Open Details'), findsOneWidget);
  });

  testWidgets('Navigation to Details screen works',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    await tester.tap(find.text('Open Details'));
    await tester.pumpAndSettle();

    // Check that the Details screen opens.
    expect(find.text('Details'), findsOneWidget);

    // The Details screen can go back.
    expect(find.text('Back'), findsOneWidget);
  });
}
