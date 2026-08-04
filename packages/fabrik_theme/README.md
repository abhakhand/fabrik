# fabrik_theme

Flutter's `ThemeData` covers Material's own widgets, but says nothing about
*your* app's roles — the color of a helper label, the style of an emphasised
value in a list row.

`fabrik_theme` adds a semantic layer on top: define colors and text styles once,
by meaning, and read them anywhere through `context`.

```dart
Text('Payment failed', style: TextStyle(color: context.colors.error))
Text('Last updated', style: context.typography.bodySmallSecondary)
```

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
  fabrik_theme: ^1.1.0
```

```sh
flutter pub get
```

---

## Quick Start

### 1. Define your colors

To try the package out, start with the built-in palettes and skip this step
entirely:

```dart
AppColors.defaults()      // light
AppColors.darkDefaults()  // dark
```

For a real app, define your own semantic roles:

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
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),
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
    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),
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

// Failure states have a semantic color too
Text(
  'Something went wrong',
  style: context.typography.bodyMedium.copyWith(
    color: context.colors.error,
  ),
)
```

`error` and `onError` are optional in the constructor and fall back to
`ColorTokens.error` / `onError`, so existing palettes keep working. They are
also fed into Material's `ColorScheme`, so framework widgets and your own error
styling stay in sync.

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

Full API reference, guides, and the reasoning behind the design at
**[fabriktool.com](https://www.fabriktool.com)**.

- [Choosing a package](https://www.fabriktool.com/choosing-a-package/) — which package solves which problem
- [Core concepts](https://www.fabriktool.com/core-concepts/) — the patterns shared across the toolkit
- [`fabrik_theme` reference](https://www.fabriktool.com/packages/fabrik_theme/)

---

## Part of Fabrik

`fabrik_theme` is part of [Fabrik](https://github.com/abhakhand/fabrik), a Flutter
toolkit whose packages are independent — use this one on its own, or reach for
others as you need them.

| Package | Solves |
| --- | --- |
| [`fabrik_layout`](https://pub.dev/packages/fabrik_layout) | Responsive breakpoints and adaptive values |
| [`fabrik_snackbar`](https://pub.dev/packages/fabrik_snackbar) | Snackbars and toasts with no `Scaffold` requirement |

---

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/abhakhand/fabrik). Changes are documented in
[CHANGELOG.md](CHANGELOG.md), with a migration note for anything breaking.

## License

[MIT](https://github.com/abhakhand/fabrik/blob/main/LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
