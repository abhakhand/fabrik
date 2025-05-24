import 'package:flutter/material.dart';

class FabrikColorDefaults {
  // Light defaults
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightOnPrimary = Colors.white;
  static const Color lightSecondary = Colors.amber;
  static const Color lightOnSecondary = Colors.black;
  static const Color lightSurface = Colors.white;
  static const Color lightOnSurface = Colors.black;
  static const Color lightError = Colors.red;
  static const Color lightOnError = Colors.white;
  static const Color lightTextPrimary = Colors.black87;
  static const Color lightTextSecondary = Colors.black54;
  static const Color lightTextTertiary = Color(0x99000000);

  // Dark defaults
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkOnPrimary = Colors.black;
  static const Color darkSecondary = Colors.greenAccent;
  static const Color darkOnSecondary = Colors.black;
  static const Color darkSurface = Colors.black;
  static const Color darkOnSurface = Colors.white;
  static const Color darkError = Colors.redAccent;
  static const Color darkOnError = Colors.black;
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Colors.white70;
  static const Color darkTextTertiary = Color(0x99FFFFFF);
}

abstract class FabrikBaseColors {
  Color get primary;
  Color get onPrimary;
  Color get secondary;
  Color get onSecondary;
  Color get surface;
  Color get onSurface;
  Color get error;
  Color get onError;
  Color get textPrimary;
  Color get textSecondary;
  Color get textTertiary;
}

class FabrikColorsLight implements FabrikBaseColors {
  @override
  final Color primary;
  @override
  final Color onPrimary;
  @override
  final Color secondary;
  @override
  final Color onSecondary;
  @override
  final Color surface;
  @override
  final Color onSurface;
  @override
  final Color error;
  @override
  final Color onError;
  @override
  final Color textPrimary;
  @override
  final Color textSecondary;
  @override
  final Color textTertiary;

  const FabrikColorsLight({
    this.primary = FabrikColorDefaults.lightPrimary,
    this.onPrimary = FabrikColorDefaults.lightOnPrimary,
    this.secondary = FabrikColorDefaults.lightSecondary,
    this.onSecondary = FabrikColorDefaults.lightOnSecondary,
    this.surface = FabrikColorDefaults.lightSurface,
    this.onSurface = FabrikColorDefaults.lightOnSurface,
    this.error = FabrikColorDefaults.lightError,
    this.onError = FabrikColorDefaults.lightOnError,
    this.textPrimary = FabrikColorDefaults.lightTextPrimary,
    this.textSecondary = FabrikColorDefaults.lightTextSecondary,
    this.textTertiary = FabrikColorDefaults.lightTextTertiary,
  });
}

class FabrikColorsDark implements FabrikBaseColors {
  @override
  final Color primary;
  @override
  final Color onPrimary;
  @override
  final Color secondary;
  @override
  final Color onSecondary;
  @override
  final Color surface;
  @override
  final Color onSurface;
  @override
  final Color error;
  @override
  final Color onError;
  @override
  final Color textPrimary;
  @override
  final Color textSecondary;
  @override
  final Color textTertiary;

  const FabrikColorsDark({
    this.primary = FabrikColorDefaults.darkPrimary,
    this.onPrimary = FabrikColorDefaults.darkOnPrimary,
    this.secondary = FabrikColorDefaults.darkSecondary,
    this.onSecondary = FabrikColorDefaults.darkOnSecondary,
    this.surface = FabrikColorDefaults.darkSurface,
    this.onSurface = FabrikColorDefaults.darkOnSurface,
    this.error = FabrikColorDefaults.darkError,
    this.onError = FabrikColorDefaults.darkOnError,
    this.textPrimary = FabrikColorDefaults.darkTextPrimary,
    this.textSecondary = FabrikColorDefaults.darkTextSecondary,
    this.textTertiary = FabrikColorDefaults.darkTextTertiary,
  });
}

class FabrikColors {
  final FabrikColorsLight light;
  final FabrikColorsDark dark;

  Brightness _brightness = Brightness.light;

  FabrikColors._({required this.light, required this.dark});

  factory FabrikColors.defaultScheme() => FabrikColors._(
    light: const FabrikColorsLight(),
    dark: const FabrikColorsDark(),
  );

  factory FabrikColors.custom({
    required Color lightPrimary,
    required Color darkPrimary,
    Color? lightOnPrimary,
    Color? darkOnPrimary,
    Color? lightSecondary,
    Color? darkSecondary,
    Color? lightOnSecondary,
    Color? darkOnSecondary,
    Color? lightSurface,
    Color? darkSurface,
    Color? lightOnSurface,
    Color? darkOnSurface,
    Color? lightError,
    Color? darkError,
    Color? lightOnError,
    Color? darkOnError,
    Color? lightTextPrimary,
    Color? darkTextPrimary,
    Color? lightTextSecondary,
    Color? darkTextSecondary,
    Color? lightTextTertiary,
    Color? darkTextTertiary,
  }) {
    return FabrikColors._(
      light: FabrikColorsLight(
        primary: lightPrimary,
        onPrimary: lightOnPrimary ?? FabrikColorDefaults.lightOnPrimary,
        secondary: lightSecondary ?? FabrikColorDefaults.lightSecondary,
        onSecondary: lightOnSecondary ?? FabrikColorDefaults.lightOnSecondary,
        surface: lightSurface ?? FabrikColorDefaults.lightSurface,
        onSurface: lightOnSurface ?? FabrikColorDefaults.lightOnSurface,
        error: lightError ?? FabrikColorDefaults.lightError,
        onError: lightOnError ?? FabrikColorDefaults.lightOnError,
        textPrimary: lightTextPrimary ?? FabrikColorDefaults.lightTextPrimary,
        textSecondary:
            lightTextSecondary ?? FabrikColorDefaults.lightTextSecondary,
        textTertiary:
            lightTextTertiary ?? FabrikColorDefaults.lightTextTertiary,
      ),
      dark: FabrikColorsDark(
        primary: darkPrimary,
        onPrimary: darkOnPrimary ?? FabrikColorDefaults.darkOnPrimary,
        secondary: darkSecondary ?? FabrikColorDefaults.darkSecondary,
        onSecondary: darkOnSecondary ?? FabrikColorDefaults.darkOnSecondary,
        surface: darkSurface ?? FabrikColorDefaults.darkSurface,
        onSurface: darkOnSurface ?? FabrikColorDefaults.darkOnSurface,
        error: darkError ?? FabrikColorDefaults.darkError,
        onError: darkOnError ?? FabrikColorDefaults.darkOnError,
        textPrimary: darkTextPrimary ?? FabrikColorDefaults.darkTextPrimary,
        textSecondary:
            darkTextSecondary ?? FabrikColorDefaults.darkTextSecondary,
        textTertiary: darkTextTertiary ?? FabrikColorDefaults.darkTextTertiary,
      ),
    );
  }

  void resolveWith(Brightness brightness) {
    _brightness = brightness;
  }

  FabrikBaseColors get active => _brightness == Brightness.light ? light : dark;

  Color get primary => active.primary;
  Color get onPrimary => active.onPrimary;
  Color get secondary => active.secondary;
  Color get onSecondary => active.onSecondary;
  Color get surface => active.surface;
  Color get onSurface => active.onSurface;
  Color get error => active.error;
  Color get onError => active.onError;
  Color get textPrimary => active.textPrimary;
  Color get textSecondary => active.textSecondary;
  Color get textTertiary => active.textTertiary;
}
