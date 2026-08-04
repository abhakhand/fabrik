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
  group('context.colors', () {
    testWidgets('returns the AppColors registered on the theme', (
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
      expect(seen.primary, _colors.primary);
    });

    // Regression guard for the 1.0.2 fix: this used to be an `assert`, which is
    // stripped in release builds and left a force-unwrap that crashed instead.
    testWidgets('throws a StateError when AppColors is missing', (
      tester,
    ) async {
      Object? captured;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Builder(
            builder: (context) {
              try {
                context.colors;
              } catch (e) {
                captured = e;
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured, isA<StateError>());
      expect(
        (captured! as StateError).message,
        contains('FabrikTheme.create'),
      );
    });

    testWidgets('reflects a theme swap', (tester) async {
      const swapped = AppColors(
        primary: Color(0xFF00FF00),
        onPrimary: Color(0xFF000000),
        accent: Color(0xFF00AA00),
        onAccent: Color(0xFF000000),
        surface: Color(0xFF001100),
        onSurface: Color(0xFFFFFFFF),
        textPrimary: Color(0xFFFFFFFF),
        textSecondary: Color(0xFFDDDDDD),
        textTertiary: Color(0xFFBBBBBB),
      );

      late AppColors seen;
      Widget app(AppColors colors) => MaterialApp(
        theme: FabrikTheme.create(
          brightness: Brightness.light,
          colors: colors,
        ),
        home: Builder(
          builder: (context) {
            seen = context.colors;
            return const SizedBox.shrink();
          },
        ),
      );

      await tester.pumpWidget(app(_colors));
      expect(seen, _colors);

      await tester.pumpWidget(app(swapped));
      await tester.pumpAndSettle();
      expect(seen, swapped);
    });
  });

  group('context.typography', () {
    testWidgets('returns the AppTypography registered on the theme', (
      tester,
    ) async {
      late AppTypography seen;

      await tester.pumpWidget(
        MaterialApp(
          theme: FabrikTheme.create(
            brightness: Brightness.light,
            colors: _colors,
          ),
          home: Builder(
            builder: (context) {
              seen = context.typography;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(seen, FabrikTypographyBuilder.build(_colors));
      expect(seen.bodyLarge.color, _colors.textPrimary);
    });

    testWidgets('throws a StateError when AppTypography is missing', (
      tester,
    ) async {
      Object? captured;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Builder(
            builder: (context) {
              try {
                context.typography;
              } catch (e) {
                captured = e;
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(captured, isA<StateError>());
      expect(
        (captured! as StateError).message,
        contains('FabrikTheme.create'),
      );
    });

    testWidgets('is usable directly as a Text style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: FabrikTheme.create(
            brightness: Brightness.light,
            colors: _colors,
          ),
          home: Builder(
            builder: (context) => Text(
              'hello',
              style: context.typography.headlineLargePrimary,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('hello'));
      expect(text.style?.color, _colors.primary);
      expect(tester.takeException(), isNull);
    });
  });
}
