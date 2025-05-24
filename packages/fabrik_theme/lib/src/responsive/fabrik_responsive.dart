import 'package:flutter/widgets.dart';
import 'fabrik_breakpoint.dart';

/// A responsive utility that determines breakpoints and responsive values
/// based on screen dimensions using Flutter's `MediaQuery`.
///
/// `FabrikResponsive` helps tailor UI behavior across different screen sizes
/// (mobile, tablet, desktop) while accounting for device orientation.
/// It uses the screen’s `shortestSide` to ensure consistent behavior
/// regardless of portrait or landscape layout.
class FabrikResponsive {
  const FabrikResponsive._();

  /// Returns the current [FabrikBreakpoint] for the screen.
  ///
  /// This method uses the `shortestSide` of the screen to provide
  /// orientation-aware classification (e.g., a tablet in portrait mode
  /// still counts as a tablet).
  static FabrikBreakpoint breakpointOf(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final shortest = size.shortestSide;

    if (shortest >= FabrikBreakpoint.desktop.value) {
      return FabrikBreakpoint.desktop;
    } else if (shortest >= FabrikBreakpoint.tablet.value) {
      return FabrikBreakpoint.tablet;
    } else {
      return FabrikBreakpoint.mobile;
    }
  }

  /// Returns `true` if the current screen is in the mobile range.
  static bool isMobile(BuildContext context) =>
      breakpointOf(context) == FabrikBreakpoint.mobile;

  /// Returns `true` if the current screen is in the tablet range.
  static bool isTablet(BuildContext context) =>
      breakpointOf(context) == FabrikBreakpoint.tablet;

  /// Returns `true` if the current screen is in the desktop range.
  static bool isDesktop(BuildContext context) =>
      breakpointOf(context) == FabrikBreakpoint.desktop;

  /// Returns `true` if the screen is currently in portrait orientation.
  ///
  /// Useful when layout needs to adapt not just to screen size,
  /// but also based on the vertical or horizontal layout context.
  static bool isPortrait(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.height >= size.width;
  }

  /// Returns `true` if the screen is currently in landscape orientation.
  ///
  /// This is useful for conditional layout adjustments when the device
  /// is rotated or placed in a wider viewing context.
  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width > size.height;
  }

  /// Returns a value based on the active breakpoint.
  ///
  /// This utility helps apply responsive values (e.g., spacing, sizes, styles)
  /// depending on the screen size.
  ///
  /// Example:
  /// ```dart
  /// final iconSize = FabrikResponsive.value(
  ///   context,
  ///   mobile: 20.0,
  ///   tablet: 24.0,
  ///   desktop: 32.0,
  /// );
  /// ```
  ///
  /// If a `tablet` or `desktop` value is not provided, it will fallback
  /// to the next available value, typically `mobile`.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final bp = breakpointOf(context);
    switch (bp) {
      case FabrikBreakpoint.desktop:
        return desktop ?? tablet ?? mobile;
      case FabrikBreakpoint.tablet:
        return tablet ?? mobile;
      case FabrikBreakpoint.mobile:
        return mobile;
    }
  }
}
