import 'package:flutter/widgets.dart';
import 'fabrik_spacing.dart';
import '../responsive/fabrik_responsive.dart';

/// A padding utility based on the `FabrikSpacing` system.
///
/// Provides a consistent set of `EdgeInsets` values using a 4px grid,
/// along with a responsive `contentPadding` for layout-aware views.
///
/// Use this class to avoid magic numbers and enforce spacing consistency
/// across the UI.
class FabrikPaddings {
  const FabrikPaddings._();

  // === Uniform (all sides) ===

  /// All-side padding of 4.0 (x1)
  static const EdgeInsets x1 = EdgeInsets.all(FabrikSpacing.x1);

  /// All-side padding of 8.0 (x2)
  static const EdgeInsets x2 = EdgeInsets.all(FabrikSpacing.x2);

  /// All-side padding of 12.0 (x3)
  static const EdgeInsets x3 = EdgeInsets.all(FabrikSpacing.x3);

  /// All-side padding of 16.0 (x4)
  static const EdgeInsets x4 = EdgeInsets.all(FabrikSpacing.x4);

  /// All-side padding of 20.0 (x5)
  static const EdgeInsets x5 = EdgeInsets.all(FabrikSpacing.x5);

  /// All-side padding of 24.0 (x6)
  static const EdgeInsets x6 = EdgeInsets.all(FabrikSpacing.x6);

  // === Horizontal-only ===

  /// Horizontal padding of 8.0 (x2)
  static const EdgeInsets horizontalX2 = EdgeInsets.symmetric(
    horizontal: FabrikSpacing.x2,
  );

  /// Horizontal padding of 12.0 (x3)
  static const EdgeInsets horizontalX3 = EdgeInsets.symmetric(
    horizontal: FabrikSpacing.x3,
  );

  /// Horizontal padding of 16.0 (x4)
  static const EdgeInsets horizontalX4 = EdgeInsets.symmetric(
    horizontal: FabrikSpacing.x4,
  );

  /// Horizontal padding of 20.0 (x5)
  static const EdgeInsets horizontalX5 = EdgeInsets.symmetric(
    horizontal: FabrikSpacing.x5,
  );

  /// Horizontal padding of 24.0 (x6)
  static const EdgeInsets horizontalX6 = EdgeInsets.symmetric(
    horizontal: FabrikSpacing.x6,
  );

  // === Vertical-only ===

  /// Vertical padding of 8.0 (x2)
  static const EdgeInsets verticalX2 = EdgeInsets.symmetric(
    vertical: FabrikSpacing.x2,
  );

  /// Vertical padding of 12.0 (x3)
  static const EdgeInsets verticalX3 = EdgeInsets.symmetric(
    vertical: FabrikSpacing.x3,
  );

  /// Vertical padding of 16.0 (x4)
  static const EdgeInsets verticalX4 = EdgeInsets.symmetric(
    vertical: FabrikSpacing.x4,
  );

  /// Vertical padding of 20.0 (x5)
  static const EdgeInsets verticalX5 = EdgeInsets.symmetric(
    vertical: FabrikSpacing.x5,
  );

  /// Vertical padding of 24.0 (x6)
  static const EdgeInsets verticalX6 = EdgeInsets.symmetric(
    vertical: FabrikSpacing.x6,
  );

  // === Responsive content padding ===

  /// Responsive content padding for use in screens, cards, dialogs, etc.
  ///
  /// Returns symmetric horizontal/vertical padding based on screen size:
  /// - **Small phones:** H:16 (x4), V:12 (x3)
  /// - **Phones/Tablets:** H:20 (x5), V:16 (x4)
  /// - **Desktop/Web:** H:24 (x6), V:20 (x5)
  static EdgeInsets contentPadding(BuildContext context) {
    return FabrikResponsive.value(
      context,
      mobile: const EdgeInsets.symmetric(
        horizontal: FabrikSpacing.x4,
        vertical: FabrikSpacing.x3,
      ),
      tablet: const EdgeInsets.symmetric(
        horizontal: FabrikSpacing.x5,
        vertical: FabrikSpacing.x4,
      ),
      desktop: const EdgeInsets.symmetric(
        horizontal: FabrikSpacing.x6,
        vertical: FabrikSpacing.x5,
      ),
    );
  }

  /// Custom responsive padding defined by the caller.
  ///
  /// Use when you want different padding values for each breakpoint.
  ///
  /// Example:
  /// ```dart
  /// Padding(
  ///   padding: FabrikPaddings.custom(
  ///     context,
  ///     mobile: EdgeInsets.all(12),
  ///     tablet: EdgeInsets.symmetric(horizontal: 20),
  ///     desktop: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
  ///   ),
  /// );
  /// ```
  static EdgeInsets custom(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    return FabrikResponsive.value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
