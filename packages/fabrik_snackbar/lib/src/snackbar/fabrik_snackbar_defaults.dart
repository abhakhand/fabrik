import 'package:flutter/material.dart';

class FabrikSnackbarDefaults {
  // General
  static const Duration defaultDuration = Duration(seconds: 3);

  // Icon
  static const double defaultIconSize = 32.0;
  static const Color defaultIconColor = Colors.white;

  // Snackbar Container
  static const double defaultMaxWidth = 480.0;
  static const EdgeInsets defaultMargin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const EdgeInsets defaultPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  // Background Interaction
  static const double defaultBarrierBlur = 0.0;
  static const Color defaultBarrierColor = Colors.black38;

  // Text
  static const double defaultTitleFontSize = 16.0;
  static const double defaultMessageFontSize = 14.0;
  static const FontWeight defaultTitleFontWeight = FontWeight.bold;
  static const Color defaultTextColor = Colors.white;
}
