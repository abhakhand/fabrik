import 'package:fabrik_layout/fabrik_layout.dart';
import 'package:fabrik_layout/src/text_scaling.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveTextScaler', () {
    const defaultConfig = FabrikTextScaleConfig();

    test('returns 1.0 scale factor for mobile', () {
      const systemScaler = TextScaler.linear(1.0);
      final result = resolveTextScaler(
        device: FabrikLayoutType.mobile,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      expect(result.scale(1.0), 1.0);
    });

    test('returns 1.05 scale factor for tablet', () {
      const systemScaler = TextScaler.linear(1.0);
      final result = resolveTextScaler(
        device: FabrikLayoutType.tablet,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      expect(result.scale(1.0), 1.05);
    });

    test('returns 1.1 scale factor for desktop', () {
      const systemScaler = TextScaler.linear(1.0);
      final result = resolveTextScaler(
        device: FabrikLayoutType.desktop,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      expect(result.scale(1.0), 1.1);
    });

    test('respects system scaler when it is higher than device minimum', () {
      const systemScaler = TextScaler.linear(1.5);
      final result = resolveTextScaler(
        device: FabrikLayoutType.mobile,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      expect(result.scale(1.0), 1.5);
    });

    test('uses device minimum when system scaler is lower', () {
      const systemScaler = TextScaler.linear(0.8);
      final result = resolveTextScaler(
        device: FabrikLayoutType.desktop,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      // Should be clamped to desktop minimum of 1.1
      expect(result.scale(1.0), 1.1);
    });

    test('clamps correctly for tablet with low system scaler', () {
      const systemScaler = TextScaler.linear(0.9);
      final result = resolveTextScaler(
        device: FabrikLayoutType.tablet,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      // Should be clamped to tablet minimum of 1.05
      expect(result.scale(1.0), 1.05);
    });

    test('handles noScaling system scaler', () {
      const systemScaler = TextScaler.noScaling;
      final result = resolveTextScaler(
        device: FabrikLayoutType.desktop,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      // Should be clamped to desktop minimum of 1.1
      expect(result.scale(1.0), 1.1);
    });

    test('scales different font sizes consistently', () {
      const systemScaler = TextScaler.linear(1.2);
      final result = resolveTextScaler(
        device: FabrikLayoutType.tablet,
        systemScaler: systemScaler,
        config: defaultConfig,
      );

      expect(result.scale(10.0), 12.0);
      expect(result.scale(14.0), 16.8);
      expect(result.scale(20.0), 24.0);
    });

    test('uses custom config scale factors', () {
      const customConfig = FabrikTextScaleConfig(
        mobile: 1.0,
        tablet: 1.08,
        desktop: 1.15,
      );
      const systemScaler = TextScaler.linear(1.0);

      final tabletResult = resolveTextScaler(
        device: FabrikLayoutType.tablet,
        systemScaler: systemScaler,
        config: customConfig,
      );
      final desktopResult = resolveTextScaler(
        device: FabrikLayoutType.desktop,
        systemScaler: systemScaler,
        config: customConfig,
      );

      expect(tabletResult.scale(1.0), 1.08);
      expect(desktopResult.scale(1.0), 1.15);
    });
  });
}
