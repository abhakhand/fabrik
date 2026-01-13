/// Defines elevation tokens used to express visual depth.
///
/// Elevation tokens represent standardized elevation values that can be
/// applied to surfaces such as cards, sheets, dialogs, and overlays.
/// These values are expressed as logical elevation units and are platform
/// agnostic.
///
/// Elevation tokens are intentionally numeric and minimal. More complex
/// shadow definitions or platform-specific behaviors should be handled
/// by higher-level abstractions if required.
abstract final class ElevationTokens {
  /// No elevation. Used for flat surfaces.
  static const double none = 0;

  /// Extra-small elevation for subtle surface separation.
  static const double xs = 1;

  /// Small elevation, commonly used for cards and contained surfaces.
  static const double sm = 3;

  /// Medium elevation for prominent surfaces such as floating cards.
  static const double md = 6;

  /// Large elevation for overlays and raised components.
  static const double lg = 12;

  /// Extra-large elevation for modals, dialogs, and top-level overlays.
  static const double xl = 24;
}
