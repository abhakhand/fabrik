import 'package:fabrik_utils/fabrik_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('timeAgo for future dates', () {
    test('a moment ahead still reads as just now', () {
      final date = DateTime.now().add(const Duration(seconds: 30));
      expect(date.timeAgo, 'just now');
    });

    test('minutes ahead read as "in N mins"', () {
      final date = DateTime.now().add(const Duration(minutes: 5, seconds: 1));
      expect(date.timeAgo, 'in 5 mins');
    });

    test('a single minute ahead is not pluralised', () {
      final date = DateTime.now().add(const Duration(minutes: 1, seconds: 1));
      expect(date.timeAgo, 'in 1 min');
    });

    test('hours ahead read as "in N hours"', () {
      final date = DateTime.now().add(const Duration(hours: 5, seconds: 1));
      expect(date.timeAgo, 'in 5 hours');
    });

    test('a single hour ahead is not pluralised', () {
      final date = DateTime.now().add(const Duration(hours: 1, seconds: 1));
      expect(date.timeAgo, 'in 1 hour');
    });

    test('one day ahead reads as tomorrow', () {
      final date = DateTime.now().add(const Duration(days: 1, seconds: 1));
      expect(date.timeAgo, 'tomorrow');
    });

    test('several days ahead read as "in N days"', () {
      final date = DateTime.now().add(const Duration(days: 3, seconds: 1));
      expect(date.timeAgo, 'in 3 days');
    });

    test('months ahead read as "in N months"', () {
      final date = DateTime.now().add(const Duration(days: 65));
      expect(date.timeAgo, 'in 2 months');
    });

    test('years ahead read as "in N years"', () {
      final date = DateTime.now().add(const Duration(days: 400));
      expect(date.timeAgo, 'in 1 year');
    });

    test('never reports a future date as "just now" beyond a minute', () {
      final cases = [
        const Duration(minutes: 10),
        const Duration(hours: 3),
        const Duration(days: 2),
        const Duration(days: 90),
        const Duration(days: 800),
      ];

      for (final offset in cases) {
        final result = DateTime.now().add(offset + const Duration(seconds: 1)).timeAgo;
        expect(
          result,
          isNot('just now'),
          reason: '$offset ahead should not read as "just now"',
        );
        expect(
          result.startsWith('in ') || result == 'tomorrow',
          isTrue,
          reason: '$offset ahead should read as future, got "$result"',
        );
      }
    });
  });

  group('timeAgo for past dates is unchanged', () {
    test('under a minute reads as just now', () {
      expect(
        DateTime.now().subtract(const Duration(seconds: 30)).timeAgo,
        'just now',
      );
    });

    test('minutes ago', () {
      expect(
        DateTime.now().subtract(const Duration(minutes: 5)).timeAgo,
        '5 mins ago',
      );
    });

    test('a single minute ago is not pluralised', () {
      expect(
        DateTime.now().subtract(const Duration(minutes: 1)).timeAgo,
        '1 min ago',
      );
    });

    test('hours ago', () {
      expect(
        DateTime.now().subtract(const Duration(hours: 2)).timeAgo,
        '2 hours ago',
      );
    });

    test('one day ago reads as yesterday', () {
      expect(
        DateTime.now().subtract(const Duration(days: 1)).timeAgo,
        'yesterday',
      );
    });

    test('several days ago', () {
      expect(
        DateTime.now().subtract(const Duration(days: 3)).timeAgo,
        '3 days ago',
      );
    });

    test('months ago', () {
      expect(
        DateTime.now().subtract(const Duration(days: 65)).timeAgo,
        '2 months ago',
      );
    });

    test('years ago', () {
      expect(
        DateTime.now().subtract(const Duration(days: 400)).timeAgo,
        '1 year ago',
      );
    });
  });
}
