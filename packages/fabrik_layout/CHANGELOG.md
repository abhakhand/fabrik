# Changelog

All notable changes to this package are documented in this file.

The format is based on Keep a Changelog, and this project adheres to semantic versioning.

---

## 1.2.0

### Fixes

- **Fix:** Layout is no longer misclassified under an unbounded-width ancestor. Inside a horizontal `ListView` or an unconstrained `Row`, `constraints.maxWidth` is infinite, and since `Infinity < mobile` is false every device fell through to the widest category — a 375 px phone reported `isDesktop == true` while `screenSize` correctly reported 375. `FabrikLayout` now falls back to the `MediaQuery` width whenever the incoming width is unbounded, so `type` and `screenSize` can no longer contradict each other.

- **Fix:** `FabrikBreakpoints.desktop` now affects classification. It was documented as "reserved for future use" and had no effect at all — setting it to `1`, `1440` or `9999` produced identical results — while still appearing in the public constructor as though it meant something.

### Breaking

- **Changed:** `FabrikLayoutType` gains a fourth value, `largeDesktop`, for widths at or above `FabrikBreakpoints.desktop` (1440 by default). Widths from `tablet` up to `desktop` remain `desktop`.

  This breaks exhaustive `switch` statements over `FabrikLayoutType`; the analyzer will point at each one. Code that only uses `isMobile` / `isTablet` / `value<T>()` is unaffected.

  Note that `isDesktop` is now the narrow 1024–1439 band only. Use the new `isDesktopOrWider` where you previously meant "desktop and above":

  ```dart
  // before — true for everything >= 1024
  if (context.layout.isDesktop) { ... }

  // after — same meaning
  if (context.layout.isDesktopOrWider) { ... }
  ```

- **Changed:** `FabrikBreakpoints` now asserts `tablet < desktop`, alongside the existing `mobile < tablet` check.

### New

- **New:** `FabrikLayoutData.isLargeDesktop` and `isDesktopOrWider`.
- **New:** `FabrikLayoutData.value<T>()` accepts an optional `largeDesktop` argument. Omitting it falls back to `desktop`, then `tablet`, then `mobile`, so existing call sites keep working unchanged.
- **New:** `FabrikTextScaleConfig.largeDesktop`, defaulting to `null` so it reuses the `desktop` floor. `effectiveLargeDesktop` resolves the value actually applied.

### Docs

- `FabrikBreakpoints` now documents that each value is the **upper bound** of the category below it, since the field names read like lower bounds.

### Tests

- Test suite grown from 58 to 80 tests, covering the unbounded-width fallback, the four-band classification, custom desktop thresholds, and the `value<T>` fallback chain.

---

## 1.1.0

- **Added:** `FabrikLayoutData.orientation` — exposes the device orientation derived from `MediaQuery`; access via `context.layout.isPortrait` and `context.layout.isLandscape`
- **Added:** `FabrikTextScaleConfig` — configuration class for overriding default text scale floors per device category; pass to `FabrikLayout(textScaleConfig: ...)` when `enableTextScaling` is `true`
- **Added:** `FabrikLayoutData.copyWith()` — returns a modified copy of the layout snapshot
- **Fix:** `context.layout` now throws a `StateError` in both debug and release mode when `FabrikLayout` is missing — previously the `assert` was stripped in release builds, leaving a force-unwrap `!` that could crash silently
- **Fix:** `FabrikLayoutData` now implements `==` and `hashCode` — without value equality, `FabrikLayoutScope.updateShouldNotify` always returned `true` (reference comparison on freshly-created instances), causing unnecessary rebuilds on every layout change
- **Fix:** `FabrikBreakpoints` now asserts `mobile < tablet` at construction time to catch invalid configurations early
- Added `==` and `hashCode` to `FabrikBreakpoints`

---

## 1.0.0

This is the first **stable release** of `fabrik_layout` and defines the long-term public API and boundaries of the package.

The package is intentionally minimal and focuses exclusively on layout context and optional text scaling.

### Added

- `FabrikLayout` widget for providing layout context to the app
- Width-based device classification:
  - Mobile
  - Tablet
  - Desktop
- Default, opinionated breakpoint definitions via `FabrikBreakpoints`
- `FabrikLayoutData` immutable snapshot exposed via `BuildContext`
- `BuildContext` extension:
  - `context.layout`
- Optional, opt-in global text scaling using Flutter’s `TextScaler`
- Safe `MediaQuery` integration without theme mutation
