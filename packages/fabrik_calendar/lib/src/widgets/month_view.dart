import 'package:fabrik_calendar/src/models/fc_day.dart';
import 'package:flutter/material.dart';

class MonthView extends StatelessWidget {
  const MonthView({
    super.key,
    required this.month,
    this.cellBuilder,
    this.startWeekWithSunday = false,
  });

  final DateTime month;
  final Widget Function(FCDay day)? cellBuilder;
  final bool startWeekWithSunday;

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    final days = <FCDay>[];

    int startOffset =
        startWeekWithSunday ? (firstWeekday % 7) : (firstWeekday - 1);

    // Fill placeholders for leading empty cells
    for (int i = 0; i < startOffset; i++) {
      days.add(FCDay(date: DateTime(0), isPlaceholder: true));
    }

    // Fill actual days
    for (int i = 0; i < daysInMonth; i++) {
      final day = DateTime(month.year, month.month, i + 1);
      days.add(FCDay(date: day));
    }

    // Fill trailing placeholders (to reach a multiple of 7 first)
    while (days.length % 7 != 0) {
      days.add(FCDay(date: DateTime(0), isPlaceholder: true));
    }

// Ensure total 42 cells (6 rows x 7 columns)
    while (days.length < 42) {
      days.add(FCDay(date: DateTime(0), isPlaceholder: true));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalHeight = constraints.maxHeight;
        final double totalWidth = constraints.maxWidth;

        const int rows = 6;
        const int columns = 7;

        final double cellHeight = totalHeight / rows;
        final double cellWidth = totalWidth / columns;

        return Column(
          children: List.generate(rows, (rowIndex) {
            return Row(
              children: List.generate(columns, (colIndex) {
                final int dayIndex = rowIndex * columns + colIndex;
                final FCDay day = days[dayIndex];

                return SizedBox(
                  width: cellWidth,
                  height: cellHeight,
                  child: day.isPlaceholder
                      ? const SizedBox()
                      : cellBuilder?.call(day),
                );
              }),
            );
          }),
        );
      },
    );
  }
}
