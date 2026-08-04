/// Represents high-level device categories derived from layout width.
///
/// This is intentionally width-based rather than platform-based: a phone-sized
/// window on a desktop machine classifies as [mobile].
///
/// Thresholds come from `FabrikBreakpoints`, which by default resolves to:
///
/// | Category       | Width          |
/// | -------------- | -------------- |
/// | [mobile]       | `< 600`        |
/// | [tablet]       | `600 – 1023`   |
/// | [desktop]      | `1024 – 1439`  |
/// | [largeDesktop] | `>= 1440`      |
enum FabrikLayoutType {
  /// Phone-sized layouts.
  mobile,

  /// Tablet-sized layouts, and small desktop windows.
  tablet,

  /// Standard desktop and laptop layouts.
  desktop,

  /// Wide desktop layouts, such as full-screen windows on large monitors.
  ///
  /// Treat this as a refinement of [desktop]: most apps can ignore it, and
  /// `FabrikLayoutData.value` falls back to the `desktop` value when no
  /// `largeDesktop` value is supplied.
  largeDesktop,
}
