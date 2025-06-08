import 'package:fabrik_calendar/src/core/helpers.dart';
import 'package:fabrik_calendar/src/model/calender_day.dart';
import 'package:flutter/material.dart';

class DefaultCell extends StatelessWidget {
  final CalendarDay day;
  final CalendarDay? previousDay;
  final CalendarDay? nextDay;
  final Color? todayColor;

  const DefaultCell({
    super.key,
    required this.day,
    this.previousDay,
    this.nextDay,
    this.todayColor,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = isSameDay(day.date, DateTime.now());

    final isPartOfStreak = day.isStreak;
    final isPreviousPartOfStreak = previousDay?.isStreak ?? false;
    final isNextPartOfStreak = nextDay?.isStreak ?? false;

    BorderRadius borderRadius = BorderRadius.circular(16);

    if (isPartOfStreak) {
      if (isPreviousPartOfStreak && isNextPartOfStreak) {
        borderRadius = BorderRadius.zero;
      } else if (isPreviousPartOfStreak && !isNextPartOfStreak) {
        borderRadius = const BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(100),
        );
      } else if (!isPreviousPartOfStreak && isNextPartOfStreak) {
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(100),
          bottomLeft: Radius.circular(100),
        );
      }
    }

    Color backgroundColor = Colors.transparent;
    if (day.isFreeze) {
      backgroundColor = const Color.fromARGB(255, 225, 246, 255);
    } else if (day.isStreak) {
      backgroundColor = Colors.orange.shade400;
    }

    final isStreakBreak = !(isPreviousPartOfStreak && isPartOfStreak) &&
        !(isPartOfStreak && isNextPartOfStreak);
    final margin = day.isStreak
        ? (isStreakBreak
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 2)
            : const EdgeInsets.symmetric(vertical: 8))
        : const EdgeInsets.symmetric(vertical: 8, horizontal: 2);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: isToday ? todayColor ?? Colors.blue : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          '${day.date.day}',
          style: TextStyle(
            color: isToday
                ? todayColor ?? Colors.blue
                : day.isDisabled
                    ? Colors.grey
                    : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
