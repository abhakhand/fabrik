# fabrik_theme

A lightweight, opinionated theming foundation for Flutter applications.

`fabrik_theme` helps you define and consume **colors**, **typography**, and **design tokens** in a consistent, scalable, and predictable way, without mixing UI widgets, layout concerns, or responsiveness into the theming layer.

This package focuses on fundamentals and stays intentionally small.

---

## Learn more

Detailed documentation, guides, and rationale are available at  
**<https://fabriktool.com>**

---

## Overview

The goal of `fabrik_theme` is to provide a **clear design language layer** for Flutter apps.

It encourages:

- Semantic colors and typography
- Centralized theme construction
- Predictable usage in widgets
- Strong separation between design tokens and UI components

---

## What this package provides

### Design tokens

Static, context-independent values that describe your design system:

- `ColorTokens`
- `TypographyTokens`
- `SpacingTokens`
- `RadiusTokens`
- `BorderTokens`
- `ElevationTokens`

Tokens are accessed directly and never depend on `BuildContext`.

```dart
Padding(
  padding: EdgeInsets.all(SpacingTokens.md),
)
```

---

### Semantic theme extensions

Design semantics are expressed using `ThemeExtension`s:

- `AppColors`
- `AppTypography`

These are resolved once during theme creation and then consumed by widgets.

```dart
Text(
  'Profile',
  style: context.typography.titleMedium,
)
```

---

### Builders

Builders compose raw tokens into usable theme data.

- `FabrikTypographyBuilder` resolves typography using colors and font family
- `FabrikTheme` wires everything into `ThemeData`

Widgets never perform theme composition.

---

## Installation

```yaml
dependencies:
  fabrik_theme: ^1.0.0
```

---

## Basic usage

### Define your colors

```dart
class AppThemeColors {
  static const light = AppColors(
    primary: Color(0xFF6C5CE7),
    accent: Color(0xFF00CEC9),
    textPrimary: Color(0xFF111111),
    textSecondary: Color(0xFF444444),
    textTertiary: Color(0xFF777777),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF6F6F6),
    divider: Color(0xFFE0E0E0),
  );

  static const dark = AppColors(
    primary: Color(0xFFB4A7FF),
    accent: Color(0xFF55EFC4),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFCCCCCC),
    textTertiary: Color(0xFF999999),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    divider: Color(0xFF2C2C2C),
  );
}
```

---

### Create a theme

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

Typography is generated automatically unless explicitly provided.

---

## Using colors and typography

### Colors

```dart
Container(
  color: context.colors.surface,
)
```

### Typography

```dart
Text(
  'Settings',
  style: context.typography.titleMediumPrimary,
)
```

Typography variants are semantic.  
For one-off cases, `copyWith` is fully supported.

---

## Typography philosophy

`fabrik_theme` avoids mechanical permutations.

Instead, it provides:

- Primary variants for display, headlines, and titles
- Secondary and tertiary variants for body text
- Emphasis variants where weight-based emphasis is common

If a styling pattern repeats across the app, it belongs in the system.  
If it is contextual, `copyWith` is appropriate.

---

## Opinionated boundaries

This package intentionally does **not** include:

- Responsive scaling or breakpoints
- Context-based spacing
- Layout or UI widgets
- Component abstractions

These decisions keep the theming layer stable and predictable.

Responsiveness, layout helpers, and components are expected to live in separate packages.

---

## Extensibility

`fabrik_theme` is designed to be extended, not forked.

You can:

- Add your own `ThemeExtension`s
- Build component libraries on top of the tokens
- Layer responsive systems above it
- Replace typography entirely if needed

The package does not lock you into a closed system.

---

## Documentation

This README covers the essentials.

Detailed documentation and examples are available at  
**<https://fabriktool.com>**

---

## Closing note

`fabrik_theme` is intentionally boring in the best way possible.

It favors clarity over cleverness and stability over convenience.  
If you value maintainable UI code, this package is built for you.
