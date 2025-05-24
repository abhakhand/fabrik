/// A scalable spacing system using a 4px grid.
///
/// `x4` (16.0) is the base spacing unit.
/// All other values are defined as logical multiples or fractions of `x4`,
/// ensuring consistency and predictability across layouts.
///
/// Example usage:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(FabrikSpacing.x2), // 8.0
/// )
/// ```
class FabrikSpacing {
  const FabrikSpacing._();

  /// Base spacing unit.
  ///
  /// All other values are relative to this.
  /// **Value:** 16.0 logical pixels
  static const double x4 = 16.0;

  /// Extra tight spacing.
  /// **Value:** 4.0 (x4 * 0.25)
  static const double x1 = x4 * 0.25;

  /// Tight spacing.
  /// **Value:** 8.0 (x4 * 0.5)
  static const double x2 = x4 * 0.5;

  /// Slightly tight spacing.
  /// **Value:** 12.0 (x4 * 0.75)
  static const double x3 = x4 * 0.75;

  /// Slightly loose spacing.
  /// **Value:** 20.0 (x4 * 1.25)
  static const double x5 = x4 * 1.25;

  /// Loose spacing.
  /// **Value:** 24.0 (x4 * 1.5)
  static const double x6 = x4 * 1.5;

  /// Spacious spacing.
  /// **Value:** 32.0 (x4 * 2.0)
  static const double x8 = x4 * 2.0;

  /// Extra spacious spacing.
  /// **Value:** 40.0 (x4 * 2.5)
  static const double x10 = x4 * 2.5;

  /// Very large spacing.
  /// **Value:** 48.0 (x4 * 3.0)
  static const double x12 = x4 * 3.0;

  /// Maximum recommended spacing.
  /// **Value:** 64.0 (x4 * 4.0)
  static const double x16 = x4 * 4.0;
}
