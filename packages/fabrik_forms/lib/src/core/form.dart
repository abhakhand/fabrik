import 'package:fabrik_forms/src/core/field.dart';

/// Represents a form composed of multiple named [FabrikField]s.
///
/// Provides centralized access to field values, validation state,
/// and form-wide actions like updating values or marking fields as touched.
class FabrikForm<T> {
  /// Creates a new [FabrikForm] from a map of field keys to [FabrikField]s.
  FabrikForm(this._fields);

  // ===========================================================================
  // Internal field map
  // ===========================================================================

  /// All fields in the form, keyed by their string identifier.
  final Map<String, FabrikField<T>> _fields;

  // ===========================================================================
  // Public computed properties
  // ===========================================================================

  /// Whether all fields in the form are valid.
  bool get isValid => _fields.values.every((field) => field.isValid);

  /// Whether any field in the form has changed from its initial value.
  bool get isDirty => _fields.values.any((field) => field.isDirty);

  /// Whether the user has interacted with any field in the form.
  bool get isTouched => _fields.values.any((field) => field.isTouched);

  /// The current values of all fields in the form.
  Map<String, dynamic> get values => {
    for (final entry in _fields.entries) entry.key: entry.value.value,
  };

  /// The current validation errors for all fields in the form.
  Map<String, String?> get errors => {
    for (final entry in _fields.entries) entry.key: entry.value.error,
  };

  // ===========================================================================
  // Field access and updates
  // ===========================================================================

  /// Retrieves a typed [FabrikField] by key.
  ///
  /// Example:
  /// ```dart
  /// final emailField = form.get<String>('email');
  /// ```
  FabrikField<T2> get<T2>(String key) => _fields[key]! as FabrikField<T2>;

  /// Updates the value of a specific field by key.
  ///
  /// This also marks the field as touched and revalidates it.
  void update<T3>(String key, T3 value) {
    get<T3>(key).update(value);
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
  }

  /// Resets all fields to their initial values and clears all interaction state.
  ///
  /// After calling [reset], [isDirty] and [isTouched] will both return `false`
  /// across the entire form.
  void reset() {
    for (final field in _fields.values) {
      field.reset();
    }
  }
}
