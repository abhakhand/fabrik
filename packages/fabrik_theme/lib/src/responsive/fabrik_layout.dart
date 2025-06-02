/// Defines the responsive layout buckets used in the Fabrik UI system.
///
/// Layouts are classified based on **perceived UI behavior**, not just screen size.
/// This system supports three levels:
/// - `mobile`: for compact vertical layouts
/// - `tablet`: for medium-sized screens (e.g. tablets or wide phones)
/// - `desktop`: for wide layouts with multiple columns or sidebars
///
/// ### Platform-specific rules:
///
/// - On **desktop platforms** (macOS, Windows, Linux):
///   - `desktop` if width ≥ 1024
///   - `tablet` if width ≥ 700 and < 1024
///   - `mobile` if width < 700
///
/// - On **mobile platforms** (Android, iOS):
///   - If in **portrait**, always `mobile`
///   - If in **landscape**:
///     - `desktop` if width ≥ 1024
///     - `tablet` if width ≥ 740 and < 1024
///     - `mobile` otherwise
enum FabrikLayout { mobile, tablet, desktop }
