/// Defines breakpoint thresholds used to resolve layout categories.
///
/// Values are logical pixel widths, and each names the **upper bound** of the
/// category below it. With the defaults:
///
/// | Category                          | Width         |
/// | --------------------------------- | ------------- |
/// | `FabrikLayoutType.mobile`         | `< 600`       |
/// | `FabrikLayoutType.tablet`         | `600 – 1023`  |
/// | `FabrikLayoutType.desktop`        | `1024 – 1439` |
/// | `FabrikLayoutType.largeDesktop`   | `>= 1440`     |
///
/// So `FabrikBreakpoints(mobile: 480, tablet: 768)` means "mobile is anything
/// under 480" and "tablet runs from 480 up to 767".
///
/// ```dart
/// FabrikLayout(
///   breakpoints: const FabrikBreakpoints(mobile: 480, tablet: 768),
///   child: child!,
/// )
/// ```
class FabrikBreakpoints {
  /// Upper bound of the mobile category: widths below this are mobile.
  /// Defaults to 600.
  final double mobile;

  /// Upper bound of the tablet category: widths from [mobile] up to this are
  /// tablet. Defaults to 1024.
  final double tablet;

  /// Upper bound of the desktop category: widths from [tablet] up to this are
  /// desktop, and anything at or above it is
  /// `FabrikLayoutType.largeDesktop`. Defaults to 1440.
  final double desktop;

  const FabrikBreakpoints({
    this.mobile = 600,
    this.tablet = 1024,
    this.desktop = 1440,
  }) : assert(mobile < tablet, 'mobile breakpoint must be less than tablet'),
       assert(tablet < desktop, 'tablet breakpoint must be less than desktop');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FabrikBreakpoints &&
        other.mobile == mobile &&
        other.tablet == tablet &&
        other.desktop == desktop;
  }

  @override
  int get hashCode => Object.hash(mobile, tablet, desktop);
}
