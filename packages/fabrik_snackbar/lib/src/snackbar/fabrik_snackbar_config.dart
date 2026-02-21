import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_helpers.dart';
import 'package:flutter/material.dart';

/// Configuration for displaying a [FabrikSnackbar].
///
/// This class allows you to customize the appearance, behavior, and layout of
/// a snackbar including its position, content, styling, and dismissal behavior.
///
/// **Content fields and render priority:**
///
/// There are three ways to provide title and message content, each with a
/// different priority. For the title slot: [richTitle] > [titleText] > [title].
/// For the message slot: [richMessage] > [messageText] > [message].
///
/// - [title] / [message] — plain [String] content.
/// - [titleText] / [messageText] — a fully custom [Widget], taking priority
///   over the plain string equivalents.
/// - [richTitle] / [richMessage] — an [InlineSpan] for styled text, taking the
///   highest priority. Mutually exclusive with [title] / [message] respectively
///   (enforced via constructor assertions).
///
/// At least one content field should be populated when using [FabrikSnackbar.custom].
/// The named constructors ([FabrikSnackbar.success], etc.) enforce this via
/// [FabrikSnackbar._validateContent].
class FabrikSnackbarConfig {
  const FabrikSnackbarConfig({
    this.title,
    this.message,
    this.titleText,
    this.messageText,
    this.richTitle,
    this.richMessage,
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
  })  : assert(
          title == null || richTitle == null,
          'Provide either title or richTitle, not both.',
        ),
        assert(
          message == null || richMessage == null,
          'Provide either message or richMessage, not both.',
        );

  /// Title text as a simple [String].
  final String? title;

  /// Message text as a simple [String].
  final String? message;

  /// Custom [Widget] rendered as the title.
  /// Takes priority over [title] but is itself overridden by [richTitle].
  final Widget? titleText;

  /// Custom [Widget] rendered as the message.
  /// Takes priority over [message] but is itself overridden by [richMessage].
  final Widget? messageText;

  /// Rich text content for title. Takes precedence over [title] and [titleText] if provided.
  final InlineSpan? richTitle;

  /// Rich text content for message. Takes precedence over [message] and [messageText] if provided.
  final InlineSpan? richMessage;

  /// Optional leading icon shown before title/message.
  final Widget? icon;

  /// Optional action button (e.g., a [TextButton]) shown at the end.
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

  /// Snackbar layout style: floating or grounded.
  final FabrikSnackbarStyle style;

  /// Direction in which the snackbar can be dismissed.
  final FabrikSnackbarDismissDirection dismissDirection;

  /// Whether to respect [SafeArea] paddings (e.g., avoid notches).
  final bool safeArea;

  /// Whether to show a progress indicator below the message.
  final bool showProgressIndicator;

  /// Color of the progress indicator (if shown).
  final Color? progressIndicatorColor;

  /// Blur sigma applied to the full-screen barrier when
  /// [blockBackgroundInteraction] is true. Set to `0.0` (default) for no blur.
  final double barrierBlur;

  /// Tint color of the full-screen barrier when [blockBackgroundInteraction]
  /// is true. Defaults to a semi-transparent black when [barrierBlur] is also
  /// non-zero; has no visual effect if both are at their defaults.
  final Color? barrierColor;

  /// Whether to block user interaction with widgets behind the snackbar.
  /// When `true`, a full-screen overlay is inserted beneath the snackbar that
  /// absorbs all touch events. Use [barrierBlur] and [barrierColor] to
  /// optionally add a visual dimming or blur effect.
  final bool blockBackgroundInteraction;

  /// Callback invoked when the snackbar is tapped.
  final VoidCallback? onTap;

  /// Callback invoked when the snackbar is dismissed.
  final VoidCallback? onDismissed;
}
