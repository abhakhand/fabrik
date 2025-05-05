import 'dart:async';
import 'package:flutter/material.dart';
import 'fabrik_toast_config.dart';

/// Internal widget that renders the toast UI and handles animation.
class FabrikToastWidget extends StatefulWidget {
  const FabrikToastWidget({
    super.key,
    required this.config,
    required this.onDismissed,
  });

  /// Configuration for appearance and behavior.
  final FabrikToastConfig config;

  /// Callback fired after toast is fully dismissed.
  final VoidCallback onDismissed;

  @override
  State<FabrikToastWidget> createState() => _FabrikToastWidgetState();
}

class _FabrikToastWidgetState extends State<FabrikToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
    _startDismissTimer();
  }

  void _startDismissTimer() {
    _dismissTimer = Timer(widget.config.duration, _dismiss);
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onDismissed());
  }

  @override
  void dispose() {
    _controller.dispose();
    _dismissTimer?.cancel();
    super.dispose();
  }

  /// Maps toast position to alignment.
  Alignment _getAlignment() => switch (widget.config.position) {
    FabrikToastPosition.top => Alignment.topCenter,
    FabrikToastPosition.center => Alignment.center,
    FabrikToastPosition.bottom => Alignment.bottomCenter,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: _getAlignment(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: GestureDetector(
              onTap: widget.config.onTap,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.config.backgroundColor,
                    borderRadius: widget.config.borderRadius,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8,
                    children: [
                      if (widget.config.icon != null)
                        Icon(
                          widget.config.icon,
                          color: widget.config.iconColor,
                          size: widget.config.iconSize,
                        ),
                      Text(
                        widget.config.message,
                        style: TextStyle(
                          color: widget.config.textColor,
                          fontSize: widget.config.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
