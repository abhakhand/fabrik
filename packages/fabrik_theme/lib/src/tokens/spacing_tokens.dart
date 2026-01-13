/// Defines spacing tokens used to establish consistent layout rhythm.
///
/// Spacing tokens represent fixed spacing values that are used for padding,
/// margins, gaps, and general layout structure. These values are static by
/// design and do not change based on screen size or theme configuration.
///
/// Spacing tokens should be accessed directly and must not depend on
/// [BuildContext]. Any adaptive or responsive behavior should be implemented
/// in a separate layout or responsiveness layer.
abstract final class SpacingTokens {
  /// No spacing.
  static const double none = 0;

  /// Extra-extra-small spacing, typically used for fine-grained adjustments.
  static const double xxs = 2;

  /// Extra-small spacing, commonly used between tightly grouped elements.
  static const double xs = 4;

  /// Small spacing, suitable for compact padding and gaps.
  static const double sm = 8;

  /// Medium spacing, commonly used for standard padding and spacing.
  static const double md = 12;

  /// Large spacing, suitable for section separation and larger padding.
  static const double lg = 16;

  /// Extra-large spacing, typically used between major layout sections.
  static const double xl = 24;

  /// Extra-extra-large spacing for high-level layout separation.
  static const double xxl = 32;

  /// Extra-extra-extra-large spacing, used sparingly for page-level separation.
  static const double xxxl = 48;
}
