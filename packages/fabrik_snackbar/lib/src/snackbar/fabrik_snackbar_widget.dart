import 'dart:async';
import 'dart:ui';

import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_defaults.dart';
import 'package:flutter/material.dart';
import 'fabrik_snackbar_config.dart';

/// Internal widget used by [FabrikSnackbar] to render the snackbar UI.
///
/// Handles animation, positioning, dismiss behavior, and styling.
class FabrikSnackbarWidget extends StatefulWidget {
  const FabrikSnackbarWidget({
    super.key,
    required this.config,
    required this.onDismissed,
  });

  /// The configuration for how the snackbar should appear.
  final FabrikSnackbarConfig config;

  /// Callback triggered when the snackbar is fully dismissed.
  final VoidCallback onDismissed;

  @override
  State<FabrikSnackbarWidget> createState() => _FabrikSnackbarWidgetState();
}

class _FabrikSnackbarWidgetState extends State<FabrikSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  Timer? _dismissTimer;

  /// Determines the maxWidth based on config or screen width.
  double _resolveMaxWidth(BuildContext context) {
    return widget.config.maxWidth ??
        (MediaQuery.of(context).size.width > 600
            ? FabrikSnackbarDefaults.defaultMaxWidth
            : double.infinity);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final beginOffset =
        widget.config.position.isTop ? const Offset(0, -1) : const Offset(0, 1);

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    _controller.forward();
    _startAutoDismissTimer();
  }

  /// Starts the timer for auto-dismissal.
  void _startAutoDismissTimer() {
    _dismissTimer = Timer(widget.config.duration, _dismiss);
  }

  /// Dismisses the snackbar with animation.
  void _dismiss() {
    _controller.reverse().then((_) {
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget snackbarContent = FabrikSnackbarContent(
      onTap: widget.config.onTap,
      child: FabrikSnackbarRow(config: widget.config),
    );

    // If interaction is blocked, wrap content with blur/barrier.
    if (widget.config.blockBackgroundInteraction) {
      snackbarContent = Stack(
        children: [
          if (widget.config.barrierBlur > 0 ||
              widget.config.barrierColor != null)
            Positioned.fill(
              child: FabrikSnackbarBackgroundBlur(
                blur: widget.config.barrierBlur,
                color: widget.config.barrierColor,
              ),
            ),
          snackbarContent,
        ],
      );
    }

    return SafeArea(
      top: widget.config.safeArea && widget.config.position.isTop,
      bottom: widget.config.safeArea && widget.config.position.isBottom,
      child: Align(
        alignment:
            widget.config.position.isTop
                ? Alignment.topCenter
                : Alignment.bottomCenter,
        child: SlideTransition(
          position: _slideAnimation,
          child: Dismissible(
            key: const Key('fabrik_snackbar_dismissible'),
            direction:
                widget.config.dismissDirection.isHorizontal
                    ? DismissDirection.horizontal
                    : widget.config.position.isTop
                    ? DismissDirection.up
                    : DismissDirection.down,
            onDismissed: (_) => _dismiss(),
            child: Material(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: _resolveMaxWidth(context),
                ),
                margin:
                    widget.config.style.isFloating
                        ? widget.config.margin
                        : EdgeInsets.zero,
                padding: widget.config.padding,
                decoration: BoxDecoration(
                  color:
                      widget.config.backgroundGradient == null
                          ? widget.config.backgroundColor
                          : null,
                  gradient: widget.config.backgroundGradient,
                  borderRadius:
                      widget.config.style.isFloating
                          ? widget.config.borderRadius
                          : BorderRadius.zero,
                ),
                child: FabrikSnackbarRow(config: widget.config),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Optional background blur used when blocking interactions.
class FabrikSnackbarBackgroundBlur extends StatelessWidget {
  const FabrikSnackbarBackgroundBlur({
    super.key,
    required this.blur,
    required this.color,
  });

  final double blur;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(color: color ?? Colors.black.withAlpha(80)),
    );
  }
}

/// Makes the entire snackbar content tappable.
class FabrikSnackbarContent extends StatelessWidget {
  const FabrikSnackbarContent({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: child);
  }
}

/// Main layout row of the snackbar containing icon, content, and action.
class FabrikSnackbarRow extends StatelessWidget {
  const FabrikSnackbarRow({super.key, required this.config});

  final FabrikSnackbarConfig config;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (config.icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: config.icon!,
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 2,
            children: [
              if (config.titleText != null)
                config.titleText!
              else if (config.title != null)
                Text(
                  config.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              if (config.messageText != null)
                config.messageText!
              else if (config.message != null)
                Text(
                  config.message!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
            ],
          ),
        ),
        if (config.actionButton != null) ...[
          const SizedBox(width: 8.0),
          config.actionButton!,
        ],
      ],
    );
  }
}
