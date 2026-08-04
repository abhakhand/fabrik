import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SpacingTokens', () {
    test('exposes a monotonically increasing scale', () {
      const scale = [
        SpacingTokens.none,
        SpacingTokens.xxs,
        SpacingTokens.xs,
        SpacingTokens.sm,
        SpacingTokens.md,
        SpacingTokens.lg,
        SpacingTokens.xl,
        SpacingTokens.xxl,
        SpacingTokens.xxxl,
      ];

      for (var i = 1; i < scale.length; i++) {
        expect(
          scale[i],
          greaterThan(scale[i - 1]),
          reason: 'spacing scale must strictly increase at index $i',
        );
      }
    });

    test('starts at zero', () {
      expect(SpacingTokens.none, 0);
    });
  });

  group('RadiusTokens', () {
    test('exposes a monotonically increasing scale', () {
      const scale = [
        RadiusTokens.none,
        RadiusTokens.xs,
        RadiusTokens.sm,
        RadiusTokens.md,
        RadiusTokens.lg,
        RadiusTokens.xl,
        RadiusTokens.full,
      ];

      for (var i = 1; i < scale.length; i++) {
        expect(
          scale[i],
          greaterThan(scale[i - 1]),
          reason: 'radius scale must strictly increase at index $i',
        );
      }
    });

    test('full is large enough to render pills and circles', () {
      expect(RadiusTokens.full, greaterThanOrEqualTo(999));
    });
  });

  group('ElevationTokens', () {
    test('exposes a monotonically increasing scale', () {
      const scale = [
        ElevationTokens.none,
        ElevationTokens.xs,
        ElevationTokens.sm,
        ElevationTokens.md,
        ElevationTokens.lg,
        ElevationTokens.xl,
      ];

      for (var i = 1; i < scale.length; i++) {
        expect(
          scale[i],
          greaterThan(scale[i - 1]),
          reason: 'elevation scale must strictly increase at index $i',
        );
      }
    });
  });

  group('BorderTokens', () {
    test('exposes a monotonically increasing scale', () {
      const scale = [
        BorderTokens.none,
        BorderTokens.thin,
        BorderTokens.medium,
        BorderTokens.thick,
      ];

      for (var i = 1; i < scale.length; i++) {
        expect(
          scale[i],
          greaterThan(scale[i - 1]),
          reason: 'border scale must strictly increase at index $i',
        );
      }
    });
  });

  group('ColorTokens', () {
    test('every token is fully opaque', () {
      const tokens = <String, Color>{
        'primary': ColorTokens.primary,
        'onPrimary': ColorTokens.onPrimary,
        'accent': ColorTokens.accent,
        'onAccent': ColorTokens.onAccent,
        'surface': ColorTokens.surface,
        'onSurface': ColorTokens.onSurface,
        'textPrimary': ColorTokens.textPrimary,
        'textSecondary': ColorTokens.textSecondary,
        'textTertiary': ColorTokens.textTertiary,
      };

      tokens.forEach((name, color) {
        expect(color.a, 1.0, reason: '$name must be fully opaque');
      });
    });

    test('text tokens descend in emphasis', () {
      // Primary text is darkest, tertiary is lightest.
      expect(
        ColorTokens.textPrimary.computeLuminance(),
        lessThan(ColorTokens.textSecondary.computeLuminance()),
      );
      expect(
        ColorTokens.textSecondary.computeLuminance(),
        lessThan(ColorTokens.textTertiary.computeLuminance()),
      );
    });

    test('on-colors contrast against their backgrounds', () {
      expect(
        (ColorTokens.onPrimary.computeLuminance() -
                ColorTokens.primary.computeLuminance())
            .abs(),
        greaterThan(0.3),
      );
      expect(
        (ColorTokens.onSurface.computeLuminance() -
                ColorTokens.surface.computeLuminance())
            .abs(),
        greaterThan(0.3),
      );
    });
  });

  group('TypographyTokens', () {
    test('display > headline > title sizes are ordered', () {
      expect(
        TypographyTokens.displayLarge.fontSize,
        greaterThan(TypographyTokens.displayMedium.fontSize!),
      );
      expect(
        TypographyTokens.displayMedium.fontSize,
        greaterThan(TypographyTokens.displaySmall.fontSize!),
      );
      expect(
        TypographyTokens.displaySmall.fontSize,
        greaterThan(TypographyTokens.headlineLarge.fontSize!),
      );
      expect(
        TypographyTokens.headlineLarge.fontSize,
        greaterThan(TypographyTokens.headlineMedium.fontSize!),
      );
      expect(
        TypographyTokens.headlineSmall.fontSize,
        greaterThan(TypographyTokens.titleLarge.fontSize!),
      );
    });

    test('tokens carry no color — colors are applied at build time', () {
      const tokens = <String, TextStyle>{
        'displayLarge': TypographyTokens.displayLarge,
        'headlineLarge': TypographyTokens.headlineLarge,
        'titleLarge': TypographyTokens.titleLarge,
        'bodyLarge': TypographyTokens.bodyLarge,
        'labelLarge': TypographyTokens.labelLarge,
      };

      tokens.forEach((name, style) {
        expect(style.color, isNull, reason: '$name must not bake in a color');
      });
    });

    test('every token defines a size and line height', () {
      const tokens = <String, TextStyle>{
        'displayLarge': TypographyTokens.displayLarge,
        'displayMedium': TypographyTokens.displayMedium,
        'displaySmall': TypographyTokens.displaySmall,
        'headlineLarge': TypographyTokens.headlineLarge,
        'headlineMedium': TypographyTokens.headlineMedium,
        'headlineSmall': TypographyTokens.headlineSmall,
        'titleLarge': TypographyTokens.titleLarge,
        'titleMedium': TypographyTokens.titleMedium,
        'titleSmall': TypographyTokens.titleSmall,
        'bodyLarge': TypographyTokens.bodyLarge,
        'bodyMedium': TypographyTokens.bodyMedium,
        'bodySmall': TypographyTokens.bodySmall,
        'labelLarge': TypographyTokens.labelLarge,
        'labelMedium': TypographyTokens.labelMedium,
        'labelSmall': TypographyTokens.labelSmall,
      };

      tokens.forEach((name, style) {
        expect(style.fontSize, isNotNull, reason: '$name needs a fontSize');
        expect(style.fontSize, greaterThan(0), reason: '$name size must be > 0');
        expect(style.height, isNotNull, reason: '$name needs a line height');
      });
    });
  });
}
