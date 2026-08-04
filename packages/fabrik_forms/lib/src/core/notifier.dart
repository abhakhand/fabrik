import 'package:flutter/foundation.dart';
import 'package:fabrik_forms/src/core/core.dart';

/// A reactive [ValueNotifier]-based wrapper around [FabrikForm].
///
/// This allows widgets to listen and rebuild on form updates,
/// making it easy to integrate with Flutter's UI tree.
///
/// Example:
/// ```dart
/// final notifier = FabrikFormNotifier(
///   FabrikForm({
///     'email': FabrikField<String>(value: '', validators: [EmailValidator()]),
///     'age': FabrikField<int>(value: 0),
///   }),
/// );
///
/// notifier.update<String>('email', 'user@example.com');
/// ```
class FabrikFormNotifier extends ValueNotifier<FabrikForm> {
  /// Creates a new [FabrikFormNotifier] with the given form.
  FabrikFormNotifier(super.form);

  // ===========================================================================
  // Reactive field actions
  // ===========================================================================

  /// Updates the value of a specific field and notifies listeners.
  ///
  /// Also marks the field as touched and triggers revalidation.
  void update<T>(String key, T newValue) {
    value.update<T>(key, newValue);
    notifyListeners();
  }

  /// Marks all fields as touched and notifies listeners.
  ///
  /// Useful for showing all validation errors on submit.
  void markAllTouched() {
    value.markAllTouched();
    notifyListeners();
  }

  /// Resets all fields to their initial values and notifies listeners.
  ///
  /// Clears all dirty and touched state across the form.
  void reset() {
    value.reset();
    notifyListeners();
  }

  // ===========================================================================
  // Field access
  // ===========================================================================

  /// Retrieves a typed [FabrikField] from the underlying form.
  FabrikField<T> get<T>(String key) => value.get<T>(key);

  /// Whether a field with [key] exists in the underlying form.
  bool contains(String key) => value.contains(key);

  /// The field keys in the underlying form, in insertion order.
  Iterable<String> get keys => value.keys;

  // ===========================================================================
  // Computed form state
  // ===========================================================================

  /// Whether all fields and all form-level validators currently pass.
  bool get isValid => value.isValid;

  /// Whether any field has been changed from its initial value.
  bool get isDirty => value.isDirty;

  /// Whether any field has been interacted with.
  bool get isTouched => value.isTouched;

  /// Returns the current field values.
  Map<String, dynamic> get values => value.values;

  /// Returns the first validation error for each field.
  Map<String, String?> get errors => value.errors;

  /// Returns every validation error for each field.
  Map<String, List<String>> get allErrors => value.allErrors;

  /// The first form-level error, or `null` when the form-level rules pass.
  String? get formError => value.formError;

  /// Every form-level error, in validator order.
  List<String> get formErrors => value.formErrors;
}
