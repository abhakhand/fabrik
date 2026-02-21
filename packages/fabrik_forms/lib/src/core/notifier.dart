import 'package:flutter/foundation.dart';
import 'package:fabrik_forms/src/core/core.dart';

/// A reactive [ValueNotifier]-based wrapper around [FabrikForm].
///
/// This allows widgets to listen and rebuild on form updates,
/// making it easy to integrate with Flutter's UI tree.
class FabrikFormNotifier<T> extends ValueNotifier<FabrikForm<T>> {
  /// Creates a new [FabrikFormNotifier] with the given form.
  FabrikFormNotifier(super.form);

  // ===========================================================================
  // Reactive field actions
  // ===========================================================================

  /// Updates the value of a specific field and notifies listeners.
  ///
  /// Also marks the field as touched and triggers revalidation.
  void update<T2>(String key, T2 newValue) {
    value.update<T2>(key, newValue);
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
  FabrikField<T2> get<T2>(String key) => value.get<T2>(key);

  // ===========================================================================
  // Computed form state
  // ===========================================================================

  /// Whether all fields are currently valid.
  bool get isValid => value.isValid;

  /// Whether any field has been changed from its initial value.
  bool get isDirty => value.isDirty;

  /// Whether any field has been interacted with.
  bool get isTouched => value.isTouched;

  /// Returns the current field values.
  Map<String, dynamic> get values => value.values;

  /// Returns the current validation errors.
  Map<String, String?> get errors => value.errors;
}
