import 'package:fabrik_calendar/src/model/calender_day.dart';
import 'package:fabrik_calendar/src/model/weekdays.dart';
import 'package:fabrik_calendar/src/core/calendar_provider.dart';
import 'package:fabrik_calendar/src/widgets/month_view.dart';
import 'package:fabrik_calendar/src/widgets/month_header.dart';
import 'package:fabrik_calendar/src/widgets/weekday_header.dart';
import 'package:flutter/material.dart';

class FabrikCalendar extends StatefulWidget {
  const FabrikCalendar({
    super.key,
    this.streakDates = const [],
    this.freezeDates = const [],
    this.disableFutureDates = false,
    this.initialDate,
    this.todayColor = Colors.blue,
    this.onDayTap,
    this.cellBuilder,
    this.customWeekdayLabels,
    this.startWeekWithSunday = false,
  });

  final List<DateTime> streakDates;
  final List<DateTime> freezeDates;
  final bool disableFutureDates;
  final DateTime? initialDate;
  final Color todayColor;
  final void Function(DateTime)? onDayTap;
  final Widget Function(CalendarDay)? cellBuilder;
  final Weekdays? customWeekdayLabels;
  final bool startWeekWithSunday;

  @override
  State<FabrikCalendar> createState() => _FabrikCalendarState();
}

class _FabrikCalendarState extends State<FabrikCalendar> {
  late PageController _pageController;
  late DateTime _currentDate;
  late int _initialPage;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _initialPage = _currentDate.year * 12 + _currentDate.month - 1;
    _currentPage = _initialPage;
    _pageController = PageController(initialPage: _initialPage);
  }

  void _goToToday() {
    _pageController.animateToPage(
      _initialPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousMonth() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextMonth() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CalendarProvider(
      streakDates: widget.streakDates,
      freezeDates: widget.freezeDates,
      todayColor: widget.todayColor,
      onDayTap: widget.onDayTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthHeader(
            currentPage: _currentPage,
            disableFutureDates: widget.disableFutureDates,
            onPrevious: _previousMonth,
            onNext: _nextMonth,
            goToToday: _goToToday,
          ),
          const SizedBox(height: 8),
          WeekdayHeader(
            customWeekdayLabels: widget.customWeekdayLabels,
            startWeekWithSunday: widget.startWeekWithSunday,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final date = DateTime(index ~/ 12, (index % 12) + 1, 1);
                return MonthView(
                  month: date,
                  cellBuilder: widget.cellBuilder,
                  startWeekWithSunday: widget.startWeekWithSunday,
                  disableFutureDates: widget.disableFutureDates,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
