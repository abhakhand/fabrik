import 'package:flutter/material.dart';
import 'package:fabrik_theme/src/extensions/app_colors.dart';
import 'package:fabrik_theme/src/extensions/app_typography.dart';

/// Convenience extensions on [BuildContext] for accessing Fabrik theme data.
///
/// These getters provide ergonomic access to semantic colors and typography
/// defined via [ThemeExtension]s. They are thin wrappers over [Theme.of]
/// and do not introduce additional rebuilds or state.
///
/// Both getters throw a [StateError] if the corresponding extension is not
/// registered in the active [ThemeData]. This check is enforced in both debug
/// and release builds — unlike `assert`, which is stripped in release mode.
/// Always initialize your theme with [FabrikTheme.create] to avoid this.
extension FabrikThemeContext on BuildContext {
  /// Returns the active [AppColors] from the current theme.
  ///
  /// Throws a [StateError] in debug and release mode if [AppColors] is not
  /// registered. Use [FabrikTheme.create] to ensure it is present.
  AppColors get colors {
    return Theme.of(this).extension<AppColors>() ??
        (throw StateError(
          'AppColors not found in ThemeData.extensions. '
          'Did you forget to use FabrikTheme.create?',
        ));
  }

  /// Returns the active [AppTypography] from the current theme.
  ///
  /// Throws a [StateError] in debug and release mode if [AppTypography] is not
  /// registered. Use [FabrikTheme.create] to ensure it is present.
  AppTypography get typography {
    return Theme.of(this).extension<AppTypography>() ??
        (throw StateError(
          'AppTypography not found in ThemeData.extensions. '
          'Did you forget to use FabrikTheme.create?',
        ));
  }
}
