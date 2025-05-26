import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that checks whether a string is a valid email address.
///
/// Uses a simplified, real-world-safe regex pattern. Also optionally ensures
/// the field is required by default.
class EmailValidator extends FabrikValidator<String> {
  /// Creates an [EmailValidator].
  ///
  /// - [isRequired]: whether the field must be non-empty. Defaults to true.
  /// - [requiredMessage]: error if field is required but empty.
  /// - [invalidMessage]: error if the email format is invalid.
  const EmailValidator({
    this.isRequired = true,
    this.requiredMessage = 'Email is required',
    this.invalidMessage = 'Invalid email format',
  });

  /// Whether to require the field to be non-empty.
  final bool isRequired;

  /// Message shown when required field is left empty.
  final String requiredMessage;

  /// Message shown when format is not a valid email.
  final String invalidMessage;

  /// A real-world-safe email regex (simple and performant).
  static final _regex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  String? call(String value) {
    final trimmed = value.trim();
    if (isRequired && trimmed.isEmpty) return requiredMessage;
    return _regex.hasMatch(trimmed) ? null : invalidMessage;
  }
}
