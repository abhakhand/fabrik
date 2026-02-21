# fabrik_layout

A lightweight, opinionated layout and responsiveness foundation for Flutter.

[![pub.dev](https://img.shields.io/pub/v/fabrik_layout.svg)](https://pub.dev/packages/fabrik_layout)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

## What's included

| API | What it does |
| --- | --- |
| **`FabrikLayout`** | Root widget — classifies device, provides layout context |
| **`context.layout`** | Ergonomic access to layout snapshot anywhere in the tree |
| **`FabrikLayoutData`** | Immutable snapshot: type, orientation, screen size, text scaler |
| **`FabrikBreakpoints`** | Customizable width thresholds for device classification |
| **`FabrikTextScaleConfig`** | Optional per-device text scale floors |

---

## Installation

```yaml
dependencies:
  fabrik_layout: ^1.1.0
```

```sh
flutter pub get
```

---

## Quick start

### 1. Wrap your app once

Place `FabrikLayout` inside `MaterialApp.builder`:

```dart
MaterialApp(
  builder: (context, child) {
    return FabrikLayout(child: child!);
  },
  home: const HomePage(),
)
```

### 2. Use layout context anywhere

```dart
// Device classification
if (context.layout.isMobile) return const MobileView();
if (context.layout.isTablet) return const TabletView();
return const DesktopView();

// Orientation
if (context.layout.isLandscape) {
  // side-by-side layout
}

// Responsive values — mobile required, tablet/desktop fall back gracefully
final padding = context.layout.value<double>(
  mobile: 8,
  tablet: 16,
  desktop: 24,
);
```

---

## Breakpoints

Default thresholds (logical pixels):

| Category | Width |
| --- | --- |
| Mobile | < 600 |
| Tablet | 600 – 1023 |
| Desktop | ≥ 1024 |

Override them if needed:

```dart
FabrikLayout(
  breakpoints: const FabrikBreakpoints(mobile: 480, tablet: 768),
  child: child!,
)
```

---

## Text scaling

Optional, opt-in. Applies a per-device minimum scale floor via `MediaQuery` — the system's accessibility scale is never reduced, only raised.

```dart
FabrikLayout(
  enableTextScaling: true,
  child: child!,
)
```

Override the defaults (mobile 1.0×, tablet 1.05×, desktop 1.1×):

```dart
FabrikLayout(
  enableTextScaling: true,
  textScaleConfig: const FabrikTextScaleConfig(
    mobile: 1.0,
    tablet: 1.08,
    desktop: 1.15,
  ),
  child: child!,
)
```

---

## Use with theming

`fabrik_layout` pairs naturally with `fabrik_theme`:

```dart
Text(
  'Dashboard',
  style: context.layout.isMobile
      ? context.typography.titleMedium
      : context.typography.titleLarge,
)
```

Layout controls structure. Theme controls appearance.

---

## Documentation

Full API reference and guides at **[fabriktool.com](https://www.fabriktool.com)**

---

## Contributing

Found a bug or have a suggestion?
Open an issue or pull request on [GitHub](https://github.com/abhakhand/fabrik).

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
