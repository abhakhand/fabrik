import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDuration with negative durations', () {
    test('renders a leading minus for a negative sub-hour duration', () {
      expect(formatDuration(const Duration(seconds: -65)), '-01:05');
    });

    test('renders a leading minus for a negative seconds-only duration', () {
      expect(formatDuration(const Duration(seconds: -5)), '-00:05');
    });

    test('renders a leading minus for a negative duration with hours', () {
      expect(formatDuration(const Duration(seconds: -3665)), '-01:01:05');
    });

    test('honours alwaysShowHours for negative durations', () {
      expect(
        formatDuration(const Duration(seconds: -65), alwaysShowHours: true),
        '-00:01:05',
      );
    });

    test('is symmetric with the positive equivalent', () {
      const magnitude = Duration(minutes: 3, seconds: 7);
      expect(formatDuration(-magnitude), '-${formatDuration(magnitude)}');
    });

    test('zero has no sign', () {
      expect(formatDuration(Duration.zero), '00:00');
    });

    test('positive durations are unchanged', () {
      expect(formatDuration(const Duration(seconds: 65)), '01:05');
      expect(formatDuration(const Duration(seconds: 3665)), '01:01:05');
    });
  });

  group('splitDuration with negative input', () {
    test('splits by magnitude rather than wrapping around', () {
      final (:hours, :minutes, :seconds) = splitDuration(-65);

      expect(hours, '-00');
      expect(minutes, '01');
      expect(seconds, '05');
    });

    test('carries the sign on hours for larger negatives', () {
      final (:hours, :minutes, :seconds) = splitDuration(-3665);

      expect(hours, '-01');
      expect(minutes, '01');
      expect(seconds, '05');
    });

    test('components mirror the positive equivalent', () {
      final negative = splitDuration(-3665);
      final positive = splitDuration(3665);

      expect(negative.minutes, positive.minutes);
      expect(negative.seconds, positive.seconds);
      expect(negative.hours, '-${positive.hours}');
    });

    test('zero is unsigned', () {
      final (:hours, :minutes, :seconds) = splitDuration(0);

      expect(hours, '00');
      expect(minutes, '00');
      expect(seconds, '00');
    });

    test('positive input is unchanged', () {
      final (:hours, :minutes, :seconds) = splitDuration(3665);

      expect(hours, '01');
      expect(minutes, '01');
      expect(seconds, '05');
    });
  });
}
