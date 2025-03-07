import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:karriba/main.dart';

void main() {
  testWidgets('Bottom navigation bar has four items', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KarribaApp());

    // Verify that our bottom navigation bar has Flights, Customers, Applicators, and Settings.
    final bottomNavigationBarFinder = find.byType(NavigationBar);
    expect(find.descendant(of: bottomNavigationBarFinder, matching: find.text('Flights')), findsOneWidget);
    expect(find.descendant(of: bottomNavigationBarFinder, matching: find.text('Customers')), findsOneWidget);
    expect(find.descendant(of: bottomNavigationBarFinder, matching: find.text('Applicators')), findsOneWidget);
    expect(find.descendant(of: bottomNavigationBarFinder, matching: find.text('Settings')), findsOneWidget);
  });
}
