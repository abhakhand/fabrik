import 'package:fabrik_forms/src/validators/base.dart';

/// Represents a single field in a form, holding its value, validation logic,
/// and interaction metadata like whether it has been touched or changed.
class FabrikField<T> {
  /// Creates a [FabrikField] with an initial [value] and optional [validators].
  ///
  /// Runs validators immediately on initialization.
  FabrikField({required this.value, List<FabrikValidator<T>>? validators})
    : _initialValue = value,
      _validators = validators ?? [] {
    _error = _runValidators();
  }

  // ===========================================================================
  // Core values
  // ===========================================================================

  /// The current value of the field.
  T value;

  /// The original value at the time of initialization.
  final T _initialValue;

  /// The list of validation rules for this field.
  final List<FabrikValidator<T>> _validators;

  // ===========================================================================
  // Internal state
  // ===========================================================================

  /// The most recent validation error (null if valid).
  String? _error;

  /// Whether the field has been interacted with (changed via [update] or [markTouched]).
  bool _touched = false;

  // ===========================================================================
  // Public accessors
  // ===========================================================================

  /// The most recent validation error (regardless of touch).
  String? get error => _error;

  /// Whether the current value passes all validators.
  bool get isValid => _error == null;

  /// Whether the user has interacted with the field.
  bool get isTouched => _touched;

  /// Whether the value has changed from the original input.
  bool get isDirty => value != _initialValue;

  /// The validation error to show in UI (only visible after user interaction).
  String? get visibleError => isTouched ? error : null;

  // ===========================================================================
  // State mutation
  // ===========================================================================

  /// Updates the value, marks the field as touched, and re-runs validation.
  void update(T newValue) {
    value = newValue;
    _touched = true;
    _error = _runValidators();
  }

  /// Marks the field as touched without changing the value.
  ///
  /// Useful when the form is submitted and you want to show all field errors.
  void markTouched() {
    _touched = true;
    _error = _runValidators();
  }

  // ===========================================================================
  // Internal validation
  // ===========================================================================

  /// Runs all validators and returns the first error encountered.
  String? _runValidators() {
    for (final validator in _validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
}
