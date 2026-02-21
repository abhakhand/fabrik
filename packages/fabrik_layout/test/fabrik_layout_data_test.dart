import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikLayoutData', () {
    test('creates instance with required properties', () {
      const data = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      expect(data.type, FabrikLayoutType.mobile);
      expect(data.screenSize, const Size(375, 667));
      expect(data.textScaler, const TextScaler.linear(1.0));
    });

    test('defaults orientation to portrait', () {
      const data = FabrikLayoutData(
        type: FabrikLayoutType.mobile,
        screenSize: Size(375, 667),
        textScaler: TextScaler.linear(1.0),
      );

      expect(data.orientation, Orientation.portrait);
    });

    test('stores explicit orientation', () {
      const data = FabrikLayoutData(
        type: FabrikLayoutType.tablet,
        screenSize: Size(1024, 768),
        textScaler: TextScaler.linear(1.0),
        orientation: Orientation.landscape,
      );

      expect(data.orientation, Orientation.landscape);
    });

    group('convenience getters', () {
      test('isMobile returns true for mobile type', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
        );

        expect(data.isMobile, true);
        expect(data.isTablet, false);
        expect(data.isDesktop, false);
      });

      test('isTablet returns true for tablet type', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.tablet,
          screenSize: Size(768, 1024),
          textScaler: TextScaler.linear(1.0),
        );

        expect(data.isMobile, false);
        expect(data.isTablet, true);
        expect(data.isDesktop, false);
      });

      test('isDesktop returns true for desktop type', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.desktop,
          screenSize: Size(1920, 1080),
          textScaler: TextScaler.linear(1.0),
        );

        expect(data.isMobile, false);
        expect(data.isTablet, false);
        expect(data.isDesktop, true);
      });

      test('isPortrait returns true for portrait orientation', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );

        expect(data.isPortrait, true);
        expect(data.isLandscape, false);
      });

      test('isLandscape returns true for landscape orientation', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(667, 375),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.landscape,
        );

        expect(data.isPortrait, false);
        expect(data.isLandscape, true);
      });
    });

    group('value method', () {
      test('returns mobile value for mobile layout', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1, tablet: 2, desktop: 3);

        expect(result, 1);
      });

      test('returns tablet value for tablet layout', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.tablet,
          screenSize: Size(768, 1024),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1, tablet: 2, desktop: 3);

        expect(result, 2);
      });

      test('returns desktop value for desktop layout', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.desktop,
          screenSize: Size(1920, 1080),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1, tablet: 2, desktop: 3);

        expect(result, 3);
      });

      test('falls back to tablet when desktop is null', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.desktop,
          screenSize: Size(1920, 1080),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1, tablet: 2);

        expect(result, 2);
      });

      test('falls back to mobile when tablet and desktop are null', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.desktop,
          screenSize: Size(1920, 1080),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1);

        expect(result, 1);
      });

      test('falls back to mobile when tablet is null on tablet layout', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.tablet,
          screenSize: Size(768, 1024),
          textScaler: TextScaler.linear(1.0),
        );

        final result = data.value<int>(mobile: 1, desktop: 3);

        expect(result, 1);
      });

      test('works with different types', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.tablet,
          screenSize: Size(768, 1024),
          textScaler: TextScaler.linear(1.0),
        );

        final stringResult = data.value<String>(
          mobile: 'small',
          tablet: 'medium',
          desktop: 'large',
        );

        final doubleResult = data.value<double>(
          mobile: 8.0,
          tablet: 16.0,
          desktop: 24.0,
        );

        expect(stringResult, 'medium');
        expect(doubleResult, 16.0);
      });
    });

    group('equality', () {
      test('equal when all fields match', () {
        const a = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );
        const b = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );

        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('not equal when type differs', () {
        const a = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
        );
        const b = FabrikLayoutData(
          type: FabrikLayoutType.tablet,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
        );

        expect(a, isNot(equals(b)));
      });

      test('not equal when orientation differs', () {
        const a = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );
        const b = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.landscape,
        );

        expect(a, isNot(equals(b)));
      });
    });

    group('copyWith', () {
      test('returns identical data when no fields provided', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );

        expect(data.copyWith(), equals(data));
      });

      test('replaces type', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
        );

        final updated = data.copyWith(type: FabrikLayoutType.tablet);

        expect(updated.type, FabrikLayoutType.tablet);
        expect(updated.screenSize, data.screenSize);
      });

      test('replaces orientation', () {
        const data = FabrikLayoutData(
          type: FabrikLayoutType.mobile,
          screenSize: Size(375, 667),
          textScaler: TextScaler.linear(1.0),
          orientation: Orientation.portrait,
        );

        final updated = data.copyWith(orientation: Orientation.landscape);

        expect(updated.orientation, Orientation.landscape);
        expect(updated.type, data.type);
      });
    });
  });
}
