/// Abstract base class for validators that span more than one field.
///
/// A field validator only sees its own value, so rules like "confirm password
/// must match password" or "end date must be after start date" cannot be
/// expressed there. A [FabrikFormValidator] receives every field value at once.
///
/// Errors produced here surface via `FabrikForm.formError` / `formErrors` and
/// count towards `FabrikForm.isValid`.
///
/// Example:
/// ```dart
/// class PasswordsMatch extends FabrikFormValidator {
///   const PasswordsMatch();
///
///   @override
///   String? call(Map<String, dynamic> values) {
///     return values['password'] == values['confirmPassword']
///         ? null
///         : 'Passwords do not match';
///   }
/// }
/// ```
abstract class FabrikFormValidator {
  const FabrikFormValidator();

  /// Returns `null` if the form passes this rule, or an error message if not.
  ///
  /// [values] is a snapshot of every field value, keyed by field name.
  String? call(Map<String, dynamic> values);
}

/// A [FabrikFormValidator] built from a plain function.
///
/// Convenient for one-off rules that do not warrant their own class.
///
/// Example:
/// ```dart
/// FabrikForm(
///   fields,
///   validators: [
///     FabrikFormRule(
///       (values) => values['password'] == values['confirm']
///           ? null
///           : 'Passwords do not match',
///     ),
///   ],
/// );
/// ```
class FabrikFormRule extends FabrikFormValidator {
  /// Creates a form validator from [validate].
  const FabrikFormRule(this._validate);

  final String? Function(Map<String, dynamic> values) _validate;

  @override
  String? call(Map<String, dynamic> values) => _validate(values);
}

/// A ready-made [FabrikFormValidator] that checks two fields hold equal values.
///
/// The canonical use is password confirmation, but it works for any pair of
/// fields that must agree, such as email confirmation.
///
/// Example:
/// ```dart
/// FabrikForm(
///   fields,
///   validators: [
///     const FieldsMatchValidator(
///       field: 'password',
///       matchField: 'confirmPassword',
///       message: 'Passwords do not match',
///     ),
///   ],
/// );
/// ```
class FieldsMatchValidator extends FabrikFormValidator {
  /// Creates a validator requiring [field] and [matchField] to be equal.
  const FieldsMatchValidator({
    required this.field,
    required this.matchField,
    this.message = 'Fields do not match',
  });

  /// The key of the first field to compare.
  final String field;

  /// The key of the field that must equal [field].
  final String matchField;

  /// The error message returned when the two values differ.
  final String message;

  @override
  String? call(Map<String, dynamic> values) {
    return values[field] == values[matchField] ? null : message;
  }
}
