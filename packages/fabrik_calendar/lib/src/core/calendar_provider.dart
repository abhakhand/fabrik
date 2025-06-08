import 'package:flutter/material.dart';

class CalendarProvider extends InheritedWidget {
  const CalendarProvider({
    super.key,
    required super.child,
    required this.streakDates,
    required this.freezeDates,
    required this.todayColor,
    this.onDayTap,
  });

  final List<DateTime> streakDates;
  final List<DateTime> freezeDates;
  final Color todayColor;
  final void Function(DateTime)? onDayTap;

  static CalendarProvider of(BuildContext context) {
    final CalendarProvider? result =
        context.dependOnInheritedWidgetOfExactType<CalendarProvider>();
    assert(result != null, 'No CalendarProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CalendarProvider oldWidget) =>
      streakDates != oldWidget.streakDates ||
      freezeDates != oldWidget.freezeDates ||
      todayColor != oldWidget.todayColor;
}
