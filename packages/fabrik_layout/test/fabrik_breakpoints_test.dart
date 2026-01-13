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
  });
}
