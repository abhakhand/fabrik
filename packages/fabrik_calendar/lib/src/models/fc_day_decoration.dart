import 'package:flutter/material.dart';

class FCDayDecoration {
  const FCDayDecoration({
    this.margin,
    this.padding,
    this.disableFutureDates,
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
  });

  /// Margin around the cell.
  final EdgeInsetsGeometry? margin;

  /// Padding inside the cell.
  final EdgeInsetsGeometry? padding;

  /// Whether to disable future dates.
  final bool? disableFutureDates;

  /// Background color when the cell is disabled (e.g., for future dates).
  final Color? disabledBackgroundColor;

  /// Text color for disabled cells.
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
  final BorderRadius? borderRadius;

  /// Corner radius when the cell represents today.
  final BorderRadius? todayBorderRadius;

  /// Border around the cell.
  final BoxBorder? border;

  /// Border when the cell represents today.
  final BoxBorder? todayBorder;

  /// Gradient background when the cell represents today.
  final Gradient? todayGradient;
}
