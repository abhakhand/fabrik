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
