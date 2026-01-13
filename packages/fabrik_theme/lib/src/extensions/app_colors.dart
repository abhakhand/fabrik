import 'package:fabrik_theme/src/tokens/color_tokens.dart';
import 'package:flutter/material.dart';

/// A semantic color contract for the application.
///
/// [AppColors] represents fully resolved colors that are consumed
/// directly by UI widgets via the active [ThemeData].
///
/// This class defines the minimum set of color roles required to
/// build a consistent and accessible UI. Applications are expected
/// to provide concrete instances of this class when constructing
/// their themes.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// Primary brand color used for key actions and emphasis.
  final Color primary;

  /// Supporting accent color used for secondary emphasis.
  final Color accent;

  /// Primary text color used for high-emphasis text.
  final Color textPrimary;

  /// Secondary text color used for supporting content.
  final Color textSecondary;

  /// Tertiary text color used for low-emphasis content.
  final Color textTertiary;

  /// Background color used for the main application surface.
  final Color background;

  /// Surface color used for cards and contained elements.
  final Color surface;

  /// Divider color used for separators and outlines.
  final Color divider;

  const AppColors({
    required this.primary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.background,
    required this.surface,
    required this.divider,
  });

  /// Creates a default [AppColors] instance using [ColorTokens].
  ///
  /// This factory exists for fallback and demonstration purposes.
  /// Production applications are expected to supply their own
  /// color definitions.
  factory AppColors.defaults() {
    return const AppColors(
      primary: ColorTokens.primary,
      accent: ColorTokens.accent,
      textPrimary: ColorTokens.textPrimary,
      textSecondary: ColorTokens.textSecondary,
      textTertiary: ColorTokens.textTertiary,
      background: ColorTokens.background,
      surface: ColorTokens.surface,
      divider: ColorTokens.divider,
    );
  }

  @override
  AppColors copyWith({
    Color? primary,
    Color? accent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? background,
    Color? surface,
    Color? divider,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      divider: divider ?? this.divider,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}
