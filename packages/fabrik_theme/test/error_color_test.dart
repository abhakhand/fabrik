import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _custom = AppColors(
  primary: Color(0xFF2E7D32),
  onPrimary: Color(0xFFFFFFFF),
  accent: Color(0xFF66BB6A),
  onAccent: Color(0xFFFFFFFF),
  surface: Color(0xFFF6F6F6),
  onSurface: Color(0xFF000000),
  textPrimary: Color(0xFF111111),
  textSecondary: Color(0xFF444444),
  textTertiary: Color(0xFF777777),
);

void main() {
  group('error role', () {
    test('defaults are applied when omitted', () {
      // The nine-argument constructor from before this release still compiles.
      expect(_custom.error, ColorTokens.error);
      expect(_custom.onError, ColorTokens.onError);
    });

    test('can be overridden explicitly', () {
      const colors = AppColors(
        primary: Color(0xFF000000),
        onPrimary: Color(0xFFFFFFFF),
        accent: Color(0xFF000000),
        onAccent: Color(0xFFFFFFFF),
        surface: Color(0xFFFFFFFF),
        onSurface: Color(0xFF000000),
        textPrimary: Color(0xFF000000),
        textSecondary: Color(0xFF444444),
        textTertiary: Color(0xFF777777),
        error: Color(0xFFFF0000),
        onError: Color(0xFF00FF00),
      );

      expect(colors.error, const Color(0xFFFF0000));
      expect(colors.onError, const Color(0xFF00FF00));
    });

    test('contrasts against its own on-color', () {
      for (final colors in [AppColors.defaults(), AppColors.darkDefaults()]) {
        final contrast =
            (colors.error.computeLuminance() -
                    colors.onError.computeLuminance())
                .abs();
        expect(contrast, greaterThan(0.3));
      }
    });

    test('differs between the light and dark palettes', () {
      expect(AppColors.defaults().error, isNot(AppColors.darkDefaults().error));
    });
  });

  group('error flows into ThemeData', () {
    test('the ColorScheme uses the semantic error color', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _custom.copyWith(error: const Color(0xFFDD0000)),
      );

      expect(theme.colorScheme.error, const Color(0xFFDD0000));
    });

    test('the ColorScheme uses the semantic onError color', () {
      final theme = FabrikTheme.create(
        brightness: Brightness.light,
        colors: _custom.copyWith(onError: const Color(0xFFEEEEEE)),
      );

      expect(theme.colorScheme.onError, const Color(0xFFEEEEEE));
    });

    testWidgets('context.colors.error is reachable in widgets', (tester) async {
      late Color seen;

      await tester.pumpWidget(
        MaterialApp(
          theme: FabrikTheme.create(
            brightness: Brightness.light,
            colors: _custom,
          ),
          home: Builder(
            builder: (context) {
              seen = context.colors.error;
              return Text('failed', style: TextStyle(color: context.colors.error));
            },
          ),
        ),
      );

      expect(seen, ColorTokens.error);
      expect(tester.takeException(), isNull);
    });
  });

  group('error participates in the value semantics', () {
    test('copyWith overrides only the named role', () {
      final result = _custom.copyWith(error: const Color(0xFF123456));

      expect(result.error, const Color(0xFF123456));
      expect(result.onError, _custom.onError);
      expect(result.primary, _custom.primary);
    });

    test('a differing error breaks equality', () {
      expect(_custom.copyWith(error: const Color(0xFF123456)), isNot(_custom));
      expect(
        _custom.copyWith(onError: const Color(0xFF123456)),
        isNot(_custom),
      );
    });

    test('lerp interpolates the error roles', () {
      final a = _custom.copyWith(
        error: const Color(0xFF000000),
        onError: const Color(0xFF000000),
      );
      final b = _custom.copyWith(
        error: const Color(0xFFFFFFFF),
        onError: const Color(0xFFFFFFFF),
      );

      expect(a.lerp(b, 1).error, b.error);
      expect(a.lerp(b, 1).onError, b.onError);
      expect(a.lerp(b, 0).error, a.error);
    });
  });
}
