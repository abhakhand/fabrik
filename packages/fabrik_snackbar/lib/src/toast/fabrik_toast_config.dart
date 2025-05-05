import 'package:flutter/material.dart';

/// Configuration class for showing a [FabrikToast].
///
/// Provides basic customization for appearance, duration, and placement.
class FabrikToastConfig {
  const FabrikToastConfig({
    required this.message,
    this.position = FabrikToastPosition.bottom,
    this.duration = const Duration(seconds: 2),
    this.backgroundColor = const Color(0xFF323232),
    this.borderRadius = const BorderRadius.all(Radius.circular(100)),
    this.textColor = Colors.white,
    this.fontSize = 14.0,
    this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 24.0,
    this.onTap,
  });

  /// The text shown in the toast.
  final String message;

  /// Vertical placement of the toast on screen.
  final FabrikToastPosition position;

  /// Duration the toast remains visible before auto-dismissal.
  final Duration duration;

  /// Background color of the toast container.
  final Color backgroundColor;

  /// Border radius of the toast container.
  final BorderRadius borderRadius;

  /// Text color used for the message.
  final Color textColor;

  /// Font size of the message text.
  final double fontSize;

  /// Optional icon displayed alongside the message.
  final IconData? icon;

  /// Color of the icon.
  final Color iconColor;

  /// Size of the icon.
  final double iconSize;

  /// Optional tap handler when the toast is tapped.
  final VoidCallback? onTap;
}

/// Enum for controlling vertical placement of the toast.
enum FabrikToastPosition {
  /// Displays the toast near the top of the screen.
  top,

  /// Displays the toast in the vertical center of the screen.
  center,

  /// Displays the toast near the bottom of the screen.
  bottom;

  /// Returns true if the position is [FabrikToastPosition.top].
  bool get isTop => this == FabrikToastPosition.top;

  /// Returns true if the position is [FabrikToastPosition.center].
  bool get isCenter => this == FabrikToastPosition.center;

  /// Returns true if the position is [FabrikToastPosition.bottom].
  bool get isBottom => this == FabrikToastPosition.bottom;
}
