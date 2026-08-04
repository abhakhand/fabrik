import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:fabrik_layout/src/text_scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<FabrikLayoutData> layoutAt(
  WidgetTester tester,
  double width, {
  FabrikBreakpoints breakpoints = const FabrikBreakpoints(),
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  late FabrikLayoutData data;
  await tester.pumpWidget(
    MaterialApp(
      builder: (context, child) =>
          FabrikLayout(breakpoints: breakpoints, child: child!),
      home: Builder(
        builder: (context) {
          data = context.layout;
          return const SizedBox.expand();
        },
      ),
    ),
  );
  return data;
}

void main() {
  // Regression guard: `FabrikBreakpoints.desktop` was documented as "reserved"
  // and had no effect — setting it to 1, 1440 or 9999 produced identical
  // classification. It now separates desktop from largeDesktop.
  group('desktop breakpoint drives classification', () {
    testWidgets('widths below the desktop threshold are desktop', (
      tester,
    ) async {
      expect((await layoutAt(tester, 1024)).type, FabrikLayoutType.desktop);
      expect((await layoutAt(tester, 1200)).type, FabrikLayoutType.desktop);
      expect((await layoutAt(tester, 1439)).type, FabrikLayoutType.desktop);
    });

    testWidgets('widths at or above the threshold are largeDesktop', (
      tester,
    ) async {
      expect(
        (await layoutAt(tester, 1440)).type,
        FabrikLayoutType.largeDesktop,
      );
      expect(
        (await layoutAt(tester, 1920)).type,
        FabrikLayoutType.largeDesktop,
      );
    });

    testWidgets('a custom desktop threshold takes effect', (tester) async {
      const breakpoints = FabrikBreakpoints(desktop: 1280);

      expect(
        (await layoutAt(tester, 1200, breakpoints: breakpoints)).type,
        FabrikLayoutType.desktop,
      );
      expect(
        (await layoutAt(tester, 1300, breakpoints: breakpoints)).type,
        FabrikLayoutType.largeDesktop,
      );
    });

    testWidgets('the narrower bands are unchanged', (tester) async {
      expect((await layoutAt(tester, 375)).type, FabrikLayoutType.mobile);
      expect((await layoutAt(tester, 599)).type, FabrikLayoutType.mobile);
      expect((await layoutAt(tester, 600)).type, FabrikLayoutType.tablet);
      expect((await layoutAt(tester, 1023)).type, FabrikLayoutType.tablet);
    });

    test('breakpoints must be ordered', () {
      expect(
        () => FabrikBreakpoints(tablet: 1024, desktop: 500),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => FabrikBreakpoints(mobile: 1024, tablet: 600),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('largeDesktop accessors', () {
    const data = FabrikLayoutData(
      type: FabrikLayoutType.largeDesktop,
      screenSize: Size(1600, 900),
      textScaler: TextScaler.noScaling,
    );

    test('isLargeDesktop is set only for the widest band', () {
      expect(data.isLargeDesktop, isTrue);
      expect(data.isDesktop, isFalse);
      expect(data.isMobile, isFalse);
      expect(data.isTablet, isFalse);
    });

    test('isDesktopOrWider covers desktop and largeDesktop', () {
      expect(data.isDesktopOrWider, isTrue);
      expect(
        data.copyWith(type: FabrikLayoutType.desktop).isDesktopOrWider,
        isTrue,
      );
      expect(
        data.copyWith(type: FabrikLayoutType.tablet).isDesktopOrWider,
        isFalse,
      );
      expect(
        data.copyWith(type: FabrikLayoutType.mobile).isDesktopOrWider,
        isFalse,
      );
    });
  });

  group('value<T> fallback chain', () {
    const largeDesktop = FabrikLayoutData(
      type: FabrikLayoutType.largeDesktop,
      screenSize: Size(1600, 900),
      textScaler: TextScaler.noScaling,
    );

    test('uses the largeDesktop value when supplied', () {
      expect(
        largeDesktop.value<int>(
          mobile: 1,
          tablet: 2,
          desktop: 3,
          largeDesktop: 4,
        ),
        4,
      );
    });

    test('falls back to desktop when largeDesktop is omitted', () {
      expect(largeDesktop.value<int>(mobile: 1, tablet: 2, desktop: 3), 3);
    });

    test('falls back through tablet to mobile', () {
      expect(largeDesktop.value<int>(mobile: 1, tablet: 2), 2);
      expect(largeDesktop.value<int>(mobile: 1), 1);
    });

    test('narrower categories ignore the largeDesktop value', () {
      final tablet = largeDesktop.copyWith(type: FabrikLayoutType.tablet);
      expect(
        tablet.value<int>(mobile: 1, tablet: 2, desktop: 3, largeDesktop: 4),
        2,
      );
    });
  });

  group('text scaling for largeDesktop', () {
    test('reuses the desktop floor by default', () {
      const config = FabrikTextScaleConfig();
      expect(config.effectiveLargeDesktop, config.desktop);
    });

    test('honours an explicit largeDesktop floor', () {
      const config = FabrikTextScaleConfig(largeDesktop: 1.25);
      expect(config.effectiveLargeDesktop, 1.25);
    });

    test('resolves the scaler for largeDesktop', () {
      final scaler = resolveTextScaler(
        device: FabrikLayoutType.largeDesktop,
        systemScaler: TextScaler.noScaling,
        config: const FabrikTextScaleConfig(largeDesktop: 1.3),
      );

      expect(scaler.scale(10), closeTo(13, 0.001));
    });

    test('never reduces the system scale', () {
      final scaler = resolveTextScaler(
        device: FabrikLayoutType.largeDesktop,
        systemScaler: const TextScaler.linear(2),
        config: const FabrikTextScaleConfig(largeDesktop: 1.1),
      );

      expect(scaler.scale(10), closeTo(20, 0.001));
    });

    test('rejects a non-positive largeDesktop factor', () {
      expect(
        () => FabrikTextScaleConfig(largeDesktop: 0),
        throwsA(isA<AssertionError>()),
      );
    });

    test('equality accounts for largeDesktop', () {
      expect(
        const FabrikTextScaleConfig(largeDesktop: 1.2),
        const FabrikTextScaleConfig(largeDesktop: 1.2),
      );
      expect(
        const FabrikTextScaleConfig(largeDesktop: 1.2),
        isNot(const FabrikTextScaleConfig()),
      );
    });
  });
}
