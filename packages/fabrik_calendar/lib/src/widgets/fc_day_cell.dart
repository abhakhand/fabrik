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
    this.margin,
    this.padding,
    this.disableFutureDates = false,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.todayBackgroundColor,
    this.textColor,
    this.todayTextColor,
    this.textStyle,
    this.todayTextStyle,
    this.borderRadius,
    this.todayBorderRadius,
    this.border,
    this.todayBorder,
    this.todayGradient,
    this.onTap,
    super.key,
  });

  /// The date this cell represents.
  final DateTime date;

  /// Margin around the cell.  
  /// Default: `EdgeInsets.symmetric(vertical: 8, horizontal: 2)`
  final EdgeInsetsGeometry? margin;

  /// Padding inside the cell.  
  /// Default: `EdgeInsets.all(2)`
  final EdgeInsetsGeometry? padding;

  /// Whether to disable future dates.  
  /// If `true`, future dates will appear disabled and not respond to taps.  
  /// Default: `false`
  final bool disableFutureDates;

  /// Background color when the cell is disabled (e.g., for future dates).
  final Color? disabledBackgroundColor;

  /// Text color for disabled cells.  
  /// Default: `Colors.grey`
  final Color? disabledTextColor;

  /// Background color of the cell for normal days.
  final Color? backgroundColor;

  /// Background color of the cell when the date is today.
  final Color? todayBackgroundColor;

  /// Text color for normal dates.
  final Color? textColor;

  /// Text color when the date is today.
  final Color? todayTextColor;

  /// Custom text style for the day number.
  final TextStyle? textStyle;

  /// Custom text style for the day number when it is today.
  final TextStyle? todayTextStyle;

  /// Corner radius for normal dates.  
  /// Default: `BorderRadius.circular(8)`
  final BorderRadius? borderRadius;

  /// Corner radius when the cell represents today.
  final BorderRadius? todayBorderRadius;

  /// Border around the cell.
  final BoxBorder? border;

  /// Border when the cell represents today.
  final BoxBorder? todayBorder;

  /// Gradient background when the cell represents today.
  final Gradient? todayGradient;

  /// Callback triggered when the cell is tapped.
  final void Function(DateTime day)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(date, now);
    final isFuture = date.isAfter(now);
    final isDisabled = disableFutureDates && isFuture;

    // Determine effective text color based on state
    final effectiveTextColor = isToday
        ? todayTextColor ?? textColor
        : isDisabled
            ? disabledTextColor ?? Colors.grey
            : textColor;

    return InkWell(
      onTap: isDisabled ? null : () => onTap?.call(date),
      child: Container(
        alignment: Alignment.center,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: padding ?? const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isDisabled
              ? disabledBackgroundColor
              : isToday
                  ? todayBackgroundColor ??
                      backgroundColor ??
                      theme.primaryColor
                  : backgroundColor,
          borderRadius: isToday
              ? todayBorderRadius ?? borderRadius
              : borderRadius ?? BorderRadius.circular(8),
          border: isToday ? todayBorder ?? border : border,
          gradient: isToday ? todayGradient : null,
        ),
        child: Text(
          '${date.day}',
          style: (isToday ? todayTextStyle ?? textStyle : textStyle) ??
              TextStyle(
                color: effectiveTextColor,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
