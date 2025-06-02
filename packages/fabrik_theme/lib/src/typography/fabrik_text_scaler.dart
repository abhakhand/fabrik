import 'package:fabrik_theme/src/responsive/responsive.dart';
import 'package:flutter/widgets.dart';

/// A utility for scaling text responsively using Flutter's [TextScaler].
///
/// Use this to apply responsive text scaling in a clean and consistent way
/// across layouts.
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

  /// Returns a [TextScaler.linear] with optional layout-specific factors.
  ///
  /// If no custom scale values are provided, defaults are:
  /// - Mobile: 1.0
  /// - Desktop: 1.2
  static TextScaler linear(
    BuildContext context, {
    double mobile = 1.0,
    double? desktop,
  }) {
    final scale = FabrikResponsive.value(
      context,
      mobile: mobile,
      desktop: desktop ?? 1.2,
    );

    return TextScaler.linear(scale);
  }
}
