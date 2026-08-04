import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _colors = AppColors(
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  accent: Color(0xFF625B71),
  onAccent: Color(0xFFEEEEEE),
  surface: Color(0xFFFDFDFD),
  onSurface: Color(0xFF010101),
  textPrimary: Color(0xFF111111),
  textSecondary: Color(0xFF222222),
  textTertiary: Color(0xFF333333),
);

void main() {
  group('FabrikTheme.create', () {
    test('registers AppColors and AppTypography as theme extensions', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      );

      expect(theme.extension<AppColors>(), _colors);
      expect(theme.extension<AppTypography>(), isNotNull);
    });

    test('honours the requested brightness', () {
      expect(
        FabrikTheme.create(brightness: Brightness.light, colors: _colors)
            .brightness,
        Brightness.light,
      );
      expect(
        FabrikTheme.create(brightness: Brightness.dark, colors: _colors)
            .brightness,
        Brightness.dark,
      );
    });

    test('opts into Material 3', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      );

      expect(theme.useMaterial3, isTrue);
    });

    test('maps semantic colors onto the ColorScheme', () {
      final scheme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      ).colorScheme;

      expect(scheme.primary, _colors.primary);
      expect(scheme.onPrimary, _colors.onPrimary);
      expect(scheme.secondary, _colors.accent);
      expect(scheme.onSecondary, _colors.onAccent);
      expect(scheme.surface, _colors.surface);
      expect(scheme.onSurface, _colors.onSurface);
    });

    test('derives typography from colors when none is supplied', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      );

      expect(
        theme.extension<AppTypography>(),
        FabrikTypographyBuilder.build(_colors),
      );
    });

    test('uses the supplied typography verbatim', () {
      final custom = AppTypography.defaults(
        textPrimary: const Color(0xFFABCDEF),
      );
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
        typography: custom,
      );

      expect(theme.extension<AppTypography>(), custom);
    });

    test('ignores fontFamily for typography when typography is supplied', () {
      final custom = AppTypography.defaults();
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
        typography: custom,
        fontFamily: 'Inter',
      );

      // The extension is passed through untouched — the family is not baked
      // into the semantic styles the way an internally built one would be.
      expect(theme.extension<AppTypography>(), custom);
      expect(theme.extension<AppTypography>()!.bodyLarge.fontFamily, isNull);
    });

    test('applies fontFamily when typography is built internally', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
        fontFamily: 'Inter',
      );

      expect(theme.extension<AppTypography>()!.bodyLarge.fontFamily, 'Inter');
    });

    test('populates the Material TextTheme from resolved typography', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      );
      final typography = theme.extension<AppTypography>()!;

      // ThemeData merges its own platform defaults (font family, decoration)
      // into textTheme, so assert the properties Fabrik actually controls
      // rather than exact TextStyle equality.
      final pairs = <String, (TextStyle?, TextStyle)>{
        'displayLarge': (theme.textTheme.displayLarge, typography.displayLarge),
        'displayMedium': (
          theme.textTheme.displayMedium,
          typography.displayMedium,
        ),
        'displaySmall': (theme.textTheme.displaySmall, typography.displaySmall),
        'headlineLarge': (
          theme.textTheme.headlineLarge,
          typography.headlineLarge,
        ),
        'headlineMedium': (
          theme.textTheme.headlineMedium,
          typography.headlineMedium,
        ),
        'headlineSmall': (
          theme.textTheme.headlineSmall,
          typography.headlineSmall,
        ),
        'titleLarge': (theme.textTheme.titleLarge, typography.titleLarge),
        'titleMedium': (theme.textTheme.titleMedium, typography.titleMedium),
        'titleSmall': (theme.textTheme.titleSmall, typography.titleSmall),
        'bodyLarge': (theme.textTheme.bodyLarge, typography.bodyLarge),
        'bodyMedium': (theme.textTheme.bodyMedium, typography.bodyMedium),
        'bodySmall': (theme.textTheme.bodySmall, typography.bodySmall),
        'labelLarge': (theme.textTheme.labelLarge, typography.labelLarge),
        'labelMedium': (theme.textTheme.labelMedium, typography.labelMedium),
        'labelSmall': (theme.textTheme.labelSmall, typography.labelSmall),
      };

      pairs.forEach((name, pair) {
        final (actual, expected) = pair;
        expect(actual, isNotNull, reason: '$name must be set on textTheme');
        expect(actual!.color, expected.color, reason: '$name color');
        expect(actual.fontSize, expected.fontSize, reason: '$name fontSize');
        expect(actual.height, expected.height, reason: '$name height');
        expect(
          actual.letterSpacing,
          expected.letterSpacing,
          reason: '$name letterSpacing',
        );
      });
    });

    test('produces distinct themes for light and dark brightness', () {
      final light = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _colors,
      );
      final dark = FabrikTheme.create(
        brightness: Brightness.dark,
        colors: _colors,
      );

      expect(light.brightness, isNot(dark.brightness));
    });
  });

  group('FabrikTheme theme extension lifecycle', () {
    testWidgets('extensions survive being mounted in a MaterialApp', (
      tester,
    ) async {
      late AppColors seen;

      await tester.pumpWidget(
        MaterialApp(
          theme: FabrikTheme.create(
            brightness: Brightness.light,
            colors: _colors,
          ),
          home: Builder(
            builder: (context) {
              seen = context.colors;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(seen, _colors);
    });

    testWidgets('extensions animate between light and dark themes', (
      tester,
    ) async {
      const darkColors = AppColors(
        primary: Color(0xFFFFFFFF),
        onPrimary: Color(0xFF000000),
        accent: Color(0xFFCCCCCC),
        onAccent: Color(0xFF000000),
        surface: Color(0xFF000000),
        onSurface: Color(0xFFFFFFFF),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFDDDDDD),
        textTertiary: Color(0xFFBBBBBB),
      );

      Widget app(ThemeData theme) => MaterialApp(
        theme: theme,
        home: Builder(
          builder: (context) => ColoredBox(color: context.colors.primary),
        ),
      );

      await tester.pumpWidget(
        app(FabrikTheme.create(brightness: Brightness.light, colors: _colors)),
      );
      await tester.pumpWidget(
        app(
          FabrikTheme.create(brightness: Brightness.dark, colors: darkColors),
        ),
      );
      // Mid-transition: Theme lerps extensions, so this must not throw.
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.takeException(), isNull);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });
}
