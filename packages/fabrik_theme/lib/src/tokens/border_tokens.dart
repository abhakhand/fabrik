/// Defines border width tokens used for outlines and separators.
///
/// Border tokens represent standardized stroke widths that are applied to
/// borders, dividers, outlines, and focus indicators. These values are
/// static and intentionally minimal to maintain visual consistency across
/// the application.
///
/// Border tokens expose only numeric widths and must be combined with
/// Flutter border APIs such as [BorderSide] or [BoxBorder] at the usage site.
abstract final class BorderTokens {
  /// No border.
  static const double none = 0;

  /// Thin border used for dividers and subtle outlines.
  static const double thin = 1;

  /// Medium border used for inputs, cards, and standard outlines.
  static const double medium = 1.5;

  /// Thick border used for emphasis, selection, or focus states.
  static const double thick = 2;
}
