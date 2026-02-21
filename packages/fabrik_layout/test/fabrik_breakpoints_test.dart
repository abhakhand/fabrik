import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FabrikBreakpoints', () {
    test('has correct default values', () {
      const breakpoints = FabrikBreakpoints();

      expect(breakpoints.mobile, 600);
      expect(breakpoints.tablet, 1024);
      expect(breakpoints.desktop, 1440);
    });

    test('accepts custom breakpoint values', () {
      const breakpoints = FabrikBreakpoints(
        mobile: 480,
        tablet: 768,
        desktop: 1280,
      );

      expect(breakpoints.mobile, 480);
      expect(breakpoints.tablet, 768);
      expect(breakpoints.desktop, 1280);
    });

    test('allows partial custom values', () {
      const breakpoints = FabrikBreakpoints(mobile: 500);

      expect(breakpoints.mobile, 500);
      expect(breakpoints.tablet, 1024);
      expect(breakpoints.desktop, 1440);
    });

    test('asserts mobile is less than tablet', () {
      expect(
        () => FabrikBreakpoints(mobile: 1024, tablet: 600),
        throwsAssertionError,
      );
    });

    group('equality', () {
      test('equal when all values match', () {
        const a = FabrikBreakpoints(mobile: 480, tablet: 768, desktop: 1280);
        const b = FabrikBreakpoints(mobile: 480, tablet: 768, desktop: 1280);

        expect(a, equals(b));
        expect(a.hashCode, equals(b.hashCode));
      });

      test('not equal when mobile differs', () {
        const a = FabrikBreakpoints(mobile: 480, tablet: 768);
        const b = FabrikBreakpoints(mobile: 500, tablet: 768);

        expect(a, isNot(equals(b)));
      });

      test('not equal when tablet differs', () {
        const a = FabrikBreakpoints(mobile: 480, tablet: 768);
        const b = FabrikBreakpoints(mobile: 480, tablet: 900);

        expect(a, isNot(equals(b)));
      });
    });
  });
}
