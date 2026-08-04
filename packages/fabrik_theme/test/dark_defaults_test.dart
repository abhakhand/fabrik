import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppColors.darkDefaults', () {
    test('maps every role from the dark tokens', () {
      final colors = AppColors.darkDefaults();

      expect(colors.primary, ColorTokens.primaryDark);
      expect(colors.onPrimary, ColorTokens.onPrimaryDark);
      expect(colors.accent, ColorTokens.accentDark);
      expect(colors.onAccent, ColorTokens.onAccentDark);
      expect(colors.surface, ColorTokens.surfaceDark);
      expect(colors.onSurface, ColorTokens.onSurfaceDark);
      expect(colors.textPrimary, ColorTokens.textPrimaryDark);
      expect(colors.textSecondary, ColorTokens.textSecondaryDark);
      expect(colors.textTertiary, ColorTokens.textTertiaryDark);
      expect(colors.error, ColorTokens.errorDark);
      expect(colors.onError, ColorTokens.onErrorDark);
    });

    test('is genuinely dark: light text on a dark surface', () {
      final colors = AppColors.darkDefaults();

      expect(colors.surface.computeLuminance(), lessThan(0.2));
      expect(colors.textPrimary.computeLuminance(), greaterThan(0.5));
    });

    test('inverts the light palette rather than repeating it', () {
      final light = AppColors.defaults();
      final dark = AppColors.darkDefaults();

      expect(
        light.surface.computeLuminance(),
        greaterThan(dark.surface.computeLuminance()),
      );
      expect(
        light.textPrimary.computeLuminance(),
        lessThan(dark.textPrimary.computeLuminance()),
      );
      expect(dark, isNot(light));
    });

    test('keeps readable contrast in both palettes', () {
      for (final colors in [AppColors.defaults(), AppColors.darkDefaults()]) {
        final contrast =
            (colors.textPrimary.computeLuminance() -
                    colors.surface.computeLuminance())
                .abs();
        expect(contrast, greaterThan(0.5));
      }
    });

    test('text emphasis descends away from the surface', () {
      final dark = AppColors.darkDefaults();

      // On a dark surface, lower emphasis means darker text.
      expect(
        dark.textPrimary.computeLuminance(),
        greaterThan(dark.textSecondary.computeLuminance()),
      );
      expect(
        dark.textSecondary.computeLuminance(),
        greaterThan(dark.textTertiary.computeLuminance()),
      );
    });

    test('every dark token is fully opaque', () {
      final colors = AppColors.darkDefaults();

      for (final color in [
        colors.primary,
        colors.onPrimary,
        colors.accent,
        colors.onAccent,
        colors.surface,
        colors.onSurface,
        colors.textPrimary,
        colors.textSecondary,
        colors.textTertiary,
        colors.error,
        colors.onError,
      ]) {
        expect(color.a, 1.0);
      }
    });
  });

  group('dark theme end to end', () {
    // Regression guard: passing a light palette with Brightness.dark darkened
    // Material's ColorScheme but left context.colors light, so a dark-mode app
    // rendered black text on a white surface with no warning.
    testWidgets('context.colors is dark when the dark theme is active', (
      tester,
    ) async {
      late AppColors seen;

      await tester.pumpWidget(
        MaterialApp(
          theme: FabrikTheme.create(
            brightness: Brightness.light,
            colors: AppColors.defaults(),
          ),
          darkTheme: FabrikTheme.create(
            brightness: Brightness.dark,
            colors: AppColors.darkDefaults(),
          ),
          themeMode: ThemeMode.dark,
          home: Builder(
            builder: (context) {
              seen = context.colors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(seen, AppColors.darkDefaults());
      expect(seen.surface.computeLuminance(), lessThan(0.2));
    });

    testWidgets('switching theme mode swaps the semantic colors', (
      tester,
    ) async {
      late AppColors seen;

      Widget app(ThemeMode mode) => MaterialApp(
        theme: FabrikTheme.create(
          brightness: Brightness.light,
          colors: AppColors.defaults(),
        ),
        darkTheme: FabrikTheme.create(
          brightness: Brightness.dark,
          colors: AppColors.darkDefaults(),
        ),
        themeMode: mode,
        home: Builder(
          builder: (context) {
            seen = context.colors;
            return const SizedBox.shrink();
          },
        ),
      );

      await tester.pumpWidget(app(ThemeMode.light));
      await tester.pumpAndSettle();
      expect(seen, AppColors.defaults());

      await tester.pumpWidget(app(ThemeMode.dark));
      await tester.pumpAndSettle();
      expect(seen, AppColors.darkDefaults());
      expect(tester.takeException(), isNull);
    });

    test('the dark theme reports dark brightness', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.dark,
        colors: AppColors.darkDefaults(),
      );

      expect(theme.brightness, Brightness.dark);
      expect(theme.colorScheme.brightness, Brightness.dark);
    });
  });
}
