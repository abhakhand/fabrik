/// Defines breakpoint thresholds used to resolve layout categories.
///
/// Values represent logical pixel widths.
class FabrikBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const FabrikBreakpoints({
    this.mobile = 600,
    this.tablet = 1024,
    this.desktop = 1440,
  });
}
