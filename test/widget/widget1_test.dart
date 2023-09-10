import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phonebook/main.dart';

void main() {
  testWidgets('Test phone number input and submission', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Find the text field and submit button
    final phoneNumberField = find.byType(TextField);
    final submitButton = find.byType(ElevatedButton);

    // Enter an invalid phone number
    await tester.enterText(phoneNumberField, '1234');

    // Ensure error message is displayed
    expect(find.text('Please enter a 10-digit number'), findsOneWidget);

    // Tap the submit button (it should be disabled)
    await tester.tap(submitButton);
    await tester.pump();

    // Ensure we are still on the same screen
    expect(find.text('Phone Number Screen'), findsOneWidget);

    // Enter a valid phone number
    await tester.enterText(phoneNumberField, '1234567890');

    // Ensure error message is not displayed
    expect(find.text('Please enter a 10-digit number'), findsNothing);

    // Tap the submit button (it should be enabled)
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Ensure we have navigated to the next screen
    expect(find.text('Next Screen'), findsOneWidget);
  });
}
