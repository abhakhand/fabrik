/// Defines radius tokens used to establish a consistent shape language.
///
/// Radius tokens represent fixed corner radius values that are applied to
/// components such as buttons, cards, inputs, sheets, and dialogs. These
/// values are static by design and reflect the visual identity of the
/// design system.
///
/// Radius tokens should be combined with Flutter APIs such as
/// [BorderRadius.circular] at the usage site. Tokens intentionally expose
/// only numeric values and do not wrap Flutter-specific objects.
abstract final class RadiusTokens {
  /// No corner radius. Used for sharp-edged surfaces.
  static const double none = 0;

  /// Extra-small radius used for compact elements such as chips or tags.
  static const double xs = 4;

  /// Small radius used for buttons and input fields.
  static const double sm = 8;

  /// Medium radius used for cards and common surfaces.
  static const double md = 12;

  /// Large radius used for sheets and prominent containers.
  static const double lg = 16;

  /// Extra-large radius used for modals and hero surfaces.
  static const double xl = 24;

  /// Fully rounded radius used for pills, avatars, and circular elements.
  ///
  /// This value is intentionally large to ensure a circular appearance
  /// regardless of the element size.
  static const double full = 999;
}
