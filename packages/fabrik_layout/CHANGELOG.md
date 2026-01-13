# Changelog

All notable changes to this package are documented in this file.

The format is based on Keep a Changelog, and this project adheres to semantic versioning.

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
