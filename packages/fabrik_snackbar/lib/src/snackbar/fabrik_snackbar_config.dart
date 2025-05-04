import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_helpers.dart';
import 'package:flutter/material.dart';

/// Configuration for displaying a [FabrikSnackbar].
///
/// This class allows you to customize the appearance, behavior,
/// and layout of a snackbar including its position, content,
/// styling, and dismissal behavior.
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

  /// Title text as a simple [String].
  final String? title;

  /// Message text as a simple [String].
  final String? message;

  /// Custom widget for title. Overrides [title] if provided.
  final Widget? titleText;

  /// Custom widget for message. Overrides [message] if provided.
  final Widget? messageText;

  /// Optional leading icon shown before title/message.
  final Widget? icon;

  /// Optional action button (e.g. a [TextButton]) shown at the end.
  final Widget? actionButton;

  /// How long the snackbar stays visible before auto-dismiss.
  final Duration duration;

  /// Background color of the snackbar (used if no [backgroundGradient] is provided).
  final Color backgroundColor;

  /// Optional background gradient (overrides [backgroundColor] if set).
  final Gradient? backgroundGradient;

  /// Corner radius of the snackbar (used when [style] is [FabrikSnackbarStyle.floating]).
  final BorderRadius borderRadius;

  /// Outer margin around the snackbar.
  final EdgeInsets margin;

  /// Inner padding within the snackbar container.
  final EdgeInsets padding;

  /// Maximum width of the snackbar (especially useful for larger screens).
  final double? maxWidth;

  /// Whether to display the snackbar at the top or bottom of the screen.
  final FabrikSnackbarPosition position;

  /// Snackbar layout style — floating or grounded.
  final FabrikSnackbarStyle style;

  /// Direction in which the snackbar can be dismissed.
  final FabrikSnackbarDismissDirection dismissDirection;

  /// Whether to respect [SafeArea] paddings (e.g. avoid notches).
  final bool safeArea;

  /// Whether to show a progress indicator below the message.
  final bool showProgressIndicator;

  /// Color of the progress indicator (if shown).
  final Color? progressIndicatorColor;

  /// Amount of background blur to apply behind the snackbar.
  /// Set to 0 to disable blur.
  final double barrierBlur;

  /// Background color behind the snackbar if [blockBackgroundInteraction] is true.
  final Color? barrierColor;

  /// Whether to block user interaction with background widgets.
  final bool blockBackgroundInteraction;

  /// Callback invoked when the snackbar is tapped.
  final VoidCallback? onTap;

  /// Callback invoked when the snackbar is dismissed.
  final VoidCallback? onDismissed;
}
