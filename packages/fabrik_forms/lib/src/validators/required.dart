import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that ensures the string field is not empty.
///
/// Commonly used to mark a field as required. Trims whitespace by default
/// before checking for emptiness.
class RequiredValidator extends FabrikValidator<String> {
  /// Creates a [RequiredValidator].
  ///
  /// - [trim] determines whether to trim the input before checking.
  /// - [message] is the error message returned if the field is empty.
  const RequiredValidator({
    this.trim = true,
    this.message = 'This field is required',
  });

  /// Whether to trim the input value before validating.
  final bool trim;

  /// The error message to return if the value is considered empty.
  final String message;

  @override
  String? call(String value) {
    final testValue = trim ? value.trim() : value;
    return testValue.isEmpty ? message : null;
  }
}
