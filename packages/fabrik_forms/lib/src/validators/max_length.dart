import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that ensures the string does not exceed [max] characters.
///
/// Useful for form fields like name, title, descriptions, etc.
class MaxLengthValidator extends FabrikValidator<String> {
  /// Creates a [MaxLengthValidator].
  ///
  /// - [max]: the maximum number of characters allowed.
  /// - [message]: the error message shown if the value is too long.
  const MaxLengthValidator({required this.max, this.message = 'Too long'});

  /// The maximum allowed length for the input.
  final int max;

  /// The error message returned if the input exceeds [max] length.
  final String message;

  @override
  String? call(String value) {
    return value.length > max ? message : null;
  }
}
