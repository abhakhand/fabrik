/// Defines the responsive layout buckets used in the Fabrik UI system.
///
/// Layouts are classified based on **perceived UI behavior**, not just screen size.
/// The goal is to reflect how users expect the interface to behave in different
/// device and orientation contexts.
///
/// A screen is considered:
///
/// - [FabrikLayout.desktop] when it has enough width to comfortably support
///   multi-column layouts, sidebars, and other wide-screen UI behaviors.
///
/// - [FabrikLayout.mobile] when it is narrow, vertical, or otherwise better suited
///   to stacked, single-column layouts.
///
/// The classification rules are:
/// - On **desktop platforms** (macOS, Windows, Linux) or **web**:
///   - `desktop` layout is used if width ≥ 700
///   - `mobile` layout is used if width < 700
///
/// - On **mobile platforms** (Android, iOS):
///   - If in **landscape** and width ≥ 740 → `desktop`
///   - Otherwise → `mobile`
enum FabrikLayout {
  /// For narrow or vertically-oriented screens, such as:
  /// - Phones in portrait
  /// - Tablets in portrait
  /// - Very small windows on desktop
  mobile,

  /// For wide-screen layouts that support split views and desktop-like UI, such as:
  /// - Laptops and desktops
  /// - Tablets in landscape
  /// - Phones in landscape (if width ≥ 740)
  desktop,
}
