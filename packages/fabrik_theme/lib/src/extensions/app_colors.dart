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

  /// Color used to signal errors, validation failures, and destructive actions.
  ///
  /// Use this for error text, invalid input borders, and destructive buttons so
  /// failure states stay inside the design system.
  final Color error;

  /// Color used for text and icons displayed on [error] backgrounds.
  final Color onError;

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
    this.error = ColorTokens.error,
    this.onError = ColorTokens.onError,
  });

  /// Creates a light [AppColors] instance using [ColorTokens].
  ///
  /// This factory exists for fallback and demonstration purposes.
  /// Production applications are expected to supply their own
  /// color definitions.
  ///
  /// Pair it with [AppColors.darkDefaults] for the dark theme:
  ///
  /// ```dart
  /// MaterialApp(
  ///   theme: FabrikTheme.create(
  ///     brightness: Brightness.light,
  ///     colors: AppColors.defaults(),
  ///   ),
  ///   darkTheme: FabrikTheme.create(
  ///     brightness: Brightness.dark,
  ///     colors: AppColors.darkDefaults(),
  ///   ),
  /// );
  /// ```
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
      error: ColorTokens.error,
      onError: ColorTokens.onError,
    );
  }

  /// Creates a dark [AppColors] instance using the dark [ColorTokens].
  ///
  /// The dark counterpart to [AppColors.defaults]. Passing a light palette to
  /// `FabrikTheme.create(brightness: Brightness.dark, ...)` darkens Material's
  /// own `ColorScheme` but leaves the semantic colors light, so
  /// `context.colors.surface` would stay white in dark mode.
  factory AppColors.darkDefaults() {
    return const AppColors(
      primary: ColorTokens.primaryDark,
      onPrimary: ColorTokens.onPrimaryDark,
      accent: ColorTokens.accentDark,
      onAccent: ColorTokens.onAccentDark,
      surface: ColorTokens.surfaceDark,
      onSurface: ColorTokens.onSurfaceDark,
      textPrimary: ColorTokens.textPrimaryDark,
      textSecondary: ColorTokens.textSecondaryDark,
      textTertiary: ColorTokens.textTertiaryDark,
      error: ColorTokens.errorDark,
      onError: ColorTokens.onErrorDark,
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
    Color? error,
    Color? onError,
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
      error: error ?? this.error,
      onError: onError ?? this.onError,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      onAccent: Color.lerp(onAccent, other.onAccent, t) ?? onAccent,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      textPrimary:
          Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textTertiary:
          Color.lerp(textTertiary, other.textTertiary, t) ?? textTertiary,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppColors &&
        other.primary == primary &&
        other.onPrimary == onPrimary &&
        other.accent == accent &&
        other.onAccent == onAccent &&
        other.surface == surface &&
        other.onSurface == onSurface &&
        other.textPrimary == textPrimary &&
        other.textSecondary == textSecondary &&
        other.textTertiary == textTertiary &&
        other.error == error &&
        other.onError == onError;
  }

  @override
  int get hashCode => Object.hash(
    primary,
    onPrimary,
    accent,
    onAccent,
    surface,
    onSurface,
    textPrimary,
    textSecondary,
    textTertiary,
    error,
    onError,
  );
}
