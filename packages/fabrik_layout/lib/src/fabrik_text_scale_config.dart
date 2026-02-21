import 'package:flutter/widgets.dart';

/// Configuration for device-aware minimum text scale factors.
///
/// Pass a custom [FabrikTextScaleConfig] to [FabrikLayout] to override
/// the default scale floors for each device category. Values represent
/// the minimum scale factor applied when `enableTextScaling` is true.
///
/// The system's accessibility text scale is always respected — these
/// values only raise the floor, never reduce the user's chosen scale.
///
/// ```dart
/// FabrikLayout(
///   enableTextScaling: true,
///   textScaleConfig: const FabrikTextScaleConfig(
///     mobile: 1.0,
///     tablet: 1.08,
///     desktop: 1.15,
///   ),
///   child: child!,
/// )
/// ```
@immutable
class FabrikTextScaleConfig {
  /// Minimum scale factor applied on mobile-sized layouts. Defaults to 1.0.
  final double mobile;

  /// Minimum scale factor applied on tablet-sized layouts. Defaults to 1.05.
  final double tablet;

  /// Minimum scale factor applied on desktop-sized layouts. Defaults to 1.1.
  final double desktop;

  const FabrikTextScaleConfig({
    this.mobile = 1.0,
    this.tablet = 1.05,
    this.desktop = 1.1,
  })  : assert(mobile > 0, 'mobile scale factor must be positive'),
        assert(tablet > 0, 'tablet scale factor must be positive'),
        assert(desktop > 0, 'desktop scale factor must be positive');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FabrikTextScaleConfig &&
        other.mobile == mobile &&
        other.tablet == tablet &&
        other.desktop == desktop;
  }

  @override
  int get hashCode => Object.hash(mobile, tablet, desktop);
}
