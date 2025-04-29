import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'fabrik_snackbar_config.dart';
import 'fabrik_snackbar_helpers.dart';
import 'fabrik_snackbar_defaults.dart';

class FabrikSnackbar {
  FabrikSnackbar._();

  /// Show a success snackbar
  static Future<void> success(
    BuildContext context, {
    required String title,
    required String message,
    int? durationInSeconds,
    FabrikSnackbarPosition? position,
    FabrikSnackbarDismissDirection? dismissDirection,
    double? maxWidth,
    Widget? actionButton,
    bool? safeArea,
    bool? showProgressIndicator,
    double? barrierBlur,
    Color? barrierColor,
  }) async {
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        icon: const Icon(
          Icons.check_circle_outline_rounded,
          size: FabrikSnackbarDefaults.defaultIconSize,
          color: FabrikSnackbarDefaults.defaultIconColor,
        ),
        backgroundColor: Colors.green,
        duration: Duration(
          seconds:
              durationInSeconds ??
              FabrikSnackbarDefaults.defaultDuration.inSeconds,
        ),
        position: position ?? FabrikSnackbarPosition.bottom,
        dismissDirection:
            dismissDirection ?? FabrikSnackbarDismissDirection.vertical,
        maxWidth: maxWidth,
        actionButton: actionButton,
        safeArea: safeArea ?? true,
        showProgressIndicator: showProgressIndicator ?? false,
        barrierBlur: barrierBlur ?? FabrikSnackbarDefaults.defaultBarrierBlur,
        barrierColor: barrierColor,
      ),
    );
  }

  /// Show an error snackbar
  static Future<void> error(
    BuildContext context, {
    required String title,
    required String message,
    int? durationInSeconds,
    FabrikSnackbarPosition? position,
    FabrikSnackbarDismissDirection? dismissDirection,
    double? maxWidth,
    Widget? actionButton,
    bool? safeArea,
    bool? showProgressIndicator,
    double? barrierBlur,
    Color? barrierColor,
  }) async {
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        icon: const Icon(
          Icons.error_outline_rounded,
          size: FabrikSnackbarDefaults.defaultIconSize,
          color: FabrikSnackbarDefaults.defaultIconColor,
        ),
        backgroundColor: Colors.red,
        duration: Duration(
          seconds:
              durationInSeconds ??
              FabrikSnackbarDefaults.defaultDuration.inSeconds,
        ),
        position: position ?? FabrikSnackbarPosition.bottom,
        dismissDirection:
            dismissDirection ?? FabrikSnackbarDismissDirection.vertical,
        maxWidth: maxWidth,
        actionButton: actionButton,
        safeArea: safeArea ?? true,
        showProgressIndicator: showProgressIndicator ?? false,
        barrierBlur: barrierBlur ?? FabrikSnackbarDefaults.defaultBarrierBlur,
        barrierColor: barrierColor,
      ),
    );
  }

  /// Show an info snackbar
  static Future<void> info(
    BuildContext context, {
    required String title,
    required String message,
    int? durationInSeconds,
    FabrikSnackbarPosition? position,
    FabrikSnackbarDismissDirection? dismissDirection,
    double? maxWidth,
    Widget? actionButton,
    bool? safeArea,
    bool? showProgressIndicator,
    double? barrierBlur,
    Color? barrierColor,
  }) async {
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        icon: const Icon(
          Icons.info_outline_rounded,
          size: FabrikSnackbarDefaults.defaultIconSize,
          color: FabrikSnackbarDefaults.defaultIconColor,
        ),
        backgroundColor: Colors.blue,
        duration: Duration(
          seconds:
              durationInSeconds ??
              FabrikSnackbarDefaults.defaultDuration.inSeconds,
        ),
        position: position ?? FabrikSnackbarPosition.bottom,
        dismissDirection:
            dismissDirection ?? FabrikSnackbarDismissDirection.vertical,
        maxWidth: maxWidth,
        actionButton: actionButton,
        safeArea: safeArea ?? true,
        showProgressIndicator: showProgressIndicator ?? false,
        barrierBlur: barrierBlur ?? FabrikSnackbarDefaults.defaultBarrierBlur,
        barrierColor: barrierColor,
      ),
    );
  }

  /// Show a warning snackbar
  static Future<void> warning(
    BuildContext context, {
    required String title,
    required String message,
    int? durationInSeconds,
    FabrikSnackbarPosition? position,
    FabrikSnackbarDismissDirection? dismissDirection,
    double? maxWidth,
    Widget? actionButton,
    bool? safeArea,
    bool? showProgressIndicator,
    double? barrierBlur,
    Color? barrierColor,
  }) async {
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        icon: const Icon(
          Icons.warning_amber_rounded,
          size: FabrikSnackbarDefaults.defaultIconSize,
          color: FabrikSnackbarDefaults.defaultIconColor,
        ),
        backgroundColor: Colors.orange,
        duration: Duration(
          seconds:
              durationInSeconds ??
              FabrikSnackbarDefaults.defaultDuration.inSeconds,
        ),
        position: position ?? FabrikSnackbarPosition.bottom,
        dismissDirection:
            dismissDirection ?? FabrikSnackbarDismissDirection.vertical,
        maxWidth: maxWidth,
        actionButton: actionButton,
        safeArea: safeArea ?? true,
        showProgressIndicator: showProgressIndicator ?? false,
        barrierBlur: barrierBlur ?? FabrikSnackbarDefaults.defaultBarrierBlur,
        barrierColor: barrierColor,
      ),
    );
  }

  /// Show a fully custom snackbar
  static Future<void> custom(
    BuildContext context, {
    required FabrikSnackbarConfig config,
  }) async {
    return _show(context, config: config);
  }

  static Future<void> _show(
    BuildContext context, {
    required FabrikSnackbarConfig config,
  }) async {
    final overlay = Overlay.of(context, rootOverlay: true);

    if (!overlay.mounted) {
      debugPrint('No overlay found in context');
      return;
    }

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return FabrikSnackbarWidget(
          config: config,
          onDismissed: () {
            entry.remove();
            config.onDismissed?.call();
          },
        );
      },
    );

    overlay.insert(entry);
  }
}
