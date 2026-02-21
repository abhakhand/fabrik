import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDuration', () {
    test('formats mm:ss when under 1 hour', () {
      expect(formatDuration(const Duration(minutes: 4, seconds: 5)), '04:05');
    });

    test('formats HH:mm:ss when 1 hour or more', () {
      expect(
        formatDuration(const Duration(hours: 1, minutes: 1, seconds: 5)),
        '01:01:05',
      );
    });

    test('shows hours when alwaysShowHours is true', () {
      expect(
        formatDuration(const Duration(minutes: 4, seconds: 5), alwaysShowHours: true),
        '00:04:05',
      );
    });

    test('pads single-digit values', () {
      expect(formatDuration(const Duration(seconds: 9)), '00:09');
    });

    test('handles zero duration', () {
      expect(formatDuration(Duration.zero), '00:00');
    });

    test('handles zero duration with alwaysShowHours', () {
      expect(
        formatDuration(Duration.zero, alwaysShowHours: true),
        '00:00:00',
      );
    });

    test('handles large durations', () {
      expect(
        formatDuration(const Duration(hours: 99, minutes: 59, seconds: 59)),
        '99:59:59',
      );
    });
  });

  group('splitDuration', () {
    test('splits 3665 seconds into hours, minutes, seconds', () {
      final result = splitDuration(3665);
      expect(result.hours, '01');
      expect(result.minutes, '01');
      expect(result.seconds, '05');
    });

    test('pads single-digit values', () {
      final result = splitDuration(9);
      expect(result.hours, '00');
      expect(result.minutes, '00');
      expect(result.seconds, '09');
    });

    test('handles zero', () {
      final result = splitDuration(0);
      expect(result.hours, '00');
      expect(result.minutes, '00');
      expect(result.seconds, '00');
    });

    test('handles exactly 1 hour', () {
      final result = splitDuration(3600);
      expect(result.hours, '01');
      expect(result.minutes, '00');
      expect(result.seconds, '00');
    });

    test('handles large values', () {
      final result = splitDuration(359999); // 99:59:59
      expect(result.hours, '99');
      expect(result.minutes, '59');
      expect(result.seconds, '59');
    });
  });
}
