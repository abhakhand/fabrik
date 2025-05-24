import 'package:flutter/material.dart';
import '../tokens/fabrik_colors.dart';
import '../typography/fabrik_typography.dart';

/// A custom theme extension for Fabrik UI design system.
///
/// This holds both the design system colors and typography,
/// allowing them to be accessed from the widget tree using:
///
/// ```dart
/// final theme = FabrikTheme.of(context);
/// final color = theme.colors.primary;
/// final textStyle = theme.typography.bodyRegular;
/// ```
class FabrikTheme extends ThemeExtension<FabrikTheme> {
  /// Design system colors (resolved dynamically with brightness).
  final FabrikColors colors;

  /// Design system typography (includes fonts, weights, text colors).
  final FabrikTypography typography;

  /// Creates a new [FabrikTheme] with required colors and typography.
  const FabrikTheme({required this.colors, required this.typography});

  /// Allows the theme to be copied with new values (immutable pattern).
  @override
  FabrikTheme copyWith({FabrikColors? colors, FabrikTypography? typography}) {
    return FabrikTheme(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
    );
  }

  /// Theme animation interpolation.
  ///
  /// Currently no animation logic is implemented — just returns [this].
  @override
  FabrikTheme lerp(ThemeExtension<FabrikTheme>? other, double t) {
    if (other is! FabrikTheme) return this;
    return this;
  }

  /// Access the current [FabrikTheme] from the widget tree.
  ///
  /// Throws an assertion error if not initialized in `ThemeData.extensions`.
  static FabrikTheme of(BuildContext context) {
    final theme = Theme.of(context).extension<FabrikTheme>();
    assert(
      theme != null,
      'FabrikTheme is not added to ThemeData.extensions. '
      'Make sure you include it inside ThemeData(extensions: [...])',
    );

    // Resolve theme-based dynamic colors (e.g. for light/dark mode).
    theme!.colors.resolveWith(Theme.of(context).brightness);

    return theme;
  }
}
