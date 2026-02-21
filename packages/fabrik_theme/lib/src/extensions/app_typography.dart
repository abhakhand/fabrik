import 'package:fabrik_theme/src/tokens/typography_tokens.dart';
import 'package:flutter/material.dart';

/// A semantic typography contract for the application.
///
/// `AppTypography` represents fully resolved text styles that are consumed
/// directly by UI widgets. All styles exposed here are expected to be
/// theme-aware and stable for the lifetime of the active [ThemeData].
///
/// This class intentionally exposes only semantic variants. Mechanical
/// differences such as font size, weight, or color composition must be
/// resolved during theme construction, not in widgets.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  // ---------------------------------------------------------------------------
  // Display styles
  // ---------------------------------------------------------------------------

  /// Primary display styles used for hero and marketing content.
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  /// Display styles using the app primary color for accent emphasis.
  final TextStyle displayLargePrimary;
  final TextStyle displayMediumPrimary;
  final TextStyle displaySmallPrimary;

  // ---------------------------------------------------------------------------
  // Headline styles
  // ---------------------------------------------------------------------------

  /// Primary headline styles used for screen and section headers.
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  /// Headline styles using the app primary color for accent emphasis.
  final TextStyle headlineLargePrimary;
  final TextStyle headlineMediumPrimary;
  final TextStyle headlineSmallPrimary;

  // ---------------------------------------------------------------------------
  // Title styles
  // ---------------------------------------------------------------------------

  /// Primary title styles used for cards, list items, and subsections.
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  /// Title styles using the app primary color for accent emphasis.
  final TextStyle titleLargePrimary;
  final TextStyle titleMediumPrimary;
  final TextStyle titleSmallPrimary;

  // ---------------------------------------------------------------------------
  // Body styles
  // ---------------------------------------------------------------------------

  /// Primary body text styles for main content.
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  /// Secondary body text styles for supporting or descriptive content.
  final TextStyle bodyLargeSecondary;
  final TextStyle bodyMediumSecondary;
  final TextStyle bodySmallSecondary;

  /// Tertiary body text styles for low-emphasis or helper content.
  final TextStyle bodyLargeTertiary;
  final TextStyle bodyMediumTertiary;
  final TextStyle bodySmallTertiary;

  /// Emphasized body text styles for inline emphasis and highlighted values.
  ///
  /// These styles should be used when body text requires stronger visual
  /// emphasis without changing its semantic role.
  final TextStyle bodyLargeEmphasis;
  final TextStyle bodyMediumEmphasis;
  final TextStyle bodySmallEmphasis;

  // ---------------------------------------------------------------------------
  // Label styles
  // ---------------------------------------------------------------------------

  /// Primary label styles used for buttons, chips, and controls.
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  /// Secondary label styles used for de-emphasized or disabled labels.
  final TextStyle labelLargeSecondary;
  final TextStyle labelMediumSecondary;
  final TextStyle labelSmallSecondary;

  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.displayLargePrimary,
    required this.displayMediumPrimary,
    required this.displaySmallPrimary,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.headlineLargePrimary,
    required this.headlineMediumPrimary,
    required this.headlineSmallPrimary,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.titleLargePrimary,
    required this.titleMediumPrimary,
    required this.titleSmallPrimary,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.bodyLargeSecondary,
    required this.bodyMediumSecondary,
    required this.bodySmallSecondary,
    required this.bodyLargeTertiary,
    required this.bodyMediumTertiary,
    required this.bodySmallTertiary,
    required this.bodyLargeEmphasis,
    required this.bodyMediumEmphasis,
    required this.bodySmallEmphasis,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.labelLargeSecondary,
    required this.labelMediumSecondary,
    required this.labelSmallSecondary,
  });

  /// Creates a default typography configuration using explicit color inputs.
  ///
  /// This factory exists for fallback, testing, and demo purposes only.
  /// Production applications are expected to construct typography using
  /// [FabrikTypographyBuilder.build], which derives colors from [AppColors].
  ///
  /// - [textPrimary] is used for base display, headline, title, and body styles.
  /// - [textSecondary] is used for secondary body and label variants.
  /// - [textTertiary] is used for tertiary body variants.
  /// - [primary] is used for the `*Primary` accent variants (e.g.
  ///   [displayLargePrimary], [headlineLargePrimary]) and primary labels.
  factory AppTypography.defaults({
    Color textPrimary = Colors.black,
    Color textSecondary = const Color(0xFF49454F),
    Color textTertiary = const Color(0xFF79747E),
    Color primary = const Color(0xFF6750A4),
  }) {
    TextStyle withPrimary(TextStyle base) => base.copyWith(color: textPrimary);
    TextStyle withSecondary(TextStyle base) =>
        base.copyWith(color: textSecondary);
    TextStyle withTertiary(TextStyle base) => base.copyWith(color: textTertiary);
    TextStyle withAccent(TextStyle base) => base.copyWith(color: primary);
    TextStyle withEmphasis(TextStyle base) =>
        base.copyWith(color: textPrimary, fontWeight: FontWeight.w500);

    return AppTypography(
      // Display
      displayLarge: withPrimary(TypographyTokens.displayLarge),
      displayMedium: withPrimary(TypographyTokens.displayMedium),
      displaySmall: withPrimary(TypographyTokens.displaySmall),
      displayLargePrimary: withAccent(TypographyTokens.displayLarge),
      displayMediumPrimary: withAccent(TypographyTokens.displayMedium),
      displaySmallPrimary: withAccent(TypographyTokens.displaySmall),

      // Headlines
      headlineLarge: withPrimary(TypographyTokens.headlineLarge),
      headlineMedium: withPrimary(TypographyTokens.headlineMedium),
      headlineSmall: withPrimary(TypographyTokens.headlineSmall),
      headlineLargePrimary: withAccent(TypographyTokens.headlineLarge),
      headlineMediumPrimary: withAccent(TypographyTokens.headlineMedium),
      headlineSmallPrimary: withAccent(TypographyTokens.headlineSmall),

      // Titles
      titleLarge: withPrimary(TypographyTokens.titleLarge),
      titleMedium: withPrimary(TypographyTokens.titleMedium),
      titleSmall: withPrimary(TypographyTokens.titleSmall),
      titleLargePrimary: withAccent(TypographyTokens.titleLarge),
      titleMediumPrimary: withAccent(TypographyTokens.titleMedium),
      titleSmallPrimary: withAccent(TypographyTokens.titleSmall),

      // Body
      bodyLarge: withPrimary(TypographyTokens.bodyLarge),
      bodyMedium: withPrimary(TypographyTokens.bodyMedium),
      bodySmall: withPrimary(TypographyTokens.bodySmall),
      bodyLargeSecondary: withSecondary(TypographyTokens.bodyLarge),
      bodyMediumSecondary: withSecondary(TypographyTokens.bodyMedium),
      bodySmallSecondary: withSecondary(TypographyTokens.bodySmall),
      bodyLargeTertiary: withTertiary(TypographyTokens.bodyLarge),
      bodyMediumTertiary: withTertiary(TypographyTokens.bodyMedium),
      bodySmallTertiary: withTertiary(TypographyTokens.bodySmall),
      bodyLargeEmphasis: withEmphasis(TypographyTokens.bodyLarge),
      bodyMediumEmphasis: withEmphasis(TypographyTokens.bodyMedium),
      bodySmallEmphasis: withEmphasis(TypographyTokens.bodySmall),

      // Labels
      labelLarge: withAccent(TypographyTokens.labelLarge),
      labelMedium: withAccent(TypographyTokens.labelMedium),
      labelSmall: withAccent(TypographyTokens.labelSmall),
      labelLargeSecondary: withSecondary(TypographyTokens.labelLarge),
      labelMediumSecondary: withSecondary(TypographyTokens.labelMedium),
      labelSmallSecondary: withSecondary(TypographyTokens.labelSmall),
    );
  }

  @override
  AppTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? displayLargePrimary,
    TextStyle? displayMediumPrimary,
    TextStyle? displaySmallPrimary,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? headlineLargePrimary,
    TextStyle? headlineMediumPrimary,
    TextStyle? headlineSmallPrimary,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? titleLargePrimary,
    TextStyle? titleMediumPrimary,
    TextStyle? titleSmallPrimary,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? bodyLargeSecondary,
    TextStyle? bodyMediumSecondary,
    TextStyle? bodySmallSecondary,
    TextStyle? bodyLargeTertiary,
    TextStyle? bodyMediumTertiary,
    TextStyle? bodySmallTertiary,
    TextStyle? bodyLargeEmphasis,
    TextStyle? bodyMediumEmphasis,
    TextStyle? bodySmallEmphasis,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? labelLargeSecondary,
    TextStyle? labelMediumSecondary,
    TextStyle? labelSmallSecondary,
  }) {
    return AppTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      displayLargePrimary: displayLargePrimary ?? this.displayLargePrimary,
      displayMediumPrimary: displayMediumPrimary ?? this.displayMediumPrimary,
      displaySmallPrimary: displaySmallPrimary ?? this.displaySmallPrimary,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      headlineLargePrimary: headlineLargePrimary ?? this.headlineLargePrimary,
      headlineMediumPrimary:
          headlineMediumPrimary ?? this.headlineMediumPrimary,
      headlineSmallPrimary: headlineSmallPrimary ?? this.headlineSmallPrimary,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      titleLargePrimary: titleLargePrimary ?? this.titleLargePrimary,
      titleMediumPrimary: titleMediumPrimary ?? this.titleMediumPrimary,
      titleSmallPrimary: titleSmallPrimary ?? this.titleSmallPrimary,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyLargeSecondary: bodyLargeSecondary ?? this.bodyLargeSecondary,
      bodyMediumSecondary: bodyMediumSecondary ?? this.bodyMediumSecondary,
      bodySmallSecondary: bodySmallSecondary ?? this.bodySmallSecondary,
      bodyLargeTertiary: bodyLargeTertiary ?? this.bodyLargeTertiary,
      bodyMediumTertiary: bodyMediumTertiary ?? this.bodyMediumTertiary,
      bodySmallTertiary: bodySmallTertiary ?? this.bodySmallTertiary,
      bodyLargeEmphasis: bodyLargeEmphasis ?? this.bodyLargeEmphasis,
      bodyMediumEmphasis: bodyMediumEmphasis ?? this.bodyMediumEmphasis,
      bodySmallEmphasis: bodySmallEmphasis ?? this.bodySmallEmphasis,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      labelLargeSecondary: labelLargeSecondary ?? this.labelLargeSecondary,
      labelMediumSecondary: labelMediumSecondary ?? this.labelMediumSecondary,
      labelSmallSecondary: labelSmallSecondary ?? this.labelSmallSecondary,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return copyWith(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t),
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t),
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t),
      displayLargePrimary: TextStyle.lerp(
        displayLargePrimary,
        other.displayLargePrimary,
        t,
      ),
      displayMediumPrimary: TextStyle.lerp(
        displayMediumPrimary,
        other.displayMediumPrimary,
        t,
      ),
      displaySmallPrimary: TextStyle.lerp(
        displaySmallPrimary,
        other.displaySmallPrimary,
        t,
      ),
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t),
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t),
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t),
      headlineLargePrimary: TextStyle.lerp(
        headlineLargePrimary,
        other.headlineLargePrimary,
        t,
      ),
      headlineMediumPrimary: TextStyle.lerp(
        headlineMediumPrimary,
        other.headlineMediumPrimary,
        t,
      ),
      headlineSmallPrimary: TextStyle.lerp(
        headlineSmallPrimary,
        other.headlineSmallPrimary,
        t,
      ),
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t),
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t),
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t),
      titleLargePrimary: TextStyle.lerp(
        titleLargePrimary,
        other.titleLargePrimary,
        t,
      ),
      titleMediumPrimary: TextStyle.lerp(
        titleMediumPrimary,
        other.titleMediumPrimary,
        t,
      ),
      titleSmallPrimary: TextStyle.lerp(
        titleSmallPrimary,
        other.titleSmallPrimary,
        t,
      ),
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t),
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t),
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t),
      bodyLargeSecondary: TextStyle.lerp(
        bodyLargeSecondary,
        other.bodyLargeSecondary,
        t,
      ),
      bodyMediumSecondary: TextStyle.lerp(
        bodyMediumSecondary,
        other.bodyMediumSecondary,
        t,
      ),
      bodySmallSecondary: TextStyle.lerp(
        bodySmallSecondary,
        other.bodySmallSecondary,
        t,
      ),
      bodyLargeTertiary: TextStyle.lerp(
        bodyLargeTertiary,
        other.bodyLargeTertiary,
        t,
      ),
      bodyMediumTertiary: TextStyle.lerp(
        bodyMediumTertiary,
        other.bodyMediumTertiary,
        t,
      ),
      bodySmallTertiary: TextStyle.lerp(
        bodySmallTertiary,
        other.bodySmallTertiary,
        t,
      ),
      bodyLargeEmphasis: TextStyle.lerp(
        bodyLargeEmphasis,
        other.bodyLargeEmphasis,
        t,
      ),
      bodyMediumEmphasis: TextStyle.lerp(
        bodyMediumEmphasis,
        other.bodyMediumEmphasis,
        t,
      ),
      bodySmallEmphasis: TextStyle.lerp(
        bodySmallEmphasis,
        other.bodySmallEmphasis,
        t,
      ),
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t),
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t),
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t),
      labelLargeSecondary: TextStyle.lerp(
        labelLargeSecondary,
        other.labelLargeSecondary,
        t,
      ),
      labelMediumSecondary: TextStyle.lerp(
        labelMediumSecondary,
        other.labelMediumSecondary,
        t,
      ),
      labelSmallSecondary: TextStyle.lerp(
        labelSmallSecondary,
        other.labelSmallSecondary,
        t,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppTypography) return false;
    return displayLarge == other.displayLarge &&
        displayMedium == other.displayMedium &&
        displaySmall == other.displaySmall &&
        displayLargePrimary == other.displayLargePrimary &&
        displayMediumPrimary == other.displayMediumPrimary &&
        displaySmallPrimary == other.displaySmallPrimary &&
        headlineLarge == other.headlineLarge &&
        headlineMedium == other.headlineMedium &&
        headlineSmall == other.headlineSmall &&
        headlineLargePrimary == other.headlineLargePrimary &&
        headlineMediumPrimary == other.headlineMediumPrimary &&
        headlineSmallPrimary == other.headlineSmallPrimary &&
        titleLarge == other.titleLarge &&
        titleMedium == other.titleMedium &&
        titleSmall == other.titleSmall &&
        titleLargePrimary == other.titleLargePrimary &&
        titleMediumPrimary == other.titleMediumPrimary &&
        titleSmallPrimary == other.titleSmallPrimary &&
        bodyLarge == other.bodyLarge &&
        bodyMedium == other.bodyMedium &&
        bodySmall == other.bodySmall &&
        bodyLargeSecondary == other.bodyLargeSecondary &&
        bodyMediumSecondary == other.bodyMediumSecondary &&
        bodySmallSecondary == other.bodySmallSecondary &&
        bodyLargeTertiary == other.bodyLargeTertiary &&
        bodyMediumTertiary == other.bodyMediumTertiary &&
        bodySmallTertiary == other.bodySmallTertiary &&
        bodyLargeEmphasis == other.bodyLargeEmphasis &&
        bodyMediumEmphasis == other.bodyMediumEmphasis &&
        bodySmallEmphasis == other.bodySmallEmphasis &&
        labelLarge == other.labelLarge &&
        labelMedium == other.labelMedium &&
        labelSmall == other.labelSmall &&
        labelLargeSecondary == other.labelLargeSecondary &&
        labelMediumSecondary == other.labelMediumSecondary &&
        labelSmallSecondary == other.labelSmallSecondary;
  }

  @override
  int get hashCode => Object.hashAll([
    displayLarge,
    displayMedium,
    displaySmall,
    displayLargePrimary,
    displayMediumPrimary,
    displaySmallPrimary,
    headlineLarge,
    headlineMedium,
    headlineSmall,
    headlineLargePrimary,
    headlineMediumPrimary,
    headlineSmallPrimary,
    titleLarge,
    titleMedium,
    titleSmall,
    titleLargePrimary,
    titleMediumPrimary,
    titleSmallPrimary,
    bodyLarge,
    bodyMedium,
    bodySmall,
    bodyLargeSecondary,
    bodyMediumSecondary,
    bodySmallSecondary,
    bodyLargeTertiary,
    bodyMediumTertiary,
    bodySmallTertiary,
    bodyLargeEmphasis,
    bodyMediumEmphasis,
    bodySmallEmphasis,
    labelLarge,
    labelMedium,
    labelSmall,
    labelLargeSecondary,
    labelMediumSecondary,
    labelSmallSecondary,
  ]);
}
