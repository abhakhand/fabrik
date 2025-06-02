import 'package:fabrik_theme/src/responsive/fabrik_layout.dart';
import 'package:flutter/material.dart';

class FabrikResponsive {
  const FabrikResponsive._();

  /// Minimum width required on desktop/web platforms to enable desktop layout
  static const double _desktopThreshold = 700.0;

  /// Minimum width required on mobile/tablet in landscape to enable desktop layout
  static const double _mobileLandscapeDesktopThreshold = 740.0;

  /// Determines whether the current screen should behave as a mobile or desktop layout,
  /// based on platform, width, and orientation.
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

    // Desktop or Web
    if (isDesktopPlatform) {
      return width >= _desktopThreshold
          ? FabrikLayout.desktop
          : FabrikLayout.mobile;
    }

    // Mobile/Tablet
    if (isLandscape && width >= _mobileLandscapeDesktopThreshold) {
      return FabrikLayout.desktop;
    }

    return FabrikLayout.mobile;
  }

  static bool isDesktop(BuildContext context) =>
      layoutOf(context) == FabrikLayout.desktop;

  static bool isMobile(BuildContext context) =>
      layoutOf(context) == FabrikLayout.mobile;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    required T desktop,
  }) {
    return isDesktop(context) ? desktop : mobile;
  }
}
