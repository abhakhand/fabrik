import 'package:fabrik_forms/fabrik_forms.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ===========================================================================
  // RequiredValidator
  // ===========================================================================

  group('RequiredValidator', () {
    const validator = RequiredValidator();

    test('returns null for non-empty value', () {
      expect(validator('hello'), isNull);
    });

    test('returns message for empty string', () {
      expect(validator(''), 'This field is required');
    });

    test('returns message for whitespace-only string (trim=true)', () {
      expect(validator('   '), 'This field is required');
    });

    test('returns null for whitespace when trim=false', () {
      const v = RequiredValidator(trim: false);
      expect(v('   '), isNull);
    });

    test('uses custom message', () {
      const v = RequiredValidator(message: 'Name is required');
      expect(v(''), 'Name is required');
    });
  });

  // ===========================================================================
  // EmailValidator
  // ===========================================================================

  group('EmailValidator', () {
    const validator = EmailValidator();

    test('returns null for valid email', () {
      expect(validator('user@example.com'), isNull);
      expect(validator('user.name+tag@sub.domain.co'), isNull);
    });

    test('returns requiredMessage when empty and isRequired=true', () {
      expect(validator(''), 'Email is required');
      expect(validator('   '), 'Email is required');
    });

    test('returns null when empty and isRequired=false', () {
      const v = EmailValidator(isRequired: false);
      expect(v(''), isNull);
      expect(v('   '), isNull);
    });

    test('returns invalidMessage for malformed email', () {
      expect(validator('not-an-email'), 'Invalid email format');
      expect(validator('@nodomain.com'), 'Invalid email format');
      expect(validator('user@'), 'Invalid email format');
      expect(validator('user@domain'), 'Invalid email format');
    });

    test('trims input before validation', () {
      expect(validator('  user@example.com  '), isNull);
    });

    test('uses custom messages', () {
      const v = EmailValidator(
        requiredMessage: 'Enter your email',
        invalidMessage: 'Bad email',
      );
      expect(v(''), 'Enter your email');
      expect(v('bad'), 'Bad email');
    });
  });

  // ===========================================================================
  // MinLengthValidator
  // ===========================================================================

  group('MinLengthValidator', () {
    const validator = MinLengthValidator(min: 5);

    test('returns null when length meets minimum', () {
      expect(validator('hello'), isNull);
      expect(validator('hello world'), isNull);
    });

    test('returns message when too short', () {
      expect(validator('hi'), 'Too short');
      expect(validator(''), 'Too short');
    });

    test('uses custom message', () {
      const v = MinLengthValidator(min: 3, message: 'Too few characters');
      expect(v('ab'), 'Too few characters');
    });
  });

  // ===========================================================================
  // MaxLengthValidator
  // ===========================================================================

  group('MaxLengthValidator', () {
    const validator = MaxLengthValidator(max: 10);

    test('returns null when length within limit', () {
      expect(validator('hello'), isNull);
      expect(validator('1234567890'), isNull);
    });

    test('returns message when too long', () {
      expect(validator('12345678901'), 'Too long');
    });

    test('uses custom message', () {
      const v = MaxLengthValidator(max: 5, message: 'Must be 5 chars or less');
      expect(v('toolong'), 'Must be 5 chars or less');
    });
  });

  // ===========================================================================
  // PasswordValidator
  // ===========================================================================

  group('PasswordValidator', () {
    const validator = PasswordValidator();

    test('returns null for valid password (default rules)', () {
      expect(validator('password1'), isNull);
    });

    test('returns requiredMessage for empty password', () {
      expect(validator(''), 'Password is required');
      expect(validator('   '), 'Password is required');
    });

    test('returns null when empty and isRequired=false', () {
      const v = PasswordValidator(isRequired: false);
      expect(v(''), isNull);
    });

    test('returns minLengthMessage when too short', () {
      expect(validator('short'), 'Password must be 8 characters or more');
    });

    test('requireUppercase — fails without uppercase', () {
      const v = PasswordValidator(requireUppercase: true);
      expect(v('password1'), 'Must include uppercase letter');
    });

    test('requireUppercase — passes with uppercase', () {
      const v = PasswordValidator(requireUppercase: true);
      expect(v('Password1'), isNull);
    });

    test('requireDigit — fails without digit', () {
      const v = PasswordValidator(requireDigit: true);
      expect(v('Password!'), 'Must include digit');
    });

    test('requireDigit — passes with digit', () {
      const v = PasswordValidator(requireDigit: true);
      expect(v('Password1'), isNull);
    });

    test('requireSpecialChar — fails without special char', () {
      const v = PasswordValidator(requireSpecialChar: true);
      expect(v('Password1'), 'Must include special character');
    });

    test('requireSpecialChar — passes with special char (!)', () {
      const v = PasswordValidator(requireSpecialChar: true);
      expect(v('Password1!'), isNull);
    });

    test('requireSpecialChar — passes with expanded special chars', () {
      const v = PasswordValidator(requireSpecialChar: true);
      // Newly supported chars: - _ + = [ ] / ~ `
      expect(v('Password1-'), isNull);
      expect(v('Password1_'), isNull);
      expect(v('Password1+'), isNull);
      expect(v('Password1='), isNull);
      expect(v('Password1~'), isNull);
    });

    test('minLength is configurable', () {
      const v = PasswordValidator(minLength: 12);
      expect(v('tooshort11'), 'Password must be 8 characters or more');
      expect(v('longenough12!'), isNull);
    });

    test('uses custom messages', () {
      const v = PasswordValidator(
        requiredMessage: 'Enter a password',
        minLengthMessage: 'Need 8+ chars',
      );
      expect(v(''), 'Enter a password');
      expect(v('short'), 'Need 8+ chars');
    });
  });

  // ===========================================================================
  // UrlValidator
  // ===========================================================================

  group('UrlValidator', () {
    const validator = UrlValidator();

    test('returns null for valid http URL', () {
      expect(validator('http://example.com'), isNull);
    });

    test('returns null for valid https URL', () {
      expect(validator('https://example.com/path?q=1'), isNull);
    });

    test('returns requiredMessage when empty and isRequired=true', () {
      expect(validator(''), 'URL is required');
    });

    test('returns null when empty and isRequired=false', () {
      const v = UrlValidator(isRequired: false);
      expect(v(''), isNull);
    });

    test('returns invalidMessage for malformed URL', () {
      expect(validator('not-a-url'), 'Invalid URL');
      expect(validator('ftp://files.example.com'), 'Invalid URL');
      expect(validator('http://'), 'Invalid URL');
    });

    test('requireHttps — rejects http when requireHttps=true', () {
      const v = UrlValidator(requireHttps: true);
      expect(v('http://example.com'), 'URL must use HTTPS');
    });

    test('requireHttps — accepts https', () {
      const v = UrlValidator(requireHttps: true);
      expect(v('https://example.com'), isNull);
    });

    test('trims input before validation', () {
      expect(validator('  https://example.com  '), isNull);
    });
  });

  // ===========================================================================
  // PhoneValidator
  // ===========================================================================

  group('PhoneValidator', () {
    const validator = PhoneValidator();

    test('returns null for valid phone numbers', () {
      expect(validator('1234567890'), isNull);
      expect(validator('+1 234 567 8900'), isNull);
      expect(validator('(123) 456-7890'), isNull);
      expect(validator('123-456-7890'), isNull);
    });

    test('returns requiredMessage when empty and isRequired=true', () {
      expect(validator(''), 'Phone number is required');
    });

    test('returns null when empty and isRequired=false', () {
      const v = PhoneValidator(isRequired: false);
      expect(v(''), isNull);
    });

    test('returns invalidMessage for clearly invalid input', () {
      expect(validator('abc'), 'Invalid phone number');
      expect(validator('123'), 'Invalid phone number'); // too few digits
    });

    test('uses custom messages', () {
      const v = PhoneValidator(
        requiredMessage: 'Enter your phone',
        invalidMessage: 'Bad number',
      );
      expect(v(''), 'Enter your phone');
      expect(v('abc'), 'Bad number');
    });
  });

  // ===========================================================================
  // RangeValidator
  // ===========================================================================

  group('RangeValidator', () {
    const validator = RangeValidator(min: 1, max: 100);

    test('returns null when value is within range', () {
      expect(validator(50), isNull);
      expect(validator(1), isNull);
      expect(validator(100), isNull);
    });

    test('returns default minMessage when below min', () {
      expect(validator(0), 'Must be at least 1');
    });

    test('returns default maxMessage when above max', () {
      expect(validator(101), 'Must be at most 100');
    });

    test('uses custom minMessage', () {
      const v = RangeValidator(min: 5, max: 10, minMessage: 'Too low');
      expect(v(3), 'Too low');
    });

    test('uses custom maxMessage', () {
      const v = RangeValidator(min: 5, max: 10, maxMessage: 'Too high');
      expect(v(15), 'Too high');
    });

    test('works with double values', () {
      const v = RangeValidator(min: 0.0, max: 1.0);
      expect(v(0.5), isNull);
      expect(v(-0.1), 'Must be at least 0.0');
      expect(v(1.1), 'Must be at most 1.0');
    });
  });
}
