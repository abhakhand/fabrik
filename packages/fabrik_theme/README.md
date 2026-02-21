# fabrik_theme

A lightweight, opinionated theming foundation for Flutter — semantic colors, typography, and design tokens with zero layout or UI concerns.

[![pub.dev](https://img.shields.io/pub/v/fabrik_theme.svg)](https://pub.dev/packages/fabrik_theme)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

## What's included

| Layer | What it does |
| --- | --- |
| **Design tokens** | Static values for color, spacing, radius, border, elevation, typography |
| **`AppColors`** | Semantic color roles as a `ThemeExtension` |
| **`AppTypography`** | Semantic text styles as a `ThemeExtension` |
| **`FabrikTheme.create`** | Single entry point to build a complete `ThemeData` |
| **`context.colors` / `context.typography`** | Ergonomic widget-level access |

---

## Installation

```yaml
dependencies:
  fabrik_theme: ^1.0.2
```

```sh
flutter pub get
```

---

## Quick Start

### 1. Define your colors

```dart
class AppThemeColors {
  static const light = AppColors(
    primary: Color(0xFF6C5CE7),
    onPrimary: Color(0xFFFFFFFF),
    accent: Color(0xFF00CEC9),
    onAccent: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF111111),
    textPrimary: Color(0xFF111111),
    textSecondary: Color(0xFF444444),
    textTertiary: Color(0xFF777777),
  );

  static const dark = AppColors(
    primary: Color(0xFFB4A7FF),
    onPrimary: Color(0xFF1A1A2E),
    accent: Color(0xFF55EFC4),
    onAccent: Color(0xFF003D33),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFCCCCCC),
    textTertiary: Color(0xFF999999),
  );
}
```

### 2. Create the theme

```dart
MaterialApp(
  theme: FabrikTheme.create(
    brightness: Brightness.light,
    colors: AppThemeColors.light,
    fontFamily: 'Inter',
  ),
  darkTheme: FabrikTheme.create(
    brightness: Brightness.dark,
    colors: AppThemeColors.dark,
    fontFamily: 'Inter',
  ),
);
```

Typography is generated automatically from the colors unless you pass a custom `AppTypography`.

### 3. Consume in widgets

```dart
// Colors
Container(color: context.colors.surface)

// Typography
Text('Welcome', style: context.typography.headlineMedium)
Text('Subtitle', style: context.typography.bodyMediumSecondary)
Text('Action', style: context.typography.labelLarge)
```

---

## Design Tokens

Tokens are static and never require `BuildContext`:

```dart
Padding(padding: EdgeInsets.all(SpacingTokens.lg))         // 16
BorderRadius.circular(RadiusTokens.md)                     // 12
Border.all(width: BorderTokens.thin)                       // 1
PhysicalModel(elevation: ElevationTokens.sm)               // 3
```

---

## Typography Variants

Each scale has semantic variants:

| Suffix | Color role |
| --- | --- |
| *(none)* | `textPrimary` — high emphasis |
| `Secondary` | `textSecondary` — supporting content |
| `Tertiary` | `textTertiary` — low emphasis |
| `Primary` | brand `primary` — accent emphasis |
| `Emphasis` | `textPrimary` + `FontWeight.w500` |

```dart
context.typography.bodyMedium           // primary color
context.typography.bodyMediumSecondary  // secondary color
context.typography.bodyMediumTertiary   // tertiary color
context.typography.titleLargePrimary    // brand accent color
context.typography.bodyLargeEmphasis    // bold primary
```

---

## Documentation

Full API reference and guides at **[fabriktool.com](https://www.fabriktool.com)**

---

## Contributing

Found a bug or have a suggestion?
Open an issue or pull request on [GitHub](https://github.com/abhakhand/fabrik).

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
