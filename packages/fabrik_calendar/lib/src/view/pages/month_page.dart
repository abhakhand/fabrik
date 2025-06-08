import 'package:fabrik_calendar/src/model/calender_day.dart';
import 'package:fabrik_calendar/src/provider/calendar_provider.dart';
import 'package:fabrik_calendar/src/view/widgets/default_cell.dart';
import 'package:flutter/material.dart';

class MonthPage extends StatelessWidget {
  const MonthPage({
    super.key,
    required this.month,
    this.cellBuilder,
    this.startWeekWithSunday = false,
    required this.disableFutureDates,
  });

  final DateTime month;
  final Widget Function(CalendarDay)? cellBuilder;
  final bool startWeekWithSunday;
  final bool disableFutureDates;

  @override
  Widget build(BuildContext context) {
    final provider = CalendarProvider.of(context);
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    final days = <CalendarDay>[];
    final today = DateTime.now();

    int startOffset =
        startWeekWithSunday ? (firstWeekday % 7) : (firstWeekday - 1);

    for (int i = 0; i < startOffset; i++) {
      days.add(CalendarDay(date: DateTime(0), isPlaceholder: true));
    }

    for (int i = 0; i < daysInMonth; i++) {
      final day = DateTime(month.year, month.month, i + 1);

      final isStreak =
          provider.streakDates.any((d) => DateUtils.isSameDay(d, day));
      final isFreeze =
          provider.freezeDates.any((d) => DateUtils.isSameDay(d, day));

      final isToday = DateUtils.isSameDay(day, today);
      final isDisabled = disableFutureDates && day.isAfter(today);

      days.add(
        CalendarDay(
          date: day,
          isStreak: isStreak,
          isFreeze: isFreeze,
          isToday: isToday,
          isDisabled: isDisabled,
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (context, index) {
        final day = days[index];
        final previousDay = index > 0 ? days[index - 1] : null;
        final nextDay = index < days.length - 1 ? days[index + 1] : null;

        if (day.isPlaceholder) return const SizedBox();

        return GestureDetector(
          onTap:
              day.isDisabled ? null : () => provider.onDayTap?.call(day.date),
          child: cellBuilder?.call(day) ??
              DefaultCell(
                day: day,
                previousDay: previousDay,
                nextDay: nextDay,
                todayColor: provider.todayColor,
              ),
        );
      },
    );
  }
}
