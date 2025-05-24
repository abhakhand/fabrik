import 'package:fabrik_theme/src/tokens/tokens.dart';
import 'package:flutter/material.dart';

/// Defines the default text styles without any color or font family applied.
///
/// These styles serve as the base for all typography variants
/// and are later combined with color and fontFamily via `FabrikTypography`.
class FabrikTypographyDefaults {
  const FabrikTypographyDefaults._();

  // === Titles ===

  /// Extra-large title — typically used for section headers or hero titles.
  static TextStyle get titleXL =>
      const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, height: 1.25);

  /// Large title — used for screens and primary headers.
  static TextStyle get titleLarge =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);

  /// Regular title — standard card or block titles.
  static TextStyle get titleRegular =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);

  /// Small title — commonly used for subheadings or inline headings.
  static TextStyle get titleSmall =>
      const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.4);

  // === Body ===

  /// Large body text — typically used for comfortable reading.
  static TextStyle get bodyLarge =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  /// Regular body text — used for general purpose text.
  static TextStyle get bodyRegular =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  /// Small body text — for dense content or UI labels.
  static TextStyle get bodySmall =>
      const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  // === Caption & Mini ===

  /// Caption — used for hints, tooltips, or small UI annotations.
  static TextStyle get caption =>
      const TextStyle(fontSize: 11, fontWeight: FontWeight.w400, height: 0.8);

  /// Mini — smallest readable text, often for icons or extreme secondary labels.
  static TextStyle get mini =>
      const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, height: 0.75);
}

/// A color-aware, font-aware typography system that builds on top of [FabrikTypographyDefaults].
///
/// You can use this class to access color-specific and font-specific versions
/// of default text styles. Variants include primary, secondary, and tertiary
/// color support with weight overrides (medium, semi-bold, bold).
class FabrikTypography {
  const FabrikTypography({required this.colors, this.fontFamily});

  /// The color scheme applied to this typography instance.
  final FabrikColors colors;

  /// Optional font family override.
  final String? fontFamily;

  factory FabrikTypography.fromColors(
    FabrikColors colors, {
    String? fontFamily,
  }) {
    return FabrikTypography(colors: colors, fontFamily: fontFamily);
  }

  /// Internal helper to apply color, fontFamily, and weight.
  TextStyle _apply(TextStyle style, Color color, [FontWeight? weight]) =>
      style.copyWith(
        color: color,
        fontFamily: fontFamily,
        fontWeight: weight ?? style.fontWeight,
      );

  // === Titles (Primary) ===

  /// titleXL — fontSize: 28, fontWeight: w700, color: colors.textPrimary
  TextStyle get titleXL =>
      _apply(FabrikTypographyDefaults.titleXL, colors.textPrimary);

  /// titleLarge — fontSize: 22, fontWeight: w600, color: colors.textPrimary
  TextStyle get titleLarge =>
      _apply(FabrikTypographyDefaults.titleLarge, colors.textPrimary);

  /// titleRegular — fontSize: 18, fontWeight: w600, color: colors.textPrimary
  TextStyle get titleRegular =>
      _apply(FabrikTypographyDefaults.titleRegular, colors.textPrimary);

  /// titleSmall — fontSize: 17, fontWeight: w600, color: colors.textPrimary
  TextStyle get titleSmall =>
      _apply(FabrikTypographyDefaults.titleSmall, colors.textPrimary);

  /// titleXLBold — fontSize: 28, fontWeight: bold, color: colors.textPrimary
  TextStyle get titleXLBold => _apply(
    FabrikTypographyDefaults.titleXL,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// titleLargeBold — fontSize: 22, fontWeight: bold, color: colors.textPrimary
  TextStyle get titleLargeBold => _apply(
    FabrikTypographyDefaults.titleLarge,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// titleRegularBold — fontSize: 18, fontWeight: bold, color: colors.textPrimary
  TextStyle get titleRegularBold => _apply(
    FabrikTypographyDefaults.titleRegular,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// titleSmallBold — fontSize: 17, fontWeight: bold, color: colors.textPrimary
  TextStyle get titleSmallBold => _apply(
    FabrikTypographyDefaults.titleSmall,
    colors.textPrimary,
    FontWeight.bold,
  );

  // === Body - Primary ===

  /// bodyLarge — fontSize: 16, fontWeight: w400, color: colors.textPrimary
  TextStyle get bodyLarge =>
      _apply(FabrikTypographyDefaults.bodyLarge, colors.textPrimary);

  /// bodyRegular — fontSize: 14, fontWeight: w400, color: colors.textPrimary
  TextStyle get bodyRegular =>
      _apply(FabrikTypographyDefaults.bodyRegular, colors.textPrimary);

  /// bodySmall — fontSize: 12, fontWeight: w400, color: colors.textPrimary
  TextStyle get bodySmall =>
      _apply(FabrikTypographyDefaults.bodySmall, colors.textPrimary);

  /// bodyLargeMedium — fontSize: 16, fontWeight: w500, color: colors.textPrimary
  TextStyle get bodyLargeMedium => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textPrimary,
    FontWeight.w500,
  );

  /// bodyRegularMedium — fontSize: 14, fontWeight: w500, color: colors.textPrimary
  TextStyle get bodyRegularMedium => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textPrimary,
    FontWeight.w500,
  );

  /// bodySmallMedium — fontSize: 12, fontWeight: w500, color: colors.textPrimary
  TextStyle get bodySmallMedium => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textPrimary,
    FontWeight.w500,
  );

  /// bodyLargeSemiBold — fontSize: 16, fontWeight: w600, color: colors.textPrimary
  TextStyle get bodyLargeSemiBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textPrimary,
    FontWeight.w600,
  );

  /// bodyRegularSemiBold — fontSize: 14, fontWeight: w600, color: colors.textPrimary
  TextStyle get bodyRegularSemiBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textPrimary,
    FontWeight.w600,
  );

  /// bodySmallSemiBold — fontSize: 12, fontWeight: w600, color: colors.textPrimary
  TextStyle get bodySmallSemiBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textPrimary,
    FontWeight.w600,
  );

  /// bodyLargeBold — fontSize: 16, fontWeight: bold, color: colors.textPrimary
  TextStyle get bodyLargeBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// bodyRegularBold — fontSize: 14, fontWeight: bold, color: colors.textPrimary
  TextStyle get bodyRegularBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// bodySmallBold — fontSize: 12, fontWeight: bold, color: colors.textPrimary
  TextStyle get bodySmallBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textPrimary,
    FontWeight.bold,
  );

  // === Body - Secondary ===

  /// bodyLargeSecondary — fontSize: 16, fontWeight: w400, color: colors.textSecondary
  TextStyle get bodyLargeSecondary =>
      _apply(FabrikTypographyDefaults.bodyLarge, colors.textSecondary);

  /// bodyRegularSecondary — fontSize: 14, fontWeight: w400, color: colors.textSecondary
  TextStyle get bodyRegularSecondary =>
      _apply(FabrikTypographyDefaults.bodyRegular, colors.textSecondary);

  /// bodySmallSecondary — fontSize: 12, fontWeight: w400, color: colors.textSecondary
  TextStyle get bodySmallSecondary =>
      _apply(FabrikTypographyDefaults.bodySmall, colors.textSecondary);

  /// bodyLargeSecondaryMedium — fontSize: 16, fontWeight: w500, color: colors.textSecondary
  TextStyle get bodyLargeSecondaryMedium => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textSecondary,
    FontWeight.w500,
  );

  /// bodyRegularSecondaryMedium — fontSize: 14, fontWeight: w500, color: colors.textSecondary
  TextStyle get bodyRegularSecondaryMedium => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textSecondary,
    FontWeight.w500,
  );

  /// bodySmallSecondaryMedium — fontSize: 12, fontWeight: w500, color: colors.textSecondary
  TextStyle get bodySmallSecondaryMedium => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textSecondary,
    FontWeight.w500,
  );

  /// bodyLargeSecondarySemiBold — fontSize: 16, fontWeight: w600, color: colors.textSecondary
  TextStyle get bodyLargeSecondarySemiBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textSecondary,
    FontWeight.w600,
  );

  /// bodyRegularSecondarySemiBold — fontSize: 14, fontWeight: w600, color: colors.textSecondary
  TextStyle get bodyRegularSecondarySemiBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textSecondary,
    FontWeight.w600,
  );

  /// bodySmallSecondarySemiBold — fontSize: 12, fontWeight: w600, color: colors.textSecondary
  TextStyle get bodySmallSecondarySemiBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textSecondary,
    FontWeight.w600,
  );

  /// bodyLargeSecondaryBold — fontSize: 16, fontWeight: bold, color: colors.textSecondary
  TextStyle get bodyLargeSecondaryBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textSecondary,
    FontWeight.bold,
  );

  /// bodyRegularSecondaryBold — fontSize: 14, fontWeight: bold, color: colors.textSecondary
  TextStyle get bodyRegularSecondaryBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textSecondary,
    FontWeight.bold,
  );

  /// bodySmallSecondaryBold — fontSize: 12, fontWeight: bold, color: colors.textSecondary
  TextStyle get bodySmallSecondaryBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textSecondary,
    FontWeight.bold,
  );

  // === Body - Tertiary ===

  /// bodyLargeTertiary — fontSize: 16, fontWeight: w400, color: colors.textTertiary
  TextStyle get bodyLargeTertiary =>
      _apply(FabrikTypographyDefaults.bodyLarge, colors.textTertiary);

  /// bodyRegularTertiary — fontSize: 14, fontWeight: w400, color: colors.textTertiary
  TextStyle get bodyRegularTertiary =>
      _apply(FabrikTypographyDefaults.bodyRegular, colors.textTertiary);

  /// bodySmallTertiary — fontSize: 12, fontWeight: w400, color: colors.textTertiary
  TextStyle get bodySmallTertiary =>
      _apply(FabrikTypographyDefaults.bodySmall, colors.textTertiary);

  /// bodyLargeTertiaryMedium — fontSize: 16, fontWeight: w500, color: colors.textTertiary
  TextStyle get bodyLargeTertiaryMedium => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textTertiary,
    FontWeight.w500,
  );

  /// bodyRegularTertiaryMedium — fontSize: 14, fontWeight: w500, color: colors.textTertiary
  TextStyle get bodyRegularTertiaryMedium => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textTertiary,
    FontWeight.w500,
  );

  /// bodySmallTertiaryMedium — fontSize: 12, fontWeight: w500, color: colors.textTertiary
  TextStyle get bodySmallTertiaryMedium => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textTertiary,
    FontWeight.w500,
  );

  /// bodyLargeTertiarySemiBold — fontSize: 16, fontWeight: w600, color: colors.textTertiary
  TextStyle get bodyLargeTertiarySemiBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textTertiary,
    FontWeight.w600,
  );

  /// bodyRegularTertiarySemiBold — fontSize: 14, fontWeight: w600, color: colors.textTertiary
  TextStyle get bodyRegularTertiarySemiBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textTertiary,
    FontWeight.w600,
  );

  /// bodySmallTertiarySemiBold — fontSize: 12, fontWeight: w600, color: colors.textTertiary
  TextStyle get bodySmallTertiarySemiBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textTertiary,
    FontWeight.w600,
  );

  /// bodyLargeTertiaryBold — fontSize: 16, fontWeight: bold, color: colors.textTertiary
  TextStyle get bodyLargeTertiaryBold => _apply(
    FabrikTypographyDefaults.bodyLarge,
    colors.textTertiary,
    FontWeight.bold,
  );

  /// bodyRegularTertiaryBold — fontSize: 14, fontWeight: bold, color: colors.textTertiary
  TextStyle get bodyRegularTertiaryBold => _apply(
    FabrikTypographyDefaults.bodyRegular,
    colors.textTertiary,
    FontWeight.bold,
  );

  /// bodySmallTertiaryBold — fontSize: 12, fontWeight: bold, color: colors.textTertiary
  TextStyle get bodySmallTertiaryBold => _apply(
    FabrikTypographyDefaults.bodySmall,
    colors.textTertiary,
    FontWeight.bold,
  );

  // === Caption & Mini - Primary ===

  /// caption — fontSize: 11, fontWeight: w400, color: colors.textPrimary
  TextStyle get caption =>
      _apply(FabrikTypographyDefaults.caption, colors.textPrimary);

  /// mini — fontSize: 10, fontWeight: w400, color: colors.textPrimary
  TextStyle get mini =>
      _apply(FabrikTypographyDefaults.mini, colors.textPrimary);

  /// captionMedium — fontSize: 11, fontWeight: w500, color: colors.textPrimary
  TextStyle get captionMedium => _apply(
    FabrikTypographyDefaults.caption,
    colors.textPrimary,
    FontWeight.w500,
  );

  /// miniMedium — fontSize: 11, fontWeight: w500, color: colors.textPrimary
  TextStyle get miniMedium => _apply(
    FabrikTypographyDefaults.caption,
    colors.textPrimary,
    FontWeight.w500,
  );

  /// captionSemiBold — fontSize: 11, fontWeight: w600, color: colors.textPrimary
  TextStyle get captionSemiBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textPrimary,
    FontWeight.w600,
  );

  /// miniSemiBold — fontSize: 11, fontWeight: w600, color: colors.textPrimary
  TextStyle get miniSemiBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textPrimary,
    FontWeight.w600,
  );

  /// captionBold — fontSize: 11, fontWeight: bold, color: colors.textPrimary
  TextStyle get captionBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textPrimary,
    FontWeight.bold,
  );

  /// miniBold — fontSize: 10, fontWeight: bold, color: colors.textPrimary
  TextStyle get miniBold => _apply(
    FabrikTypographyDefaults.mini,
    colors.textPrimary,
    FontWeight.bold,
  );

  // === Caption & Mini - Secondary ===

  /// captionSecondary — fontSize: 11, fontWeight: w400, color: colors.textSecondary
  TextStyle get captionSecondary =>
      _apply(FabrikTypographyDefaults.caption, colors.textSecondary);

  /// miniSecondary — fontSize: 10, fontWeight: w400, color: colors.textSecondary
  TextStyle get miniSecondary =>
      _apply(FabrikTypographyDefaults.mini, colors.textSecondary);

  /// captionSecondaryMedium — fontSize: 11, fontWeight: w500, color: colors.textSecondary
  TextStyle get captionSecondaryMedium => _apply(
    FabrikTypographyDefaults.caption,
    colors.textSecondary,
    FontWeight.w500,
  );

  /// miniSecondaryMedium — fontSize: 11, fontWeight: w500, color: colors.textSecondary
  TextStyle get miniSecondaryMedium => _apply(
    FabrikTypographyDefaults.caption,
    colors.textSecondary,
    FontWeight.w500,
  );

  /// captionSecondarySemiBold — fontSize: 11, fontWeight: w600, color: colors.textSecondary
  TextStyle get captionSecondarySemiBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textSecondary,
    FontWeight.w600,
  );

  /// miniSecondarySemiBold — fontSize: 11, fontWeight: w600, color: colors.textSecondary
  TextStyle get miniSecondarySemiBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textSecondary,
    FontWeight.w600,
  );

  /// captionSecondaryBold — fontSize: 11, fontWeight: bold, color: colors.textSecondary
  TextStyle get captionSecondaryBold => _apply(
    FabrikTypographyDefaults.caption,
    colors.textSecondary,
    FontWeight.bold,
  );

  /// miniSecondaryBold — fontSize: 10, fontWeight: bold, color: colors.textSecondary
  TextStyle get miniSecondaryBold => _apply(
    FabrikTypographyDefaults.mini,
    colors.textSecondary,
    FontWeight.bold,
  );
}
