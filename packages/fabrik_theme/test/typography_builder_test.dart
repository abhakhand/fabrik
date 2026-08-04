import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _colors = AppColors(
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  accent: Color(0xFF625B71),
  onAccent: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  textPrimary: Color(0xFF111111),
  textSecondary: Color(0xFF222222),
  textTertiary: Color(0xFF333333),
);

void main() {
  group('FabrikTypographyBuilder.build', () {
    test('derives base styles from textPrimary', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.displayLarge.color, _colors.textPrimary);
      expect(t.headlineLarge.color, _colors.textPrimary);
      expect(t.titleLarge.color, _colors.textPrimary);
      expect(t.bodyLarge.color, _colors.textPrimary);
    });

    test('derives accent variants from the brand primary color', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.displayLargePrimary.color, _colors.primary);
      expect(t.headlineMediumPrimary.color, _colors.primary);
      expect(t.titleSmallPrimary.color, _colors.primary);
    });

    test('derives primary labels from the brand primary color', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.labelLarge.color, _colors.primary);
      expect(t.labelMedium.color, _colors.primary);
      expect(t.labelSmall.color, _colors.primary);
    });

    test('derives secondary and tertiary variants from their color roles', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.bodyLargeSecondary.color, _colors.textSecondary);
      expect(t.labelLargeSecondary.color, _colors.textSecondary);
      expect(t.bodyLargeTertiary.color, _colors.textTertiary);
    });

    test('emphasis variants use textPrimary at weight w500', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.bodyLargeEmphasis.color, _colors.textPrimary);
      expect(t.bodyLargeEmphasis.fontWeight, FontWeight.w500);
    });

    test('leaves fontFamily unset when none is supplied', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.displayLarge.fontFamily, isNull);
      expect(t.bodyMedium.fontFamily, isNull);
    });

    test('applies fontFamily uniformly across every style', () {
      const family = 'Inter';
      final t = FabrikTypographyBuilder.build(_colors, fontFamily: family);

      final styles = <String, TextStyle>{
        'displayLarge': t.displayLarge,
        'displaySmallPrimary': t.displaySmallPrimary,
        'headlineMedium': t.headlineMedium,
        'headlineLargePrimary': t.headlineLargePrimary,
        'titleSmall': t.titleSmall,
        'titleMediumPrimary': t.titleMediumPrimary,
        'bodyLarge': t.bodyLarge,
        'bodyMediumSecondary': t.bodyMediumSecondary,
        'bodySmallTertiary': t.bodySmallTertiary,
        'bodyLargeEmphasis': t.bodyLargeEmphasis,
        'labelLarge': t.labelLarge,
        'labelSmallSecondary': t.labelSmallSecondary,
      };

      styles.forEach((name, style) {
        expect(style.fontFamily, family, reason: '$name must use $family');
      });
    });

    test('preserves token metrics', () {
      final t = FabrikTypographyBuilder.build(_colors);

      expect(t.displayLarge.fontSize, TypographyTokens.displayLarge.fontSize);
      expect(t.displayLarge.height, TypographyTokens.displayLarge.height);
      expect(t.labelSmall.letterSpacing,
          TypographyTokens.labelSmall.letterSpacing);
    });

    test('reflects changes in the supplied colors', () {
      const swapped = Color(0xFFFF0000);
      final t = FabrikTypographyBuilder.build(
        _colors.copyWith(primary: swapped),
      );

      expect(t.labelLarge.color, swapped);
      expect(t.displayLargePrimary.color, swapped);
    });

    test('two builds from equal colors produce equal typography', () {
      expect(
        FabrikTypographyBuilder.build(_colors),
        FabrikTypographyBuilder.build(_colors),
      );
    });
  });
}
