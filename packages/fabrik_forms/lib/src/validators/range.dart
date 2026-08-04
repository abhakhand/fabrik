import 'package:fabrik_forms/src/validators/base.dart';

/// A validator that checks whether a numeric value falls within [min]..[max].
///
/// Works with any [num] subtype (int, double). Both bounds are inclusive.
///
/// The type parameter follows the field it validates, so it attaches to a
/// `FabrikField<int>` and a `FabrikField<double>` alike:
///
/// ```dart
/// RangeValidator(min: 1, max: 100)   // value must be between 1 and 100
/// RangeValidator(min: 0, max: 1)     // e.g. a ratio
///
/// FabrikField<int>(
///   value: 0,
///   validators: [RangeValidator(min: 18, max: 120)],
/// );
/// ```
class RangeValidator<T extends num> extends FabrikValidator<T> {
  /// Creates a [RangeValidator] with inclusive [min] and [max] bounds.
  ///
  /// - [minMessage]: overrides the default "Must be at least [min]" error.
  /// - [maxMessage]: overrides the default "Must be at most [max]" error.
  const RangeValidator({
    required this.min,
    required this.max,
    this.minMessage,
    this.maxMessage,
  });

  /// The minimum allowed value (inclusive).
  final num min;

  /// The maximum allowed value (inclusive).
  final num max;

  /// Custom message shown when the value is below [min].
  ///
  /// Defaults to `"Must be at least $min"`.
  final String? minMessage;

  /// Custom message shown when the value exceeds [max].
  ///
  /// Defaults to `"Must be at most $max"`.
  final String? maxMessage;

  @override
  String? call(T value) {
    if (value < min) return minMessage ?? 'Must be at least $min';
    if (value > max) return maxMessage ?? 'Must be at most $max';
    return null;
  }
}
