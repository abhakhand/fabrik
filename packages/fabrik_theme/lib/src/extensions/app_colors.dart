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

  /// Color used for text and icons displayed on primary backgrounds.
  final Color onPrimary;

  /// Supporting accent color used for secondary emphasis.
  final Color accent;

  /// Color used for text and icons displayed on accent backgrounds.
  final Color onAccent;

  /// Primary text color used for high-emphasis text.
  final Color textPrimary;

  /// Secondary text color used for supporting content.
  final Color textSecondary;

  /// Tertiary text color used for low-emphasis content.
  final Color textTertiary;

  /// Background color used for the main application background.
  final Color surface;

  /// Color used for text and icons displayed on surface backgrounds.
  final Color onSurface;

  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.accent,
    required this.onAccent,
    required this.surface,
    required this.onSurface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
  });

  /// Creates a default [AppColors] instance using [ColorTokens].
  ///
  /// This factory exists for fallback and demonstration purposes.
  /// Production applications are expected to supply their own
  /// color definitions.
  factory AppColors.defaults() {
    return const AppColors(
      primary: ColorTokens.primary,
      onPrimary: ColorTokens.onPrimary,
      accent: ColorTokens.accent,
      onAccent: ColorTokens.onAccent,
      surface: ColorTokens.surface,
      onSurface: ColorTokens.onSurface,
      textPrimary: ColorTokens.textPrimary,
      textSecondary: ColorTokens.textSecondary,
      textTertiary: ColorTokens.textTertiary,
    );
  }

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? accent,
    Color? onAccent,
    Color? surface,
    Color? onSurface,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
    );
  }
}
