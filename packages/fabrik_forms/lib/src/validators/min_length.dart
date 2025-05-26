import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that ensures the string has at least [min] characters.
///
/// Useful for password, username, and text input validations.
class MinLengthValidator extends FabrikValidator<String> {
  /// Creates a [MinLengthValidator].
  ///
  /// - [min]: the minimum number of characters required.
  /// - [message]: the error message shown if the value is too short.
  const MinLengthValidator({required this.min, this.message = 'Too short'});

  /// The minimum length allowed for the input.
  final int min;

  /// The error message returned if the input is shorter than [min].
  final String message;

  @override
  String? call(String value) {
    return value.length < min ? message : null;
  }
}
