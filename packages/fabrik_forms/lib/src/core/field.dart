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
    _errors = _runValidators();
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

  /// Every validation error for the current value, in validator order.
  ///
  /// Empty when the field is valid.
  List<String> _errors = const [];

  /// Whether the field has been interacted with (changed via [update] or [markTouched]).
  bool _touched = false;

  // ===========================================================================
  // Public accessors
  // ===========================================================================

  /// The first validation error (regardless of touch), or `null` if valid.
  ///
  /// Use [errors] when you want to show every failing rule at once.
  String? get error => _errors.isEmpty ? null : _errors.first;

  /// All validation errors for the current value, in validator order.
  ///
  /// Empty when the field is valid. Useful for rules that are naturally
  /// reported together, such as password complexity requirements.
  ///
  /// Example:
  /// ```dart
  /// for (final message in field.errors) Text(message),
  /// ```
  List<String> get errors => List.unmodifiable(_errors);

  /// Whether the current value passes all validators.
  bool get isValid => _errors.isEmpty;

  /// Whether the user has interacted with the field.
  bool get isTouched => _touched;

  /// Whether the value has changed from the original input.
  bool get isDirty => value != _initialValue;

  /// The validation error to show in UI (only visible after user interaction).
  String? get visibleError => isTouched ? error : null;

  /// All validation errors to show in UI (only visible after user interaction).
  ///
  /// Empty until the field has been touched, mirroring [visibleError].
  List<String> get visibleErrors => isTouched ? errors : const [];

  // ===========================================================================
  // State mutation
  // ===========================================================================

  /// Updates the value, marks the field as touched, and re-runs validation.
  void update(T newValue) {
    value = newValue;
    _touched = true;
    _errors = _runValidators();
  }

  /// Marks the field as touched without changing the value.
  ///
  /// Useful when the form is submitted and you want to show all field errors.
  void markTouched() {
    _touched = true;
    _errors = _runValidators();
  }

  /// Resets the field to its initial value and clears all interaction state.
  ///
  /// After calling [reset], [isDirty] and [isTouched] will both return `false`,
  /// and validation will re-run against the original value.
  void reset() {
    value = _initialValue;
    _touched = false;
    _errors = _runValidators();
  }

  // ===========================================================================
  // Internal validation
  // ===========================================================================

  /// Runs every validator and collects all errors, in validator order.
  List<String> _runValidators() {
    final collected = <String>[];
    for (final validator in _validators) {
      final result = validator(value);
      if (result != null) collected.add(result);
    }
    return collected;
  }
}
