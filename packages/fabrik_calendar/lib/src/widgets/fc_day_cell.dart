import 'package:fabrik_calendar/src/models/fc_day_decoration.dart';
import 'package:flutter/material.dart';

/// A customizable calendar day cell widget used to display individual dates.
///
/// This widget supports rich customization like text style, background color,
/// gradients, borders, corner radius, and tap handling.
///
/// ### Defaults:
/// - `disableFutureDates`: `false`
/// - `margin`: `EdgeInsets.symmetric(vertical: 8, horizontal: 2)`
/// - `padding`: `EdgeInsets.all(2)`
/// - `borderRadius`: `BorderRadius.circular(8)`
/// - `disabledTextColor`: `Colors.grey`
class FCDayCell extends StatelessWidget {
  /// Creates an [FCDayCell] widget.
  const FCDayCell(
    this.date, {
    this.decoration,
    this.onTap,
    super.key,
  });

  /// The date this cell represents.
  final DateTime date;

  final FCDayDecoration? decoration;

  /// Callback triggered when the cell is tapped.
  final void Function(DateTime day)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(date, now);
    final isFuture = date.isAfter(now);
    final isDisabled = (decoration?.disableFutureDates ??
            defaultDecoration.disableFutureDates!) &&
        isFuture;

    // Determine effective text color based on state
    final effectiveTextColor = isToday
        ? decoration?.todayTextColor ?? decoration?.textColor
        : isDisabled
            ? decoration?.disabledTextColor ??
                defaultDecoration.disabledTextColor
            : decoration?.textColor;

    return InkWell(
      onTap: isDisabled || onTap == null ? null : () => onTap?.call(date),
      child: Container(
        alignment: Alignment.center,
        margin: decoration?.margin ?? defaultDecoration.margin,
        padding: decoration?.padding ?? defaultDecoration.padding,
        decoration: BoxDecoration(
          color: isDisabled
              ? decoration?.disabledBackgroundColor
              : isToday
                  ? (decoration?.todayBackgroundColor ??
                      decoration?.backgroundColor ??
                      theme.primaryColor)
                  : decoration?.backgroundColor,
          borderRadius: isToday
              ? (decoration?.todayBorderRadius ??
                  decoration?.borderRadius ??
                  defaultDecoration.borderRadius)
              : decoration?.borderRadius ?? defaultDecoration.borderRadius,
          border: isDisabled
              ? null
              : isToday
                  ? decoration?.todayBorder ?? decoration?.border
                  : decoration?.border,
          gradient: isToday ? decoration?.todayGradient : null,
        ),
        child: Text(
          '${date.day}',
          style: (isToday
                  ? decoration?.todayTextStyle ?? decoration?.textStyle
                  : decoration?.textStyle) ??
              TextStyle(
                color: effectiveTextColor,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }
}

final defaultDecoration = FCDayDecoration(
  disableFutureDates: false,
  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
  padding: const EdgeInsets.all(2),
  borderRadius: BorderRadius.circular(8),
  disabledTextColor: Colors.grey,
);
