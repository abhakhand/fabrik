import 'package:flutter/material.dart';

/// Defines the base typography tokens for the design system.
///
/// Typography tokens represent raw, context-independent text styles.
/// They define font sizes, line heights, and letter spacing,
/// but intentionally do not include colors or theme-specific logic.
///
/// These tokens are not meant to be used directly in widgets. Instead,
/// they serve as reference values that are composed into semantic
/// typography styles during theme construction.
abstract final class TypographyTokens {
  /// Large display text used for hero sections and marketing content.
  static const displayLarge = TextStyle(
    fontSize: 57,
    height: 1.12,
    letterSpacing: -0.25,
  );

  /// Medium display text used for prominent visual emphasis.
  static const displayMedium = TextStyle(fontSize: 45, height: 1.16);

  /// Small display text used for secondary hero content.
  static const displaySmall = TextStyle(fontSize: 36, height: 1.22);

  /// Large headline text used for primary screen titles.
  static const headlineLarge = TextStyle(fontSize: 32, height: 1.25);

  /// Medium headline text used for section headers.
  static const headlineMedium = TextStyle(fontSize: 28, height: 1.29);

  /// Small headline text used for compact section titles.
  static const headlineSmall = TextStyle(fontSize: 24, height: 1.33);

  /// Large title text used for card titles and major list items.
  static const titleLarge = TextStyle(fontSize: 22, height: 1.27);

  /// Medium title text used for standard subsection titles.
  static const titleMedium = TextStyle(
    fontSize: 16,
    height: 1.50,
    letterSpacing: 0.15,
  );

  /// Small title text used for compact headings.
  static const titleSmall = TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Large body text used for primary reading content.
  static const bodyLarge = TextStyle(
    fontSize: 16,
    height: 1.50,
    letterSpacing: 0.5,
  );

  /// Medium body text used for standard paragraphs.
  static const bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.25,
  );

  /// Small body text used for supporting or helper content.
  static const bodySmall = TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  );

  /// Large label text used for primary controls such as buttons.
  static const labelLarge = TextStyle(
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
  );

  /// Medium label text used for secondary controls and chips.
  static const labelMedium = TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
  );

  /// Small label text used for compact UI elements.
  static const labelSmall = TextStyle(
    fontSize: 11,
    height: 1.45,
    letterSpacing: 0.5,
  );
}
