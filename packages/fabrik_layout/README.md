# fabrik_layout

Responsive Flutter code tends to accumulate `MediaQuery.of(context).size.width >
600` checks, each with its own slightly different threshold.

`fabrik_layout` resolves the width once, classifies it, and exposes the result
anywhere below.

```dart
if (context.layout.isMobile) { ... }

final columns = context.layout.value<int>(mobile: 1, tablet: 2, desktop: 3);
```

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
  fabrik_layout: ^1.2.0
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
| Desktop | 1024 – 1439 |
| Large desktop | ≥ 1440 |

Each breakpoint value names the **upper bound** of the category below it, so
`FabrikBreakpoints(mobile: 480, tablet: 768)` means "mobile is under 480" and
"tablet runs from 480 to 767".

Most apps only care about "desktop and above" — use `isDesktopOrWider` for that,
and treat `largeDesktop` as an opt-in refinement:

```dart
if (context.layout.isDesktopOrWider) {
  // desktop and large desktop
}

final columns = context.layout.value<int>(
  mobile: 1,
  tablet: 2,
  desktop: 3,
  // largeDesktop omitted -> reuses the desktop value
);
```

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

Override the defaults (mobile 1.0×, tablet 1.05×, desktop 1.1×; large desktop reuses the desktop floor unless set):

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

Full API reference, guides, and the reasoning behind the design at
**[fabriktool.com](https://www.fabriktool.com)**.

- [Choosing a package](https://www.fabriktool.com/choosing-a-package/) — which package solves which problem
- [Core concepts](https://www.fabriktool.com/core-concepts/) — the patterns shared across the toolkit
- [`fabrik_layout` reference](https://www.fabriktool.com/packages/fabrik_layout/)

---

## Part of Fabrik

`fabrik_layout` is part of [Fabrik](https://github.com/abhakhand/fabrik), a Flutter
toolkit whose packages are independent — use this one on its own, or reach for
others as you need them.

| Package | Solves |
| --- | --- |
| [`fabrik_theme`](https://pub.dev/packages/fabrik_theme) | Semantic colors and typography |
| [`fabrik_utils`](https://pub.dev/packages/fabrik_utils) | Everyday extensions and helpers |

---

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/abhakhand/fabrik). Changes are documented in
[CHANGELOG.md](CHANGELOG.md), with a migration note for anything breaking.

## License

[MIT](https://github.com/abhakhand/fabrik/blob/main/LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
