import 'package:fabrik_snackbar/src/snackbar/fabrik_snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'fabrik_snackbar_config.dart';
import 'fabrik_snackbar_helpers.dart';
import 'fabrik_snackbar_defaults.dart';

/// Provides a simple API to show custom, animated snackbars in your app.
///
/// Use [FabrikSnackbar.success], [FabrikSnackbar.error], etc. for prebuilt styles,
/// or [FabrikSnackbar.custom] for full control with [FabrikSnackbarConfig].
class FabrikSnackbar {
  FabrikSnackbar._();

  /// Validates that content is provided properly.
  /// At least one content field must be present, and title/richTitle are
  /// mutually exclusive, as are message/richMessage.
  static void _validateContent({
    String? title,
    String? message,
    InlineSpan? richTitle,
    InlineSpan? richMessage,
  }) {
    assert(
      title != null || richTitle != null || message != null || richMessage != null,
      'At least one of title, richTitle, message, or richMessage must be provided.',
    );
    assert(
      title == null || richTitle == null,
      'Provide either title or richTitle, not both.',
    );
    assert(
      message == null || richMessage == null,
      'Provide either message or richMessage, not both.',
    );
  }

  /// Shows a green success snackbar.
  ///
  /// At least one of [title], [richTitle], [message], or [richMessage] must be
  /// provided. [title] and [richTitle] are mutually exclusive, as are [message]
  /// and [richMessage].
  static Future<void> success(
    BuildContext context, {
    String? title,
    String? message,
    InlineSpan? richTitle,
    InlineSpan? richMessage,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
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
    _validateContent(
      title: title,
      message: message,
      richTitle: richTitle,
      richMessage: richMessage,
    );
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        richTitle: richTitle,
        richMessage: richMessage,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
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

  /// Shows a red error snackbar.
  ///
  /// At least one of [title], [richTitle], [message], or [richMessage] must be
  /// provided. [title] and [richTitle] are mutually exclusive, as are [message]
  /// and [richMessage].
  static Future<void> error(
    BuildContext context, {
    String? title,
    String? message,
    InlineSpan? richTitle,
    InlineSpan? richMessage,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
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
    _validateContent(
      title: title,
      message: message,
      richTitle: richTitle,
      richMessage: richMessage,
    );
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        richTitle: richTitle,
        richMessage: richMessage,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
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

  /// Shows a blue informational snackbar.
  ///
  /// At least one of [title], [richTitle], [message], or [richMessage] must be
  /// provided. [title] and [richTitle] are mutually exclusive, as are [message]
  /// and [richMessage].
  static Future<void> info(
    BuildContext context, {
    String? title,
    String? message,
    InlineSpan? richTitle,
    InlineSpan? richMessage,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
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
    _validateContent(
      title: title,
      message: message,
      richTitle: richTitle,
      richMessage: richMessage,
    );
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        richTitle: richTitle,
        richMessage: richMessage,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
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

  /// Shows an orange warning snackbar.
  ///
  /// At least one of [title], [richTitle], [message], or [richMessage] must be
  /// provided. [title] and [richTitle] are mutually exclusive, as are [message]
  /// and [richMessage].
  static Future<void> warning(
    BuildContext context, {
    String? title,
    String? message,
    InlineSpan? richTitle,
    InlineSpan? richMessage,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
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
    _validateContent(
      title: title,
      message: message,
      richTitle: richTitle,
      richMessage: richMessage,
    );
    return _show(
      context,
      config: FabrikSnackbarConfig(
        title: title,
        message: message,
        richTitle: richTitle,
        richMessage: richMessage,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
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

  /// Shows a fully custom snackbar using a [FabrikSnackbarConfig].
  ///
  /// All validation (mutual exclusivity of title/richTitle and
  /// message/richMessage) is enforced via assertions in [FabrikSnackbarConfig]'s
  /// constructor.
  static Future<void> custom(
    BuildContext context, {
    required FabrikSnackbarConfig config,
  }) async {
    return _show(context, config: config);
  }

  /// Internal method to build and insert the snackbar overlay.
  static Future<void> _show(
    BuildContext context, {
    required FabrikSnackbarConfig config,
  }) async {
    // `Overlay.of` throws when no Overlay is present, so `maybeOf` is what
    // actually lets this degrade gracefully.
    final overlay = Overlay.maybeOf(context, rootOverlay: true);

    if (overlay == null || !overlay.mounted) {
      debugPrint(
        'FabrikSnackbar: no Overlay found in the given context. '
        'Make sure the context is below a MaterialApp, CupertinoApp, '
        'or an explicit Overlay widget.',
      );
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
