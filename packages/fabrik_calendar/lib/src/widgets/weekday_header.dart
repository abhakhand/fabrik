import 'package:fabrik_calendar/src/models/weekdays.dart';
import 'package:flutter/material.dart';

class WeekdayHeader extends StatelessWidget {
  final Weekdays? customWeekdayLabels;
  final bool startWeekWithSunday;

  const WeekdayHeader({
    super.key,
    this.customWeekdayLabels,
    this.startWeekWithSunday = false,
  });

  @override
  Widget build(BuildContext context) {
    final weekdays = customWeekdayLabels ?? const Weekdays();
    final weekdayList = startWeekWithSunday
        ? [...weekdays.list.skip(6), ...weekdays.list.take(6)] // Sunday first
        : weekdays.list; // Monday first

    return Row(
      children: weekdayList
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
