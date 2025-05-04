import 'package:flutter/material.dart';

/// Default values used by [FabrikSnackbar] when no overrides are provided.
///
/// These values help ensure consistent styling and behavior across all
/// snackbar variants (success, error, info, etc.).
class FabrikSnackbarDefaults {
  // ─────────────────────────────────────────────────────
  // General
  // ─────────────────────────────────────────────────────

  /// Default duration before the snackbar auto-dismisses.
  static const Duration defaultDuration = Duration(seconds: 3);

  // ─────────────────────────────────────────────────────
  // Icon
  // ─────────────────────────────────────────────────────

  /// Default size of the leading icon in the snackbar.
  static const double defaultIconSize = 32.0;

  /// Default color of the leading icon.
  static const Color defaultIconColor = Colors.white;

  // ─────────────────────────────────────────────────────
  // Snackbar Container
  // ─────────────────────────────────────────────────────

  /// Default maximum width of the snackbar (used on wider screens).
  static const double defaultMaxWidth = 480.0;

  /// Default margin around the snackbar container.
  static const EdgeInsets defaultMargin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Default internal padding within the snackbar.
  static const EdgeInsets defaultPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Default border radius for rounded snackbar corners.
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    Radius.circular(12),
  );

  // ─────────────────────────────────────────────────────
  // Background Interaction
  // ─────────────────────────────────────────────────────

  /// Default blur value for background if blur is enabled.
  static const double defaultBarrierBlur = 0.0;

  /// Default color for background overlay when interaction is blocked.
  static const Color defaultBarrierColor = Colors.black38;

  // ─────────────────────────────────────────────────────
  // Text
  // ─────────────────────────────────────────────────────

  /// Default font size for the snackbar title.
  static const double defaultTitleFontSize = 16.0;

  /// Default font size for the snackbar message.
  static const double defaultMessageFontSize = 14.0;

  /// Default font weight for the snackbar title.
  static const FontWeight defaultTitleFontWeight = FontWeight.bold;

  /// Default text color used for title and message.
  static const Color defaultTextColor = Colors.white;
}
