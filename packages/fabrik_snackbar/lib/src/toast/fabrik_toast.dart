import 'package:flutter/material.dart';
import 'fabrik_toast_config.dart';
import 'fabrik_toast_widget.dart';

/// Utility class to show simple floating toasts anywhere in the app.
class FabrikToast {
  FabrikToast._();

  /// Shows a toast message on top of the current overlay.
  ///
  /// The [message] is required. Other options control the appearance
  /// and position of the toast.
  ///
  /// - [context] is required to access the overlay.
  /// - [duration] controls how long the toast remains visible.
  /// - [position] defines the vertical alignment.
  /// - [backgroundColor], [textColor], and [fontSize] control style.
  /// - [onTap] is an optional callback when toast is tapped.
  static Future<void> show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    FabrikToastPosition position = FabrikToastPosition.bottom,
    Color backgroundColor = const Color(0xFF323232),
    Color textColor = Colors.white,
    double fontSize = 14.0,
    VoidCallback? onTap,
  }) async {
    final overlay = Overlay.of(context, rootOverlay: true);
    if (!overlay.mounted) {
      debugPrint('No overlay found for FabrikToast.');
      return;
    }

    final config = FabrikToastConfig(
      message: message,
      duration: duration,
      position: position,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
      onTap: onTap,
    );

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder:
          (_) => FabrikToastWidget(
            config: config,
            onDismissed: () => entry.remove(),
          ),
    );

    overlay.insert(entry);
  }
}
