# 0.1.0

- 🎉 Initial release
- Generate feature scaffolding with clean architecture
- Smart output dir support (`--output-dir` or `-o`)

## [0.1.1] - 2025-04-15

- Added `example/main.dart` to pass pub.dev "has example" check.
- Added dartdoc comments to the main entry point for better documentation score.
- Improved compatibility with pub.dev publishing requirements.

## [0.1.2] - 2025-04-15

- Fixed `Feature brick not found at ../bricks/feature` error when using the CLI globally.
- Brick path is now bundled inside the CLI package so it works everywhere.
- Updated CLI to reference `bricks/feature` instead of relative paths.
- Moved `feature` brick inside the `fabrik_cli` package.
- Ensured it gets published and recognized by `pub.dev`.

## [0.1.3] - 2025-04-15

- Ensured `bricks/feature` is included in the published package using the `include:` key in `pubspec.yaml`.
- Fixed issue where the CLI couldn’t find the brick (`Feature brick not found at bricks/feature`) when installed globally from pub.dev.
- Removed unused `assets:` key since this is a pure Dart CLI, not a Flutter package.

## [0.1.4] - 2025-04-15

- Replaced path-based brick loading with `.bundle` loading using `MasonBundle.fromUniversalBundle`.
- Feature scaffolding brick is now precompiled and loaded from:

## [0.1.5] - 2025-04-15

- Removed outdated check for `bricks/feature` directory, since the CLI now uses a `.bundle` file for brick generation.
- Simplified generator loading by fully relying on:

## [0.1.6] - 2025-04-15

- Fixed a critical issue where the CLI failed to locate the brick bundle (`feature.bundle`) when installed globally via pub, especially on **Windows systems**.
- Replaced manual `File` path logic with Dart-native `Isolate.resolvePackageUri` to **resolve the bundle path correctly** in all environments.

## [0.1.7] - 2025-04-15

- Updated `README.md` with a complete **📚 Recommended Utility Packages** section.
- Included essential packages for clean architecture: `dartz`, `bloc`, `flutter_bloc`, `equatable`, `json_serializable`, `json_annotation`, `freezed`, `injectable`, and `get_it`.
- Improved cross-platform `PATH` setup instructions for both macOS/Linux and Windows users.

## [0.1.8] - 2025-04-15

- Added **detailed DartDoc comments** to the CLI entry file (`bin/fabrik.dart`)
- Explained each CLI step: argument parsing, command execution, path normalization, and brick loading.
- Made it easier for contributors and team members to understand and extend the CLI codebase.
- Improved onboarding clarity for developers using the CLI internally or externally.

## [0.1.8] - 2025-05-05

- Updated folder structure
- Added failure for the feature
- Updated readme
