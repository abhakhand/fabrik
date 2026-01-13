import 'package:flutter/material.dart';
import 'package:fabrik_theme/src/extensions/app_colors.dart';
import 'package:fabrik_theme/src/extensions/app_typography.dart';

/// Convenience extensions on [BuildContext] for accessing Fabrik theme data.
///
/// These getters provide ergonomic access to semantic colors and typography
/// defined via [ThemeExtension]s. They are thin wrappers over [Theme.of]
/// and do not introduce additional rebuilds or state.
extension FabrikThemeContext on BuildContext {
  /// Returns the active [AppColors] from the current theme.
  ///
  /// Throws a clear error if the colors extension is not registered.
  AppColors get colors {
    final colors = Theme.of(this).extension<AppColors>();
    assert(
      colors != null,
      'AppColors not found in ThemeData.extensions. '
      'Did you forget to use FabrikTheme.create?',
    );
    return colors!;
  }

  /// Returns the active [AppTypography] from the current theme.
  ///
  /// Throws a clear error if the typography extension is not registered.
  AppTypography get typography {
    final typography = Theme.of(this).extension<AppTypography>();
    assert(
      typography != null,
      'AppTypography not found in ThemeData.extensions. '
      'Did you forget to use FabrikTheme.create?',
    );
    return typography!;
  }
}
