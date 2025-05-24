import 'package:intl/intl.dart';

/// Extension methods on [DateTime] for commonly used formatted date strings.
///
/// These use the `intl` package under the hood and are safe to use on all platforms.
/// ⚠️ Make sure to call `initializeDateFormatting()` in `main()` if using custom locales.
extension DateTimeX on DateTime {
  /// Checks if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Checks if the date is yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Checks if the date falls on a weekday (Monday to Friday).
  bool get isWeekday =>
      weekday >= DateTime.monday && weekday <= DateTime.friday;

  /// Checks if the date falls on a weekend (Saturday or Sunday).
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Returns a human-readable "time ago" format.
  ///
  /// Examples:
  /// - "just now"
  /// - "5 minutes ago"
  /// - "2 hours ago"
  /// - "yesterday"
  /// - "3 days ago"
  /// - "1 month ago"
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min${difference.inMinutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  /// e.g. "Sep 7"
  String get shortMonthDay => DateFormat.MMMd().format(this);

  /// e.g. "11:40 PM"
  String get time12Hour => DateFormat.jm().format(this);

  /// e.g. "14 Sep 1999"
  String get dayMonthYear => DateFormat.yMMMd().format(this);

  /// e.g. "Mon, Sep 14, 1999"
  String get fullWithWeekdayShort => DateFormat.yMMMEd().format(this);

  /// e.g. "Monday, September 14, 1999"
  String get fullWithWeekday => DateFormat.yMMMMEEEEd().format(this);

  /// e.g. "September 14, 1999 11:40 PM"
  String get fullDateTime => DateFormat.yMMMMd().add_jm().format(this);

  /// e.g. "Sep 14, 1999 11:40 PM"
  String get shortDateTime => DateFormat.yMMMd().add_jm().format(this);

  /// e.g. "Sep 14"
  String get monthDay => DateFormat.MMMd().format(this);

  /// e.g. "Monday"
  String get weekdayName => DateFormat.EEEE().format(this);

  /// e.g. "Mon"
  String get weekdayShort => DateFormat.E().format(this);

  /// e.g. "September"
  String get monthFull => DateFormat.MMMM().format(this);

  /// e.g. "Sep"
  String get monthShort => DateFormat.MMM().format(this);

  /// e.g. "11:40 PM"
  String get hourMinute12h => DateFormat.jm().format(this);

  /// e.g. "23:40"
  String get hourMinute24h => DateFormat.Hm().format(this);

  /// e.g. "2023-05-15"
  String get isoDate => DateFormat('yyyy-MM-dd').format(this);

  /// e.g. "2023-05-15T23:59"
  String get isoDateTime => DateFormat("yyyy-MM-dd'T'HH:mm").format(this);
}
