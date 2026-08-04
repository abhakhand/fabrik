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

  /// Color used to signal errors, validation failures, and destructive actions.
  static const error = Color(0xFFB3261E);

  /// The color used for text and icons displayed on error backgrounds.
  static const onError = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Dark palette
  // ---------------------------------------------------------------------------

  /// The primary brand color used on dark surfaces.
  static const primaryDark = Color(0xFFD0BCFF);

  /// The color used for text and icons displayed on [primaryDark].
  static const onPrimaryDark = Color(0xFF381E72);

  /// A supporting accent color used on dark surfaces.
  static const accentDark = Color(0xFFCCC2DC);

  /// The color used for text and icons displayed on [accentDark].
  static const onAccentDark = Color(0xFF332D41);

  /// Background color used for the main application surface in dark mode.
  static const surfaceDark = Color(0xFF141218);

  /// Color used for text and icons displayed on [surfaceDark].
  static const onSurfaceDark = Color(0xFFE6E0E9);

  /// Primary text color used for high-emphasis content in dark mode.
  static const textPrimaryDark = Color(0xFFE6E0E9);

  /// Secondary text color used for supporting content in dark mode.
  static const textSecondaryDark = Color(0xFFCAC4D0);

  /// Tertiary text color used for low-emphasis content in dark mode.
  static const textTertiaryDark = Color(0xFF938F99);

  /// Error color used on dark surfaces.
  static const errorDark = Color(0xFFF2B8B5);

  /// The color used for text and icons displayed on [errorDark].
  static const onErrorDark = Color(0xFF601410);
}
