/// Defines breakpoint thresholds used to resolve layout categories.
///
/// Values represent logical pixel widths. The [mobile] and [tablet]
/// thresholds drive layout classification — [desktop] is reserved for
/// future use and does not currently affect classification logic.
///
/// ```dart
/// FabrikLayout(
///   breakpoints: const FabrikBreakpoints(mobile: 480, tablet: 768),
///   child: child!,
/// )
/// ```
class FabrikBreakpoints {
  /// Width threshold below which the layout is classified as mobile.
  /// Defaults to 600.
  final double mobile;

  /// Width threshold at or above which the layout is classified as tablet,
  /// and below which it is desktop. Defaults to 1024.
  final double tablet;

  /// Reserved breakpoint value. Defaults to 1440.
  final double desktop;

  const FabrikBreakpoints({
    this.mobile = 600,
    this.tablet = 1024,
    this.desktop = 1440,
  }) : assert(mobile < tablet, 'mobile breakpoint must be less than tablet');

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
