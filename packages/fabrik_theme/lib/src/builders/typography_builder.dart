import 'package:fabrik_theme/src/extensions/extensions.dart';
import 'package:fabrik_theme/src/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// Builds a fully resolved [AppTypography] instance from semantic color inputs.
///
/// This builder is responsible for composing typography tokens with
/// application color semantics. It must be executed at theme construction
/// time and never from widget build methods.
///
/// Widgets should only consume the resulting [AppTypography] via the active
/// [ThemeData] and must not perform additional typography composition.
class FabrikTypographyBuilder {
  /// Creates an [AppTypography] configuration using the provided [AppColors].
  ///
  /// The resulting typography:
  /// - Uses primary text color for high-emphasis text
  /// - Uses secondary and tertiary text colors for body emphasis variants
  /// - Uses the app primary color for accent display, headline, title, and label styles
  static AppTypography build(AppColors colors, {String? fontFamily}) {
    TextStyle baseStyle(TextStyle style) =>
        fontFamily == null ? style : style.copyWith(fontFamily: fontFamily);

    TextStyle primary(TextStyle style) =>
        baseStyle(style).copyWith(color: colors.textPrimary);

    TextStyle secondary(TextStyle style) =>
        baseStyle(style).copyWith(color: colors.textSecondary);

    TextStyle tertiary(TextStyle style) =>
        baseStyle(style).copyWith(color: colors.textTertiary);

    TextStyle accent(TextStyle style) =>
        baseStyle(style).copyWith(color: colors.primary);

    TextStyle emphasis(TextStyle style) => baseStyle(
      style,
    ).copyWith(color: colors.textPrimary, fontWeight: FontWeight.w500);

    return AppTypography(
      // ---------------------------------------------------------------------
      // Display
      // ---------------------------------------------------------------------
      displayLarge: primary(TypographyTokens.displayLarge),
      displayMedium: primary(TypographyTokens.displayMedium),
      displaySmall: primary(TypographyTokens.displaySmall),

      displayLargePrimary: accent(TypographyTokens.displayLarge),
      displayMediumPrimary: accent(TypographyTokens.displayMedium),
      displaySmallPrimary: accent(TypographyTokens.displaySmall),

      // ---------------------------------------------------------------------
      // Headlines
      // ---------------------------------------------------------------------
      headlineLarge: primary(TypographyTokens.headlineLarge),
      headlineMedium: primary(TypographyTokens.headlineMedium),
      headlineSmall: primary(TypographyTokens.headlineSmall),

      headlineLargePrimary: accent(TypographyTokens.headlineLarge),
      headlineMediumPrimary: accent(TypographyTokens.headlineMedium),
      headlineSmallPrimary: accent(TypographyTokens.headlineSmall),

      // ---------------------------------------------------------------------
      // Titles
      // ---------------------------------------------------------------------
      titleLarge: primary(TypographyTokens.titleLarge),
      titleMedium: primary(TypographyTokens.titleMedium),
      titleSmall: primary(TypographyTokens.titleSmall),

      titleLargePrimary: accent(TypographyTokens.titleLarge),
      titleMediumPrimary: accent(TypographyTokens.titleMedium),
      titleSmallPrimary: accent(TypographyTokens.titleSmall),

      // ---------------------------------------------------------------------
      // Body
      // ---------------------------------------------------------------------
      bodyLarge: primary(TypographyTokens.bodyLarge),
      bodyMedium: primary(TypographyTokens.bodyMedium),
      bodySmall: primary(TypographyTokens.bodySmall),

      bodyLargeSecondary: secondary(TypographyTokens.bodyLarge),
      bodyMediumSecondary: secondary(TypographyTokens.bodyMedium),
      bodySmallSecondary: secondary(TypographyTokens.bodySmall),

      bodyLargeTertiary: tertiary(TypographyTokens.bodyLarge),
      bodyMediumTertiary: tertiary(TypographyTokens.bodyMedium),
      bodySmallTertiary: tertiary(TypographyTokens.bodySmall),

      bodyLargeEmphasis: emphasis(TypographyTokens.bodyLarge),
      bodyMediumEmphasis: emphasis(TypographyTokens.bodyMedium),
      bodySmallEmphasis: emphasis(TypographyTokens.bodySmall),

      // ---------------------------------------------------------------------
      // Labels
      // ---------------------------------------------------------------------
      labelLarge: accent(TypographyTokens.labelLarge),
      labelMedium: accent(TypographyTokens.labelMedium),
      labelSmall: accent(TypographyTokens.labelSmall),

      labelLargeSecondary: secondary(TypographyTokens.labelLarge),
      labelMediumSecondary: secondary(TypographyTokens.labelMedium),
      labelSmallSecondary: secondary(TypographyTokens.labelSmall),
    );
  }
}
