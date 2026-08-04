import 'package:intl/intl.dart';

/// Extension methods on [DateTime] for commonly used formatted date strings.
///
/// These use the `intl` package under the hood and are safe to use on all platforms.
/// Make sure to call `initializeDateFormatting()` in `main()` if using custom locales.
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

  /// Returns a human-readable relative time string.
  ///
  /// Past dates read as "… ago" and future dates read as "in …", so the same
  /// getter works for both timestamps and scheduled events.
  ///
  /// Examples:
  /// - "just now"
  /// - "5 mins ago" / "in 5 mins"
  /// - "2 hours ago" / "in 2 hours"
  /// - "yesterday" / "tomorrow"
  /// - "3 days ago" / "in 3 days"
  /// - "1 month ago" / "in 1 month"
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);
    final isFuture = difference.isNegative;

    // Work with the magnitude, then apply the past/future wording once.
    final magnitude = isFuture ? -difference : difference;

    String phrase(String value) => isFuture ? 'in $value' : '$value ago';

    if (magnitude.inSeconds < 60) {
      return 'just now';
    } else if (magnitude.inMinutes < 60) {
      final minutes = magnitude.inMinutes;
      return phrase('$minutes min${minutes == 1 ? '' : 's'}');
    } else if (magnitude.inHours < 24) {
      final hours = magnitude.inHours;
      return phrase('$hours hour${hours == 1 ? '' : 's'}');
    } else if (magnitude.inDays == 1) {
      return isFuture ? 'tomorrow' : 'yesterday';
    } else if (magnitude.inDays < 30) {
      final days = magnitude.inDays;
      return phrase('$days day${days == 1 ? '' : 's'}');
    } else if (magnitude.inDays < 365) {
      // Use 30.44 (average days per month) for more accurate month rounding
      final months = (magnitude.inDays / 30.44).floor().clamp(1, 11);
      return phrase('$months month${months == 1 ? '' : 's'}');
    } else {
      // Use 365.25 to account for leap years
      final years = (magnitude.inDays / 365.25).floor();
      return phrase('$years year${years == 1 ? '' : 's'}');
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

  /// Returns `true` if this DateTime falls between [start] and [end] (inclusive).
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2024, 6, 15);
  /// date.isBetween(DateTime(2024, 1, 1), DateTime(2024, 12, 31)) // true
  /// ```
  bool isBetween(DateTime start, DateTime end) {
    return !isBefore(start) && !isAfter(end);
  }

  /// Returns a new DateTime set to midnight (00:00:00.000) on the same day.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 6, 15, 14, 30).startOfDay // 2024-06-15 00:00:00.000
  /// ```
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a new DateTime set to 23:59:59.999 on the same day.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 6, 15, 14, 30).endOfDay // 2024-06-15 23:59:59.999
  /// ```
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Returns a new DateTime set to midnight on the most recent Monday.
  ///
  /// If this date is already a Monday, returns midnight of that day.
  ///
  /// Example:
  /// ```dart
  /// DateTime(2024, 6, 19).startOfWeek // 2024-06-17 (Monday)
  /// ```
  DateTime get startOfWeek {
    final daysFromMonday = weekday - DateTime.monday;
    return DateTime(year, month, day - daysFromMonday);
  }
}
