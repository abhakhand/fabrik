/// A scalable elevation system using consistent 1.0 unit increments,
/// inspired by Material Design 3.
///
/// All values are in logical pixels and match Flutter's elevation
/// usage in components like Cards, Sheets, AppBars, and Modals.
class FabrikElevation {
  const FabrikElevation._();

  /// No elevation — fully flat.
  /// **Value:** 0.0
  static const double x0 = 0.0;

  /// Very low elevation — commonly used for input fields or surfaces.
  /// **Value:** 1.0
  static const double x1 = 1.0;

  /// Low elevation — used for cards or lightweight containers.
  /// **Value:** 3.0
  static const double x3 = 3.0;

  /// Medium elevation — surfaces that float slightly above background.
  /// **Value:** 6.0
  static const double x6 = 6.0;

  /// High elevation — dialogs, navigation drawers, bottom sheets.
  /// **Value:** 8.0
  static const double x8 = 8.0;

  /// Very high elevation — modal dialogs, focused components.
  /// **Value:** 12.0
  static const double x12 = 12.0;

  /// Maximum elevation for large floating surfaces.
  /// **Value:** 16.0
  static const double x16 = 16.0;

  /// Used for elevated full-screen overlays or extreme depth effects.
  /// **Value:** 24.0
  static const double x24 = 24.0;

  /// Optional: Reserved for dramatic UI effects (e.g., spotlight modals).
  /// **Value:** 32.0
  static const double x32 = 32.0;
}
