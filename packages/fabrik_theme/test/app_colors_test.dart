import 'package:fabrik_theme/fabrik_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _a = AppColors(
  primary: Color(0xFF000000),
  onPrimary: Color(0xFF010101),
  accent: Color(0xFF020202),
  onAccent: Color(0xFF030303),
  surface: Color(0xFF040404),
  onSurface: Color(0xFF050505),
  textPrimary: Color(0xFF060606),
  textSecondary: Color(0xFF070707),
  textTertiary: Color(0xFF080808),
);

const _b = AppColors(
  primary: Color(0xFFFFFFFF),
  onPrimary: Color(0xFFFEFEFE),
  accent: Color(0xFFFDFDFD),
  onAccent: Color(0xFFFCFCFC),
  surface: Color(0xFFFBFBFB),
  onSurface: Color(0xFFFAFAFA),
  textPrimary: Color(0xFFF9F9F9),
  textSecondary: Color(0xFFF8F8F8),
  textTertiary: Color(0xFFF7F7F7),
);

void main() {
  group('AppColors.defaults', () {
    test('maps every role from ColorTokens', () {
      final colors = AppColors.defaults();

      expect(colors.primary, ColorTokens.primary);
      expect(colors.onPrimary, ColorTokens.onPrimary);
      expect(colors.accent, ColorTokens.accent);
      expect(colors.onAccent, ColorTokens.onAccent);
      expect(colors.surface, ColorTokens.surface);
      expect(colors.onSurface, ColorTokens.onSurface);
      expect(colors.textPrimary, ColorTokens.textPrimary);
      expect(colors.textSecondary, ColorTokens.textSecondary);
      expect(colors.textTertiary, ColorTokens.textTertiary);
    });
  });

  group('AppColors.copyWith', () {
    test('overrides only the named field', () {
      const replacement = Color(0xFFAABBCC);
      final result = _a.copyWith(primary: replacement);

      expect(result.primary, replacement);
      expect(result.onPrimary, _a.onPrimary);
      expect(result.accent, _a.accent);
      expect(result.onAccent, _a.onAccent);
      expect(result.surface, _a.surface);
      expect(result.onSurface, _a.onSurface);
      expect(result.textPrimary, _a.textPrimary);
      expect(result.textSecondary, _a.textSecondary);
      expect(result.textTertiary, _a.textTertiary);
    });

    test('returns an equal instance when given no arguments', () {
      expect(_a.copyWith(), _a);
    });

    test('can override every field independently', () {
      final result = _a.copyWith(
        primary: _b.primary,
        onPrimary: _b.onPrimary,
        accent: _b.accent,
        onAccent: _b.onAccent,
        surface: _b.surface,
        onSurface: _b.onSurface,
        textPrimary: _b.textPrimary,
        textSecondary: _b.textSecondary,
        textTertiary: _b.textTertiary,
      );

      expect(result, _b);
    });
  });

  group('AppColors.lerp', () {
    test('returns this when other is not an AppColors', () {
      expect(_a.lerp(null, 0.5), same(_a));
    });

    test('t=0 yields the start colors', () {
      final result = _a.lerp(_b, 0);
      expect(result.primary, _a.primary);
      expect(result.textTertiary, _a.textTertiary);
    });

    test('t=1 yields the end colors', () {
      final result = _a.lerp(_b, 1);
      expect(result.primary, _b.primary);
      expect(result.textTertiary, _b.textTertiary);
    });

    test('t=0.5 lands between the endpoints', () {
      final result = _a.lerp(_b, 0.5);
      final luminance = result.primary.computeLuminance();

      expect(luminance, greaterThan(_a.primary.computeLuminance()));
      expect(luminance, lessThan(_b.primary.computeLuminance()));
    });

    test('interpolates every field, not just primary', () {
      final result = _a.lerp(_b, 1);

      expect(result.onPrimary, _b.onPrimary);
      expect(result.accent, _b.accent);
      expect(result.onAccent, _b.onAccent);
      expect(result.surface, _b.surface);
      expect(result.onSurface, _b.onSurface);
      expect(result.textPrimary, _b.textPrimary);
      expect(result.textSecondary, _b.textSecondary);
    });
  });

  group('AppColors equality', () {
    test('instances with identical values are equal', () {
      expect(AppColors.defaults(), AppColors.defaults());
      expect(AppColors.defaults().hashCode, AppColors.defaults().hashCode);
    });

    test('a single differing field breaks equality', () {
      expect(_a.copyWith(textTertiary: const Color(0xFF123456)), isNot(_a));
    });

    test('identical() short-circuits to true', () {
      expect(_a == _a, isTrue);
    });

    test('is not equal to an unrelated type', () {
      expect(_a == Object(), isFalse);
    });
  });
}
