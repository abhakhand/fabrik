import 'package:fabrik_theme/src/theme/theme.dart';
import 'package:fabrik_theme/src/tokens/tokens.dart';
import 'package:fabrik_theme/src/typography/typography.dart';
import 'package:flutter/material.dart';

/// A builder for creating a complete [ThemeData] based on Fabrik design system.
///
/// This utility centralizes the theme construction using [FabrikColors] and [FabrikTypography],
/// while also wiring them into Flutter's [ColorScheme], [TextTheme], and [ThemeData.extensions].
class FabrikThemeBuilder {
  /// Converts [FabrikColors] into Flutter’s native [ColorScheme].
  static ColorScheme _toColorScheme(
    FabrikColors colors,
    Brightness brightness,
  ) {
    return ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.onSurface,
    );
  }

  /// Converts [FabrikTypography] into Flutter’s native [TextTheme].
  ///
  /// This maps Fabrik text styles to their corresponding Flutter roles,
  /// enabling compatibility with built-in Material components.
  static TextTheme _toTextTheme(FabrikTypography typography) {
    return TextTheme(
      displayLarge: typography.titleXL,
      displayMedium: typography.titleLarge,
      displaySmall: typography.titleRegular,
      headlineLarge: typography.titleSmall,
      headlineMedium: typography.bodyLarge,
      headlineSmall: typography.bodyRegular,
      titleLarge: typography.titleLarge,
      titleMedium: typography.titleRegular,
      titleSmall: typography.titleSmall,
      bodyLarge: typography.bodyLarge,
      bodyMedium: typography.bodyRegular,
      bodySmall: typography.bodySmall,
      labelLarge: typography.bodyRegular,
      labelMedium: typography.bodySmall,
      labelSmall: typography.caption,
    );
  }

  /// Builds a complete [ThemeData] object for the app.
  ///
  /// - [brightness] is used to resolve light/dark values inside [FabrikColors].
  /// - [colors] (optional) lets you override the color scheme (default is [FabrikColors.defaultScheme()]).
  /// - [fontFamily] (optional) lets you inject a custom font family.
  static ThemeData build({
    required Brightness brightness,
    FabrikColors? colors,
    String? fontFamily,
  }) {
    // Resolve provided or default color scheme
    final resolvedColors = colors ?? FabrikColors.defaultScheme();
    resolvedColors.resolveWith(brightness);

    // Create typography using resolved colors and font
    final fabrikTypography = FabrikTypography.fromColors(
      resolvedColors,
      fontFamily: fontFamily,
    );

    // Build base Material 3 ThemeData and extend it with FabrikTheme
    return ThemeData.from(
      colorScheme: _toColorScheme(resolvedColors, brightness),
      textTheme: _toTextTheme(fabrikTypography),
      useMaterial3: true,
    ).copyWith(
      extensions: [
        FabrikTheme(colors: resolvedColors, typography: fabrikTypography),
      ],
    );
  }

  /// Builds a light theme using the provided or default Fabrik color scheme and optional font family.
  static ThemeData light({FabrikColors? colors, String? fontFamily}) {
    return build(
      brightness: Brightness.light,
      colors: colors,
      fontFamily: fontFamily,
    );
  }

  /// Builds a dark theme using the provided or default Fabrik color scheme and optional font family.
  static ThemeData dark({FabrikColors? colors, String? fontFamily}) {
    return build(
      brightness: Brightness.dark,
      colors: colors,
      fontFamily: fontFamily,
    );
  }
}
