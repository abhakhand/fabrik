import 'package:fabrik_forms/src/core/field.dart';
import 'package:fabrik_forms/src/validators/form_validator.dart';

/// Represents a form composed of multiple named [FabrikField]s.
///
/// Provides centralized access to field values, validation state,
/// and form-wide actions like updating values or marking fields as touched.
///
/// A form is deliberately untyped: each field carries its own type and its own
/// validators, so a single form can mix a `String` email, an `int` age and a
/// `bool` opt-in. Types are recovered at the call site with [get]:
///
/// ```dart
/// final form = FabrikForm({
///   'email': FabrikField<String>(value: '', validators: [EmailValidator()]),
///   'age': FabrikField<int>(value: 0, validators: [RangeValidator(min: 18, max: 120)]),
///   'subscribed': FabrikField<bool>(value: false),
/// });
///
/// form.get<String>('email').value;  // String
/// form.get<int>('age').value;       // int
/// ```
class FabrikForm {
  /// Creates a new [FabrikForm] from a map of field keys to [FabrikField]s.
  ///
  /// Optional [validators] run against the whole form and are the place to put
  /// rules that span more than one field, such as password confirmation.
  FabrikForm(
    Map<String, FabrikField<dynamic>> fields, {
    List<FabrikFormValidator>? validators,
  }) : _fields = fields,
       _validators = validators ?? const [] {
    _formErrors = _runFormValidators();
  }

  // ===========================================================================
  // Internal state
  // ===========================================================================

  /// All fields in the form, keyed by their string identifier.
  final Map<String, FabrikField<dynamic>> _fields;

  /// Validators that see the whole form at once.
  final List<FabrikFormValidator> _validators;

  /// Errors produced by the form-level [_validators].
  List<String> _formErrors = const [];

  // ===========================================================================
  // Public computed properties
  // ===========================================================================

  /// The field keys in this form, in insertion order.
  Iterable<String> get keys => _fields.keys;

  /// Whether every field is valid *and* all form-level validators pass.
  bool get isValid =>
      _fields.values.every((field) => field.isValid) && _formErrors.isEmpty;

  /// Whether any field in the form has changed from its initial value.
  bool get isDirty => _fields.values.any((field) => field.isDirty);

  /// Whether the user has interacted with any field in the form.
  bool get isTouched => _fields.values.any((field) => field.isTouched);

  /// The current values of all fields in the form.
  Map<String, dynamic> get values => {
    for (final entry in _fields.entries) entry.key: entry.value.value,
  };

  /// The first validation error for each field, keyed by field name.
  Map<String, String?> get errors => {
    for (final entry in _fields.entries) entry.key: entry.value.error,
  };

  /// Every validation error for each field, keyed by field name.
  Map<String, List<String>> get allErrors => {
    for (final entry in _fields.entries) entry.key: entry.value.errors,
  };

  /// The first form-level error, or `null` when the form-level rules pass.
  ///
  /// Form-level errors come from validators that span multiple fields, so they
  /// belong to the form rather than to any single field.
  String? get formError => _formErrors.isEmpty ? null : _formErrors.first;

  /// Every form-level error, in validator order.
  List<String> get formErrors => List.unmodifiable(_formErrors);

  // ===========================================================================
  // Field access and updates
  // ===========================================================================

  /// Retrieves a field by key, typed as [FabrikField] of [T].
  ///
  /// Throws an [ArgumentError] naming the available fields when [key] is not
  /// present, and a [StateError] when the field holds a value of a different
  /// type than [T].
  ///
  /// Example:
  /// ```dart
  /// final emailField = form.get<String>('email');
  /// ```
  FabrikField<T> get<T>(String key) {
    final field = _fields[key];

    if (field == null) {
      throw ArgumentError.value(
        key,
        'key',
        'No field named "$key" in this form. '
            'Available fields: ${_fields.keys.join(', ')}',
      );
    }

    if (field is FabrikField<T>) return field;

    // Dart generics are invariant, so a field declared without an explicit type
    // argument infers as `FabrikField<dynamic>` and is not a `FabrikField<T>`,
    // even when its value is a T. Say so plainly rather than failing with a
    // cast error, since the fix is a one-word edit at the declaration.
    if (field.value is T) {
      throw StateError(
        'Field "$key" holds a ${field.value.runtimeType} value but was '
        'declared without a type argument, so it is a FabrikField<dynamic>. '
        'Declare it as FabrikField<$T>(value: ...) to read it as $T.',
      );
    }

    throw StateError(
      'Field "$key" holds a ${field.value.runtimeType} value, '
      'but was requested as $T.',
    );
  }

  /// Whether a field with [key] exists in this form.
  bool contains(String key) => _fields.containsKey(key);

  /// Updates the value of a specific field by key.
  ///
  /// This also marks the field as touched, revalidates it, and re-runs the
  /// form-level validators.
  void update<T>(String key, T value) {
    get<T>(key).update(value);
    _formErrors = _runFormValidators();
  }

  // ===========================================================================
  // Global mutation
  // ===========================================================================

  /// Marks all fields as touched and revalidates them.
  ///
  /// Useful when submitting a form to reveal all validation errors.
  void markAllTouched() {
    for (final field in _fields.values) {
      field.markTouched();
    }
    _formErrors = _runFormValidators();
  }

  /// Resets all fields to their initial values and clears all interaction state.
  ///
  /// After calling [reset], [isDirty] and [isTouched] will both return `false`
  /// across the entire form.
  void reset() {
    for (final field in _fields.values) {
      field.reset();
    }
    _formErrors = _runFormValidators();
  }

  // ===========================================================================
  // Internal validation
  // ===========================================================================

  /// Runs every form-level validator and collects all errors.
  List<String> _runFormValidators() {
    if (_validators.isEmpty) return const [];

    final snapshot = values;
    final collected = <String>[];
    for (final validator in _validators) {
      final result = validator(snapshot);
      if (result != null) collected.add(result);
    }
    return collected;
  }
}
