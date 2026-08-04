# Changelog

All notable changes to this package are documented in this file.
The format is based on Keep a Changelog, and this project adheres to semantic versioning.

## 1.1.0

A purely additive release. Existing `AppColors` call sites keep compiling
unchanged, since the new roles have defaults.

### New

- **New:** `AppColors.darkDefaults()` — the dark counterpart to `AppColors.defaults()`. Passing a light palette to `FabrikTheme.create(brightness: Brightness.dark, ...)` correctly darkened Material's own `ColorScheme` but left the semantic colors light, so `context.colors.surface` stayed white in dark mode and apps rendered black text on a white background with no warning. There is now a dark palette to pair with the light one:

  ```dart
  MaterialApp(
    theme: FabrikTheme.create(
      brightness: Brightness.light,
      colors: AppColors.defaults(),
    ),
    darkTheme: FabrikTheme.create(
      brightness: Brightness.dark,
      colors: AppColors.darkDefaults(),
    ),
  );
  ```

- **New:** `AppColors.error` and `onError`. Every app shows validation failures, and until now the semantic palette had no color for them — `ColorScheme.error` existed for Material's own widgets, but `context.colors` offered nothing, so error text fell back to `Colors.red` and escaped the design system. Both roles default to the new `ColorTokens.error` / `onError`, so existing constructor calls are unaffected.

- **New:** Dark color tokens on `ColorTokens` — `primaryDark`, `onPrimaryDark`, `accentDark`, `onAccentDark`, `surfaceDark`, `onSurfaceDark`, `textPrimaryDark`, `textSecondaryDark`, `textTertiaryDark`, `errorDark`, `onErrorDark`.

### Changed

- **Changed:** `FabrikTheme.create` now feeds `colors.error` and `colors.onError` into the generated `ColorScheme`, so Material widgets and your own error styling use the same color. Previously the scheme's error color was derived from the seed and could differ from anything in your palette.

### Tests

- Test suite grown from 72 to 91 tests, covering the dark palette, light/dark contrast in both directions, the error role, and its participation in `copyWith`, `lerp`, and equality.

---

## 1.0.2

- **Fix:** `context.colors` and `context.typography` now throw a `StateError` in both debug and release mode when the extension is missing — previously the `assert` was silently stripped in release builds, leaving a force-unwrap `!` that could crash without any helpful message
- **Fix:** `AppTypography.defaults()` now correctly applies the primary brand color to `*Primary` accent variants (`displayLargePrimary`, `headlineLargePrimary`, etc.) — previously all variants received `textPrimary` (black), making accent variants indistinguishable from base ones; also added `textSecondary`, `textTertiary`, and `primary` parameters to the factory
- **Fix:** `AppColors.lerp()` force-unwrap on `Color.lerp()` replaced with a null-safe fallback (`?? this.color`)
- Added `==` and `hashCode` to `AppColors` and `AppTypography`

---

## 1.0.1

- Material 3 theme defaults with `ColorScheme.fromSeed`
- Full `TextTheme` wiring using semantic typography tokens

---

## 1.0.0

This is a **major, breaking release** that establishes the long-term architecture and boundaries of `fabrik_theme`.

The package has been intentionally simplified and refocused to serve as a pure theming and design-token foundation. Several experimental and UI-level concerns present in earlier versions have been removed or relocated.

### Added

- Semantic theming system built on `ThemeExtension`
  - `AppColors` for semantic color definitions
  - `AppTypography` for semantic typography styles
- Opinionated design token sets
  - Color tokens
  - Typography tokens
  - Spacing tokens
  - Radius tokens
  - Border tokens
  - Elevation tokens
- `FabrikTheme.create` for consistent theme construction
- `FabrikTypographyBuilder` for composing typography from tokens and colors
- Optional font family support during theme creation
- `BuildContext` extensions for ergonomic access
  - `context.colors`
  - `context.typography`

### Changed

- Complete architectural redesign focused on:
  - Predictable theming
  - Clear separation of concerns
  - Long-term maintainability
- Theme construction now relies exclusively on Flutter’s native theming system
- Typography is now semantic rather than mechanical
- Tokens are static and context-independent by design

### Removed

- Responsive utilities and breakpoint logic
- Text scaling helpers
- Context-based spacing and adaptive tokens
- Layout-related abstractions
- UI widgets and component helpers
- Legacy theme builders and default themes

These concerns are intentionally excluded from `fabrik_theme` and may be addressed in separate packages.

### Migration notes

If you were using versions prior to `1.0.0`:

- Replace `FabrikThemeBuilder` with `FabrikTheme.create`
- Replace custom theme accessors with `context.colors` and `context.typography`
- Move responsive, layout, and scaling logic out of `fabrik_theme`
- Use tokens directly for spacing, radius, borders, and elevation

Refer to the documentation at **<https://fabriktool.com>** for migration guidance and updated examples.

---

## 0.1.1

- Added tablet layout handling
- Refined responsive logic based on platform and width

---

## 0.1.0

- Changed breakpoints to layout-based detection
- Updated responsive logic to include `isMobile` and `isDesktop`

---

## 0.0.1

- Initial experimental release
- Color tokens
- Radius tokens
- Spacing and padding tokens
- Elevation tokens
- Typography tokens
- Responsive utilities
- Text scaling utilities
- Theme builders and default themes
