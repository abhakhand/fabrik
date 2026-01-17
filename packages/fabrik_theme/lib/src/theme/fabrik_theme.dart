import 'package:fabrik_theme/src/builders/builders.dart';
import 'package:fabrik_theme/src/extensions/extensions.dart';
import 'package:flutter/material.dart';

/// Factory for constructing a fully configured [ThemeData] instance
/// using Fabrik design system primitives.
///
/// [FabrikTheme] composes semantic colors and typography into Flutter's
/// theming system. It is intended to be the single entry point for
/// initializing application themes.
///
/// This class does not hold state and should not be instantiated.
class FabrikTheme {
  const FabrikTheme._();

  /// Creates a [ThemeData] instance using Fabrik theming conventions.
  ///
  /// The caller must provide [brightness] and [colors]. Typography is
  /// optional and will be automatically derived from the provided colors
  /// if not supplied.
  ///
  /// The optional [fontFamily] is applied uniformly across all typography
  /// styles when typography is built internally. If a custom [typography]
  /// instance is provided, [fontFamily] is ignored.
  static ThemeData create({
    required Brightness brightness,
    required AppColors colors,
    AppTypography? typography,
    String? fontFamily,
  }) {
    final resolvedTypography =
        typography ??
        FabrikTypographyBuilder.build(colors, fontFamily: fontFamily);

    return ThemeData(
      brightness: brightness,
      fontFamily: fontFamily,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.primary,
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.accent,
        onSecondary: colors.onAccent,
        surface: colors.surface,
        onSurface: colors.onSurface,
      ),
      textTheme: TextTheme(
        displayLarge: resolvedTypography.displayLarge,
        displayMedium: resolvedTypography.displayMedium,
        displaySmall: resolvedTypography.displaySmall,
        headlineLarge: resolvedTypography.headlineLarge,
        headlineMedium: resolvedTypography.headlineMedium,
        headlineSmall: resolvedTypography.headlineSmall,
        titleLarge: resolvedTypography.titleLarge,
        titleMedium: resolvedTypography.titleMedium,
        titleSmall: resolvedTypography.titleSmall,
        bodyLarge: resolvedTypography.bodyLarge,
        bodyMedium: resolvedTypography.bodyMedium,
        bodySmall: resolvedTypography.bodySmall,
        labelLarge: resolvedTypography.labelLarge,
        labelMedium: resolvedTypography.labelMedium,
        labelSmall: resolvedTypography.labelSmall,
      ),
      extensions: [colors, resolvedTypography],
    );
  }
}
