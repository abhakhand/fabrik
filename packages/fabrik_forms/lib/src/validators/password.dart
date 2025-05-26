import 'package:fabrik_forms/src/validators/base.dart';

/// A flexible validator for enforcing password complexity rules.
///
/// Supports checks for:
/// - Required non-empty value
/// - Minimum length
/// - Uppercase letters
/// - Digits
/// - Special characters
///
/// All checks are optional and customizable.
class PasswordValidator extends FabrikValidator<String> {
  /// Creates a [PasswordValidator] with optional complexity rules.
  const PasswordValidator({
    this.requiredMessage = 'Password is required',
    this.minLength = 8,
    this.minLengthMessage = 'Password must be 8 characters or more',
    this.requireUppercase = false,
    this.uppercaseMessage = 'Must include uppercase letter',
    this.requireDigit = false,
    this.digitMessage = 'Must include digit',
    this.requireSpecialChar = false,
    this.specialCharMessage = 'Must include special character',
  });

  // ===========================================================================
  // Configurable constraints
  // ===========================================================================

  /// Message shown when password is empty.
  final String requiredMessage;

  /// Minimum number of characters required.
  final int minLength;

  /// Message shown when password is too short.
  final String minLengthMessage;

  /// Whether to require at least one uppercase letter.
  final bool requireUppercase;

  /// Message shown when no uppercase letter is found.
  final String uppercaseMessage;

  /// Whether to require at least one numeric digit.
  final bool requireDigit;

  /// Message shown when no digit is found.
  final String digitMessage;

  /// Whether to require at least one special character.
  final bool requireSpecialChar;

  /// Message shown when no special character is found.
  final String specialCharMessage;

  // ===========================================================================
  // Pattern matchers
  // ===========================================================================

  static final _capitalLetterRegex = RegExp(r'[A-Z]');
  static final _digitRegex = RegExp(r'[0-9]');
  static final _specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  // ===========================================================================
  // Validation logic
  // ===========================================================================

  @override
  String? call(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return requiredMessage;

    if (requireUppercase && !_capitalLetterRegex.hasMatch(trimmed)) {
      return uppercaseMessage;
    }

    if (requireDigit && !_digitRegex.hasMatch(trimmed)) {
      return digitMessage;
    }

    if (requireSpecialChar && !_specialCharacterRegex.hasMatch(trimmed)) {
      return specialCharMessage;
    }

    if (trimmed.length < minLength) {
      return minLengthMessage;
    }

    return null;
  }
}
