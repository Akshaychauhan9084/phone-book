import 'package:flutter_test/flutter_test.dart';
void main() {
  group('Test phone number validation', () {
    // Test invalid phone numbers
    expect(validatePhoneNumber('1234'), isFalse);
    expect(validatePhoneNumber('1234567890'), isTrue);
  });

}
bool validatePhoneNumber(String phoneNumber) {
  return phoneNumber.length == 10;
}



