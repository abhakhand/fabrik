import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeX checkers', () {
    test('isToday returns true for today', () {
      expect(DateTime.now().isToday, isTrue);
    });

    test('isToday returns false for yesterday', () {
      expect(DateTime.now().subtract(const Duration(days: 1)).isToday, isFalse);
    });

    test('isTomorrow returns true for tomorrow', () {
      expect(DateTime.now().add(const Duration(days: 1)).isTomorrow, isTrue);
    });

    test('isTomorrow returns false for today', () {
      expect(DateTime.now().isTomorrow, isFalse);
    });

    test('isYesterday returns true for yesterday', () {
      expect(
        DateTime.now().subtract(const Duration(days: 1)).isYesterday,
        isTrue,
      );
    });

    test('isYesterday returns false for today', () {
      expect(DateTime.now().isYesterday, isFalse);
    });

    test('isWeekday returns true for Monday', () {
      // Monday 2024-06-17
      expect(DateTime(2024, 6, 17).isWeekday, isTrue);
    });

    test('isWeekday returns false for Saturday', () {
      // Saturday 2024-06-15
      expect(DateTime(2024, 6, 15).isWeekday, isFalse);
    });

    test('isWeekend returns true for Sunday', () {
      // Sunday 2024-06-16
      expect(DateTime(2024, 6, 16).isWeekend, isTrue);
    });

    test('isWeekend returns false for Friday', () {
      // Friday 2024-06-14
      expect(DateTime(2024, 6, 14).isWeekend, isFalse);
    });
  });

  group('DateTimeX.timeAgo', () {
    DateTime ago(Duration d) => DateTime.now().subtract(d);

    test('returns "just now" for under 60 seconds', () {
      expect(ago(const Duration(seconds: 30)).timeAgo, 'just now');
    });

    test('returns minutes ago', () {
      expect(ago(const Duration(minutes: 5)).timeAgo, '5 mins ago');
    });

    test('returns singular minute', () {
      expect(ago(const Duration(minutes: 1)).timeAgo, '1 min ago');
    });

    test('returns hours ago', () {
      expect(ago(const Duration(hours: 3)).timeAgo, '3 hours ago');
    });

    test('returns singular hour', () {
      expect(ago(const Duration(hours: 1)).timeAgo, '1 hour ago');
    });

    test('returns "yesterday" for 1 day ago', () {
      expect(ago(const Duration(days: 1)).timeAgo, 'yesterday');
    });

    test('returns days ago for 2-29 days', () {
      expect(ago(const Duration(days: 10)).timeAgo, '10 days ago');
    });

    test('returns months ago for 30+ days', () {
      expect(ago(const Duration(days: 60)).timeAgo, contains('month'));
    });

    test('months ago is at least 1', () {
      // Edge: just over 30 days — should still be "1 month ago"
      final result = ago(const Duration(days: 31)).timeAgo;
      expect(result, '1 month ago');
    });

    test('returns years ago for 365+ days', () {
      expect(ago(const Duration(days: 400)).timeAgo, contains('year'));
    });

    test('returns singular year for ~1 year ago', () {
      final result = ago(const Duration(days: 370)).timeAgo;
      expect(result, '1 year ago');
    });
  });

  group('DateTimeX formatters', () {
    final date = DateTime(1999, 9, 14, 23, 40);

    test('isoDate', () {
      expect(date.isoDate, '1999-09-14');
    });

    test('isoDateTime', () {
      expect(date.isoDateTime, "1999-09-14T23:40");
    });

    test('hourMinute24h', () {
      expect(date.hourMinute24h, '23:40');
    });
  });

  group('DateTimeX.isBetween', () {
    final start = DateTime(2024, 1, 1);
    final end = DateTime(2024, 12, 31);

    test('returns true when date is between start and end', () {
      expect(DateTime(2024, 6, 15).isBetween(start, end), isTrue);
    });

    test('returns true when date equals start (inclusive)', () {
      expect(start.isBetween(start, end), isTrue);
    });

    test('returns true when date equals end (inclusive)', () {
      expect(end.isBetween(start, end), isTrue);
    });

    test('returns false when date is before start', () {
      expect(DateTime(2023, 12, 31).isBetween(start, end), isFalse);
    });

    test('returns false when date is after end', () {
      expect(DateTime(2025, 1, 1).isBetween(start, end), isFalse);
    });
  });

  group('DateTimeX.startOfDay', () {
    test('returns midnight', () {
      final date = DateTime(2024, 6, 15, 14, 30, 45);
      expect(date.startOfDay, DateTime(2024, 6, 15));
    });

    test('returns midnight when already at midnight', () {
      final date = DateTime(2024, 6, 15);
      expect(date.startOfDay, DateTime(2024, 6, 15));
    });
  });

  group('DateTimeX.endOfDay', () {
    test('returns 23:59:59.999', () {
      final date = DateTime(2024, 6, 15, 14, 30);
      expect(date.endOfDay, DateTime(2024, 6, 15, 23, 59, 59, 999));
    });
  });

  group('DateTimeX.startOfWeek', () {
    test('returns Monday for a Wednesday', () {
      // Wednesday 2024-06-19
      expect(DateTime(2024, 6, 19).startOfWeek, DateTime(2024, 6, 17));
    });

    test('returns same day when already Monday', () {
      // Monday 2024-06-17
      expect(DateTime(2024, 6, 17).startOfWeek, DateTime(2024, 6, 17));
    });

    test('returns Monday for Sunday', () {
      // Sunday 2024-06-23
      expect(DateTime(2024, 6, 23).startOfWeek, DateTime(2024, 6, 17));
    });

    test('crosses month boundary correctly', () {
      // Wednesday 2024-07-03 → Monday 2024-07-01
      expect(DateTime(2024, 7, 3).startOfWeek, DateTime(2024, 7, 1));
    });
  });
}
