import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTypography.defaults', () {
    test('applies textPrimary to base display/headline/title/body styles', () {
      const textPrimary = Color(0xFF111111);
      final t = AppTypography.defaults(textPrimary: textPrimary);

      expect(t.displayLarge.color, textPrimary);
      expect(t.displayMedium.color, textPrimary);
      expect(t.displaySmall.color, textPrimary);
      expect(t.headlineLarge.color, textPrimary);
      expect(t.headlineMedium.color, textPrimary);
      expect(t.headlineSmall.color, textPrimary);
      expect(t.titleLarge.color, textPrimary);
      expect(t.titleMedium.color, textPrimary);
      expect(t.titleSmall.color, textPrimary);
      expect(t.bodyLarge.color, textPrimary);
      expect(t.bodyMedium.color, textPrimary);
      expect(t.bodySmall.color, textPrimary);
    });

    // Regression guard for the 1.0.2 fix: the *Primary accent variants used to
    // receive textPrimary, making them indistinguishable from the base styles.
    test('applies the brand color to *Primary accent variants', () {
      const textPrimary = Color(0xFF111111);
      const primary = Color(0xFF6750A4);
      final t = AppTypography.defaults(
        textPrimary: textPrimary,
        primary: primary,
      );

      expect(t.displayLargePrimary.color, primary);
      expect(t.displayMediumPrimary.color, primary);
      expect(t.displaySmallPrimary.color, primary);
      expect(t.headlineLargePrimary.color, primary);
      expect(t.headlineMediumPrimary.color, primary);
      expect(t.headlineSmallPrimary.color, primary);
      expect(t.titleLargePrimary.color, primary);
      expect(t.titleMediumPrimary.color, primary);
      expect(t.titleSmallPrimary.color, primary);
    });

    test('accent variants are visually distinct from their base styles', () {
      final t = AppTypography.defaults(
        textPrimary: const Color(0xFF111111),
        primary: const Color(0xFF6750A4),
      );

      expect(t.displayLargePrimary.color, isNot(t.displayLarge.color));
      expect(t.headlineLargePrimary.color, isNot(t.headlineLarge.color));
      expect(t.titleLargePrimary.color, isNot(t.titleLarge.color));
    });

    test('applies textSecondary to secondary body and label variants', () {
      const textSecondary = Color(0xFF222222);
      final t = AppTypography.defaults(textSecondary: textSecondary);

      expect(t.bodyLargeSecondary.color, textSecondary);
      expect(t.bodyMediumSecondary.color, textSecondary);
      expect(t.bodySmallSecondary.color, textSecondary);
      expect(t.labelLargeSecondary.color, textSecondary);
      expect(t.labelMediumSecondary.color, textSecondary);
      expect(t.labelSmallSecondary.color, textSecondary);
    });

    test('applies textTertiary to tertiary body variants', () {
      const textTertiary = Color(0xFF333333);
      final t = AppTypography.defaults(textTertiary: textTertiary);

      expect(t.bodyLargeTertiary.color, textTertiary);
      expect(t.bodyMediumTertiary.color, textTertiary);
      expect(t.bodySmallTertiary.color, textTertiary);
    });

    test('emphasis variants use textPrimary at weight w500', () {
      const textPrimary = Color(0xFF111111);
      final t = AppTypography.defaults(textPrimary: textPrimary);

      for (final style in [
        t.bodyLargeEmphasis,
        t.bodyMediumEmphasis,
        t.bodySmallEmphasis,
      ]) {
        expect(style.color, textPrimary);
        expect(style.fontWeight, FontWeight.w500);
      }
    });

    test('base body styles are not bolded', () {
      final t = AppTypography.defaults();
      expect(t.bodyLarge.fontWeight, isNot(FontWeight.w500));
    });

    test('preserves token metrics while applying color', () {
      final t = AppTypography.defaults();

      expect(t.displayLarge.fontSize, TypographyTokens.displayLarge.fontSize);
      expect(t.displayLarge.height, TypographyTokens.displayLarge.height);
      expect(
        t.displayLarge.letterSpacing,
        TypographyTokens.displayLarge.letterSpacing,
      );
      expect(t.bodyMedium.fontSize, TypographyTokens.bodyMedium.fontSize);
      expect(t.bodyMedium.letterSpacing,
          TypographyTokens.bodyMedium.letterSpacing);
    });

    test('is callable with no arguments', () {
      expect(AppTypography.defaults(), isA<AppTypography>());
    });
  });

  group('AppTypography.copyWith', () {
    test('overrides only the named field', () {
      final base = AppTypography.defaults();
      const replacement = TextStyle(fontSize: 99);
      final result = base.copyWith(bodyLarge: replacement);

      expect(result.bodyLarge, replacement);
      expect(result.bodyMedium, base.bodyMedium);
      expect(result.displayLarge, base.displayLarge);
      expect(result.labelSmallSecondary, base.labelSmallSecondary);
    });

    test('returns an equal instance when given no arguments', () {
      final base = AppTypography.defaults();
      expect(base.copyWith(), base);
    });
  });

  group('AppTypography.lerp', () {
    test('returns this when other is not an AppTypography', () {
      final base = AppTypography.defaults();
      expect(base.lerp(null, 0.5), same(base));
    });

    test('t=0 yields the start styles', () {
      final a = AppTypography.defaults(textPrimary: const Color(0xFF000000));
      final b = AppTypography.defaults(textPrimary: const Color(0xFFFFFFFF));

      expect(a.lerp(b, 0).displayLarge.color, a.displayLarge.color);
    });

    test('t=1 yields the end styles', () {
      final a = AppTypography.defaults(textPrimary: const Color(0xFF000000));
      final b = AppTypography.defaults(textPrimary: const Color(0xFFFFFFFF));

      expect(a.lerp(b, 1).displayLarge.color, b.displayLarge.color);
    });

    test('interpolates across all style families', () {
      final a = AppTypography.defaults(
        textPrimary: const Color(0xFF000000),
        textSecondary: const Color(0xFF000000),
        textTertiary: const Color(0xFF000000),
        primary: const Color(0xFF000000),
      );
      final b = AppTypography.defaults(
        textPrimary: const Color(0xFFFFFFFF),
        textSecondary: const Color(0xFFFFFFFF),
        textTertiary: const Color(0xFFFFFFFF),
        primary: const Color(0xFFFFFFFF),
      );
      final mid = a.lerp(b, 1);

      expect(mid.headlineLargePrimary.color, b.headlineLargePrimary.color);
      expect(mid.bodyLargeSecondary.color, b.bodyLargeSecondary.color);
      expect(mid.bodyLargeTertiary.color, b.bodyLargeTertiary.color);
      expect(mid.labelSmallSecondary.color, b.labelSmallSecondary.color);
      expect(mid.bodySmallEmphasis.color, b.bodySmallEmphasis.color);
    });
  });

  group('AppTypography equality', () {
    test('instances with identical values are equal', () {
      expect(AppTypography.defaults(), AppTypography.defaults());
      expect(
        AppTypography.defaults().hashCode,
        AppTypography.defaults().hashCode,
      );
    });

    test('a single differing style breaks equality', () {
      final base = AppTypography.defaults();
      expect(base.copyWith(labelSmall: const TextStyle()), isNot(base));
    });

    test('identical() short-circuits to true', () {
      final base = AppTypography.defaults();
      expect(base == base, isTrue);
    });

    test('is not equal to an unrelated type', () {
      expect(AppTypography.defaults() == Object(), isFalse);
    });
  });
}
