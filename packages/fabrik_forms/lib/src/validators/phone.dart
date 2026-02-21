import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that checks whether a string is a valid phone number.
///
/// Accepts common international and local formats:
/// - `+1 234 567 8900`
/// - `(123) 456-7890`
/// - `123-456-7890`
/// - `1234567890`
///
/// The number must contain between 7 and 15 digits (after stripping formatting).
class PhoneValidator extends FabrikValidator<String> {
  /// Creates a [PhoneValidator].
  ///
  /// - [isRequired]: whether the field must be non-empty. Defaults to true.
  /// - [requiredMessage]: error if field is required but empty.
  /// - [invalidMessage]: error if the phone number format is invalid.
  const PhoneValidator({
    this.isRequired = true,
    this.requiredMessage = 'Phone number is required',
    this.invalidMessage = 'Invalid phone number',
  });

  /// Whether to require the field to be non-empty.
  final bool isRequired;

  /// Message shown when required field is left empty.
  final String requiredMessage;

  /// Message shown when the phone number format is invalid.
  final String invalidMessage;

  /// Accepts digits, spaces, dashes, dots, parentheses, and an optional
  /// leading `+` for international format.
  static final _regex = RegExp(r'^\+?[\d\s\-(). ]{7,20}$');

  @override
  String? call(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return isRequired ? requiredMessage : null;

    if (!_regex.hasMatch(trimmed)) return invalidMessage;

    // Ensure enough digits are present (strip non-digit chars and count)
    final digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 7 || digits.length > 15) return invalidMessage;

    return null;
  }
}
