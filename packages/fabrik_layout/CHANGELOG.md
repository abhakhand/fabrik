# Changelog

All notable changes to this package are documented in this file.

The format is based on Keep a Changelog, and this project adheres to semantic versioning.

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
