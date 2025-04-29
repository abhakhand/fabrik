import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_helpers.dart';
import 'package:flutter/material.dart';

/// Defines the configuration for a [FabrikSnackbar].
class FabrikSnackbarConfig {
  const FabrikSnackbarConfig({
    this.title,
    this.message,
    this.titleText,
    this.messageText,
    this.icon,
    this.actionButton,
    this.duration = const Duration(seconds: 3),
    this.backgroundColor = const Color(0xFF323232),
    this.backgroundGradient,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.maxWidth,
    this.position = FabrikSnackbarPosition.bottom,
    this.style = FabrikSnackbarStyle.floating,
    this.dismissDirection = FabrikSnackbarDismissDirection.vertical,
    this.safeArea = true,
    this.showProgressIndicator = false,
    this.progressIndicatorColor,
    this.barrierBlur = 0.0,
    this.barrierColor,
    this.blockBackgroundInteraction = false,
    this.onTap,
    this.onDismissed,
  });

  /// Title as simple String
  final String? title;

  /// Message as simple String
  final String? message;

  /// Alternative to [title] to allow rich text
  final Widget? titleText;

  /// Alternative to [message] to allow rich text
  final Widget? messageText;

  /// Optional leading icon
  final Widget? icon;

  /// Optional action button (eg. TextButton)
  final Widget? actionButton;

  /// How long the snackbar stays visible
  final Duration duration;

  /// Background color if no gradient is used
  final Color backgroundColor;

  /// Optional background gradient
  final Gradient? backgroundGradient;

  /// Corner radius
  final BorderRadius borderRadius;

  /// Margin around the snackbar
  final EdgeInsets margin;

  /// Padding inside the snackbar
  final EdgeInsets padding;

  /// Max width (for web, tablet, desktop)
  final double? maxWidth;

  /// Whether the snackbar shows at the top or bottom
  final FabrikSnackbarPosition position;

  /// Floating (default) or Grounded to edge
  final FabrikSnackbarStyle style;

  /// How the snackbar can be dismissed
  final FabrikSnackbarDismissDirection dismissDirection;

  /// Whether to respect SafeArea paddings
  final bool safeArea;

  /// Shows a linear progress indicator if true
  final bool showProgressIndicator;

  /// Progress indicator color
  final Color? progressIndicatorColor;

  /// If > 0, blurs the background behind the snackbar
  final double barrierBlur;

  /// Background color behind snackbar if [blockBackgroundInteraction] is true
  final Color? barrierColor;

  /// If true, blocks background taps
  final bool blockBackgroundInteraction;

  /// Called when snackbar is tapped
  final VoidCallback? onTap;

  /// Called when snackbar is dismissed
  final VoidCallback? onDismissed;
}
