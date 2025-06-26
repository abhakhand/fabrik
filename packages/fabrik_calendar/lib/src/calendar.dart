import 'package:fabrik_calendar/src/models/fc_day.dart';
import 'package:fabrik_calendar/src/models/fc_day_decoration.dart';
import 'package:fabrik_calendar/src/models/weekdays.dart';
import 'package:fabrik_calendar/src/widgets/fc_day_cell.dart';
import 'package:fabrik_calendar/src/widgets/month_view.dart';
import 'package:fabrik_calendar/src/widgets/month_header.dart';
import 'package:fabrik_calendar/src/widgets/weekday_header.dart';
import 'package:flutter/material.dart';

class BoundedScrollPhysics extends ScrollPhysics {
  const BoundedScrollPhysics({
    required this.startPage,
    required this.endPage,
    required this.currentPage,
    super.parent,
  });

  final int startPage;
  final int endPage;
  final int currentPage;

  @override
  BoundedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BoundedScrollPhysics(
      startPage: startPage,
      endPage: endPage,
      currentPage: currentPage,
      parent: buildParent(ancestor),
    );
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    final page = currentPage;
    final direction = position.pixels - position.minScrollExtent;

    // Allow scrolling if we're not at the boundaries
    if (page > startPage && page < endPage) return true;

    // At start boundary, only allow forward scrolling
    if (page == startPage && direction > 0) return true;

    // At end boundary, only allow backward scrolling
    if (page == endPage && direction < 0) return true;

    return false;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    final page = currentPage;

    // Prevent scrolling past start boundary
    if (page == startPage && value < position.pixels) {
      return position.pixels - value;
    }

    // Prevent scrolling past end boundary
    if (page == endPage && value > position.pixels) {
      return position.pixels - value;
    }

    return 0.0;
  }
}

class FabrikCalendar extends StatefulWidget {
  const FabrikCalendar({
    super.key,
    this.disableFutureDates = false,
    this.currentDate,
    this.startDate,
    this.endDate,
    this.onDayTap,
    this.cellBuilder,
    this.customWeekdayLabels,
    this.startWeekWithSunday = false,
    this.decoration,
  });

  final bool disableFutureDates;
  final DateTime? currentDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTime)? onDayTap;
  final Widget Function(FCDay day)? cellBuilder;
  final FCDayDecoration? decoration;
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
  late int _startPage;
  late int _endPage;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.currentDate ?? DateTime.now();
    _initialPage = _toPageIndex(_currentDate);
    _currentPage = _initialPage;

    _startPage = widget.startDate != null
        ? _toPageIndex(widget.startDate!)
        : _initialPage - 120;
    _endPage = widget.endDate != null
        ? _toPageIndex(widget.endDate!)
        : _initialPage + 120;

    _pageController = PageController(
      initialPage: _initialPage - _startPage,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _toPageIndex(DateTime date) => date.year * 12 + date.month - 1;

  DateTime _fromPageIndex(int index) {
    final year = index ~/ 12;
    final month = (index % 12) + 1;
    return DateTime(year, month, 1);
  }

  bool get _canGoBack => _currentPage > _startPage;
  bool get _canGoForward => _currentPage < _endPage;

  void _goToToday() {
    final todayIndex = _toPageIndex(_currentDate);
    if (todayIndex >= _startPage && todayIndex <= _endPage) {
      _pageController.animateToPage(
        todayIndex - _startPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousMonth() {
    if (_canGoBack && _pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextMonth() {
    if (_canGoForward && _pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MonthHeader(
          currentPage: _currentPage,
          disableFutureDates: widget.disableFutureDates,
          onPrevious: _canGoBack ? _previousMonth : null,
          onNext: _canGoForward ? _nextMonth : null,
          goToToday: _goToToday,
        ),
        const SizedBox(height: 12),
        WeekdayHeader(
          customWeekdayLabels: widget.customWeekdayLabels,
          startWeekWithSunday: widget.startWeekWithSunday,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: BoundedScrollPhysics(
              startPage: _startPage,
              endPage: _endPage,
              currentPage: _currentPage,
              parent: const AlwaysScrollableScrollPhysics(),
            ),
            onPageChanged: (page) {
              setState(() {
                _currentPage = page + _startPage;
              });
            },
            itemCount: _endPage - _startPage + 1,
            itemBuilder: (context, index) {
              final month = _fromPageIndex(index + _startPage);
              return MonthView(
                month: month,
                cellBuilder: widget.cellBuilder ??
                    (day) => FCDayCell(
                          day.date,
                          decoration: widget.decoration,
                          onTap: widget.onDayTap,
                        ),
                startWeekWithSunday: widget.startWeekWithSunday,
              );
            },
          ),
        ),
      ],
    );
  }
}
