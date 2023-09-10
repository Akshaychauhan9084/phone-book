import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonebook/main.dart';

void main() {
  testWidgets('Test full user flow', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Find the text field and submit button
    final phoneNumberField = find.byType(TextField);
    final submitButton = find.byType(ElevatedButton);

    // Enter a valid phone number
    await tester.enterText(phoneNumberField, '1234567890');

    // Tap the submit button
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Ensure we have navigated to the next screen
    expect(find.text('Next Screen'), findsOneWidget);

    // Find the "Update/Change" button
    final updateButton = find.text('Update/Change');

    // Tap the "Update/Change" button
    await tester.tap(updateButton);
    await tester.pumpAndSettle();

    // Ensure we are back on the initial screen
    expect(find.text('Phone Number Screen'), findsOneWidget);
  });
}
