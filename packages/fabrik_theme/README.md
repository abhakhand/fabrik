
# Fabrik Theme

`fabrik_theme` is the design foundation of the Fabrik UI system. It provides a complete set of design tokens and utilities for theming, layout, and responsive design — allowing you to build consistent, scalable Flutter apps with minimal effort.

---

## ✨ Features

- 🎨 **Design Tokens** for colors, spacing, radius, elevation, and icon sizes
- 🔠 **Typography system** with responsive scaling and theme aware colors
- 📱 **Responsive utilities** to adapt UI across layouts (Mobile/Desktop)
- 🎯 **Theme builder** for generating a `ThemeData` using Fabrik tokens

---

## 📦 Installation

```yaml
dependencies:
  fabrik_theme: ^<latest-version>
```

---

## 🚀 Usage

### 1. Import the theme in your app

```dart
import 'package:fabrik_theme/fabrik_theme.dart';
```

### 2. Apply the theme in `MaterialApp`

```dart
MaterialApp(
  themeMode: ThemeMode.system,
  theme: FabrikThemeBuilder.light(),
  darkTheme: FabrikThemeBuilder.dark(),
  home: MyHomePage(),
);
```

---

## 🎨 Design Tokens

Access token values anywhere in your app:

```dart
FabrikSpacing.x4
FabrikRadius.r4
```

Access colors and typography through FabrikTheme

```dart
final theme = FabrikTheme.of(context);

Text(
  'Fabrik Typography.',
  theme.typography.bodyLarge.copyWith(
    color: theme.colors.primary,
  ),
),
```

---

## 📱 Responsive Helpers

Use layouts to build adaptive layouts:

```dart
final isMobile = FabrikResponsive.isMobile(context);
```

---

## Documentation

For full documentation and usage examples visit [fabriktool.com](https://fabriktool.com)

---

## Contributing

PRs welcome! Let's build a thoughtful, developer-friendly Flutter design system together.

---

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
