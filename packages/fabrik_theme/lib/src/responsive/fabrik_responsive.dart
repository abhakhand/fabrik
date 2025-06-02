import 'package:flutter/material.dart';
import 'fabrik_layout.dart';

/// A responsive utility for classifying layout types in the Fabrik design system.
///
/// This system supports three layout buckets:
/// - `mobile` for narrow or vertically-oriented screens
/// - `tablet` for medium-sized widths
/// - `desktop` for wide, multi-column layouts
///
/// Behavior is based on platform, orientation, and screen width.
///
/// ### Rules:
/// - On **desktop platforms** (macOS, Windows, Linux):
///   - `desktop`: width ≥ 1024
///   - `tablet`: width ≥ 700 and < 1024
///   - `mobile`: width < 700
///
/// - On **mobile platforms** (Android, iOS):
///   - Always `mobile` in portrait
///   - In **landscape**:
///     - `desktop`: width ≥ 1024
///     - `tablet`: width ≥ 740 and < 1024
///     - `mobile`: width < 740
class FabrikResponsive {
  const FabrikResponsive._();

  /// Minimum width for a `tablet` layout on desktop platforms (macOS, Windows, Linux).
  static const double _minTabletWidthDesktopPlatform = 700.0;

  /// Minimum width for a `desktop` layout on all platforms.
  static const double _minDesktopWidth = 1024.0;

  /// Minimum width for a `tablet` layout on mobile platforms (in landscape).
  static const double _minTabletWidthMobileLandscape = 740.0;

  /// Returns the current [FabrikLayout] for the screen.
  static FabrikLayout layoutOf(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final isLandscape = width > height;

    final platform = Theme.of(context).platform;
    final isDesktopPlatform = [
      TargetPlatform.macOS,
      TargetPlatform.windows,
      TargetPlatform.linux,
    ].contains(platform);

    if (isDesktopPlatform) {
      if (width >= _minDesktopWidth) return FabrikLayout.desktop;
      if (width >= _minTabletWidthDesktopPlatform) return FabrikLayout.tablet;
      return FabrikLayout.mobile;
    }

    // On mobile platforms
    if (!isLandscape) {
      return FabrikLayout.mobile; // Always mobile in portrait
    }

    if (width >= _minDesktopWidth) return FabrikLayout.desktop;
    if (width >= _minTabletWidthMobileLandscape) return FabrikLayout.tablet;
    return FabrikLayout.mobile;
  }

  /// Returns `true` if the current layout is `mobile`.
  static bool isMobile(BuildContext context) =>
      layoutOf(context) == FabrikLayout.mobile;

  /// Returns `true` if the current layout is `tablet`.
  static bool isTablet(BuildContext context) =>
      layoutOf(context) == FabrikLayout.tablet;

  /// Returns `true` if the current layout is `desktop`.
  static bool isDesktop(BuildContext context) =>
      layoutOf(context) == FabrikLayout.desktop;

  /// Returns a responsive value based on the current layout.
  ///
  /// Example:
  /// ```dart
  /// final padding = FabrikResponsive.value(
  ///   context,
  ///   mobile: 16.0,
  ///   tablet: 24.0,
  ///   desktop: 32.0,
  /// );
  /// ```
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final layout = layoutOf(context);
    switch (layout) {
      case FabrikLayout.desktop:
        return desktop ?? tablet ?? mobile;
      case FabrikLayout.tablet:
        return tablet ?? mobile;
      case FabrikLayout.mobile:
        return mobile;
    }
  }
}
