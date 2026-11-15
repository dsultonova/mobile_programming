import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cart_four_ways/setstate/cart_page_setstate.dart';

void main() {
  testWidgets('T6: add Keyboard twice, apply SAVE10, total is 88.20',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SetStateCartPage()),
    );

    // Tap Keyboard twice
    final keyboardChip = find.text('Keyboard · 49');
    await tester.tap(keyboardChip);
    await tester.pump();
    await tester.tap(keyboardChip);
    await tester.pump();

    // Enter SAVE10 and tap Apply
    await tester.enterText(find.byType(TextField), 'SAVE10');
    await tester.pump();
    await tester.tap(find.text('Apply'));
    await tester.pump();

    // 49 * 2 = 98, 10% off = 9.80, total = 88.20
    expect(find.text('88.20'), findsOneWidget);
  });
}
