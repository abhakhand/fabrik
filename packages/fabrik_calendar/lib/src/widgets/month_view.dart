import 'package:fabrik_calendar/src/models/fc_day.dart';
import 'package:flutter/material.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    super.key,
    required this.month,
    this.cellBuilder,
    this.startWeekWithSunday = false,
    required this.disableFutureDates,
  });

  final DateTime month;
  final Widget Function(FCDay day)? cellBuilder;
  final bool startWeekWithSunday;
  final bool disableFutureDates;

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    final days = <FCDay>[];

    int startOffset =
        startWeekWithSunday ? (firstWeekday % 7) : (firstWeekday - 1);

    for (int i = 0; i < startOffset; i++) {
      days.add(FCDay(date: DateTime(0), isPlaceholder: true));
    }

    for (int i = 0; i < daysInMonth; i++) {
      final day = DateTime(month.year, month.month, i + 1);

      days.add(FCDay(date: day));
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: days.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemBuilder: (context, index) {
        final day = days[index];

        if (day.isPlaceholder) return const SizedBox();

        return cellBuilder?.call(day);
      },
    );
  }
}
