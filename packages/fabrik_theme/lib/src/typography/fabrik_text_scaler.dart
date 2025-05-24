import 'package:fabrik_theme/src/responsive/responsive.dart';
import 'package:flutter/widgets.dart';

/// A utility for scaling text responsively using Flutter's [TextScaler].
///
/// Use this to apply responsive text scaling in a clean and consistent way
/// across breakpoints.
///
/// Example:
/// ```dart
/// Text(
///   'Hello',
///   style: FabrikTypographyDefaults.bodyRegular,
///   textScaler: FabrikTextScaler.linear(context),
/// );
/// ```
class FabrikTextScaler {
  const FabrikTextScaler._();

  /// Returns a [TextScaler.linear] with optional breakpoint-specific factors.
  ///
  /// If no custom scale values are provided, defaults are:
  /// - Mobile: 1.0
  /// - Tablet: 1.1
  /// - Desktop: 1.2
  static TextScaler linear(
    BuildContext context, {
    double mobile = 1.0,
    double? tablet,
    double? desktop,
  }) {
    final scale = FabrikResponsive.value(
      context,
      mobile: mobile,
      tablet: tablet ?? 1.1,
      desktop: desktop ?? 1.2,
    );

    return TextScaler.linear(scale);
  }
}
