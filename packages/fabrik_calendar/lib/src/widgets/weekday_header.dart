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
    return Row(
      children: weekdays.list
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
