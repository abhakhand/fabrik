# 0.1.0

- 🎉 Initial release
- Generate feature scaffolding with clean architecture
- Smart output dir support (`--output-dir` or `-o`)

## [0.1.1] - 2025-04-15

### ✨ Improvements

- Added `example/main.dart` to pass pub.dev "has example" check.
- Added dartdoc comments to the main entry point for better documentation score.

### 🛠 Maintenance

- Improved compatibility with pub.dev publishing requirements.

### 🏆 Result

Achieved a perfect **160/160** pub score on [pub.dev](https://pub.dev/packages/fabrik)!

## [0.1.2] - 2025-04-15

### 🐛 Bug Fixes

- Fixed `Feature brick not found at ../bricks/feature` error when using the CLI globally.
  - 🧱 Brick path is now bundled inside the CLI package so it works everywhere.
  - 📦 Updated CLI to reference `bricks/feature` instead of relative paths.

### 🛠 Packaging

- Moved `feature` brick inside the `fabrik_cli` package.
- Ensured it gets published and recognized by `pub.dev`.

---

Now you can run `fabrik generate feature auth` globally — no more path errors!

## [0.1.3] - 2025-04-15

### 🛠 Packaging Fix

- Ensured `bricks/feature` is included in the published package using the `include:` key in `pubspec.yaml`.
- Fixed issue where the CLI couldn’t find the brick (`Feature brick not found at bricks/feature`) when installed globally from pub.dev.
- Removed unused `assets:` key since this is a pure Dart CLI, not a Flutter package.

---

🧱 You can now install Fabrik globally and use it from anywhere without missing bricks.

## [0.1.4] - 2025-04-15

### 🧱 Brick Loading Refactor

- Replaced path-based brick loading with `.bundle` loading using `MasonBundle.fromUniversalBundle`.
- Feature scaffolding brick is now precompiled and loaded from:
