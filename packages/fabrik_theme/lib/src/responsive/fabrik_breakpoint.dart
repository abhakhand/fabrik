/// Defines the responsive breakpoints used in the Fabrik UI system.
///
/// Each breakpoint represents the **minimum screen width** (using the
/// device's shortest side) at which the layout should adapt.
///
/// These are inspired by common design systems like Tailwind, Material,
/// and Bootstrap — but optimized for cross-orientation behavior.
enum FabrikBreakpoint {
  /// For mobile devices and very narrow screens.
  ///
  /// **Applies to:** width or height < 600
  mobile(0),

  /// For tablets and medium-sized screens.
  ///
  /// **Applies to:** width or height ≥ 600 and < 1024
  tablet(600),

  /// For desktops and wide screens.
  ///
  /// **Applies to:** width or height ≥ 1024
  desktop(1024);

  /// The minimum dimension (shortestSide) at which this breakpoint applies.
  final double value;

  const FabrikBreakpoint(this.value);
}
