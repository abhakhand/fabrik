import 'package:flutter/widgets.dart';
import '../responsive/fabrik_responsive.dart';

/// A scalable icon size system based on a 4.0 unit grid.
///
/// `x6` (24.0) is the base icon size, matching Flutter’s default.
/// Other sizes are calculated as multipliers of this base for consistency.
class FabrikIconSizes {
  const FabrikIconSizes._();

  /// Base icon size (same as Flutter’s default).
  /// **Value:** 24.0
  static const double x6 = 24.0;

  /// Extra-extra-small — typically for badges.
  /// **Value:** 6.0
  static const double x1 = x6 * 0.25;

  /// Extra-small — used for dense UIs.
  /// **Value:** 12.0
  static const double x3 = x6 * 0.5;

  /// Small — for secondary icons.
  /// **Value:** 18.0
  static const double x4 = x6 * 0.75;

  /// Medium — slightly smaller than base.
  /// **Value:** 20.0
  static const double x5 = x6 * 0.833;

  /// Large — for primary icons.
  /// **Value:** 28.0
  static const double x7 = x6 * 1.166;

  /// Extra-large — used for avatars or buttons.
  /// **Value:** 32.0
  static const double x8 = x6 * 1.333;

  /// Hero — extra large icons.
  /// **Value:** 36.0
  static const double x9 = x6 * 1.5;

  // === Responsive presets ===

  /// Responsive small icon size.
  ///
  /// Typically for secondary icons or tight UIs.
  static double small(BuildContext context) =>
      FabrikResponsive.value(context, mobile: x4, tablet: x4, desktop: x5);

  /// Responsive regular icon size.
  ///
  /// Default size for most interactive icons.
  static double regular(BuildContext context) =>
      FabrikResponsive.value(context, mobile: x6, tablet: x6, desktop: x7);

  /// Responsive large icon size.
  ///
  /// For hero icons or larger sections.
  static double large(BuildContext context) =>
      FabrikResponsive.value(context, mobile: x7, tablet: x7, desktop: x8);

  /// Custom responsive icon size defined by the caller.
  ///
  /// Example:
  /// ```dart
  /// Icon(
  ///   Icons.star,
  ///   size: FabrikIconSizes.custom(
  ///     context,
  ///     mobile: 20,
  ///     tablet: 28,
  ///     desktop: 32,
  ///   ),
  /// );
  /// ```
  static double custom(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return FabrikResponsive.value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
