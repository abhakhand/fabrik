import 'package:flutter/material.dart';

/// Defines the base color tokens for the design system.
///
/// Color tokens represent raw, context-independent color values.
/// They provide a minimal, opinionated palette that can be used
/// as defaults or reference values when constructing application
/// themes.
///
/// These tokens should not be accessed directly from widgets.
/// Instead, they are composed into semantic color roles via
/// [AppColors] during theme creation.
abstract final class ColorTokens {
  /// The primary brand color.
  static const primary = Color(0xFF6750A4);

  /// The color used for text and icons displayed on primary backgrounds.
  static const onPrimary = Color(0xFFFFFFFF);

  /// A supporting accent color used alongside the primary brand color.
  static const accent = Color(0xFF625B71);

  /// The color used for text and icons displayed on accent backgrounds.
  static const onAccent = Color(0xFFFFFFFF);

  /// Background color used for the main application surface.
  static const surface = Color(0xFFFFFFFF);

  /// Color used for text and icons displayed on surface backgrounds.
  static const onSurface = Color(0xFF000000);

  /// Primary text color used for high-emphasis content.
  static const textPrimary = Color(0xFF000000);

  /// Secondary text color used for supporting content.
  static const textSecondary = Color(0xFF49454F);

  /// Tertiary text color used for low-emphasis or helper content.
  static const textTertiary = Color(0xFF79747E);
}
