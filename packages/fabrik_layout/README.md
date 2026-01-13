# fabrik_layout

A lightweight, opinionated layout and responsiveness foundation for Flutter applications.

`fabrik_layout` provides a simple and predictable way to understand **what kind of screen your app is running on** (mobile, tablet, desktop) and optionally apply **safe, global text scaling**, without introducing layout widgets, UI abstractions, or performance pitfalls.

This package focuses on layout context, not UI composition.

---

## Learn more

Detailed documentation, guides, and design rationale are available at  
**<https://fabriktool.com>**

---

## Overview

The goal of `fabrik_layout` is to make responsive decisions **explicit and centralized**.

It encourages:

- Clear device categorization (mobile, tablet, desktop)
- Layout decisions based on constraints, not platform checks
- Optional, controlled text scaling
- Zero global state and no widget-level calculations

The package is intentionally small and framework-aligned.

---

## What this package provides

### Layout context

A single widget, `FabrikLayout`, computes layout information once and exposes it via `BuildContext`.

```dart
if (context.layout.isTablet) {
  // Tablet-specific UI
}
```

### Device classification

Responsive behavior is derived from width-based breakpoints:

- Mobile
- Tablet
- Desktop

Defaults are provided and can be overridden if needed.

### Optional text scaling

`fabrik_layout` can optionally apply conservative, device-aware text scaling using Flutter’s `TextScaler` API.

Scaling is:

- Opt-in
- Applied via `MediaQuery`
- Fully compatible with accessibility settings

---

## Installation

```yaml
dependencies:
  fabrik_layout: ^1.0.0
```

---

## Basic usage

### Wrap your app once

`FabrikLayout` must be placed inside `MaterialApp.builder` or `CupertinoApp.builder`.

```dart
MaterialApp(
  builder: (context, child) {
    return FabrikLayout(
      enableTextScaling: true,
      child: child!,
    );
  },
  home: const HomePage(),
);
```

---

### Consume layout information

```dart
if (context.layout.isMobile) {
  return const MobileView();
}

if (context.layout.isTablet) {
  return const TabletView();
}

return const DesktopView();
```

---

### Use with theming

`fabrik_layout` works independently, but pairs naturally with `fabrik_theme`.

```dart
Text(
  'Dashboard',
  style: context.layout.isMobile
      ? context.typography.titleMedium
      : context.typography.titleLarge,
);
```

Layout controls structure.  
Theme controls appearance.

---

## Text scaling

When enabled, text scaling is applied globally via `MediaQuery`.

```dart
FabrikLayout(
  enableTextScaling: true,
  child: child,
);
```

All `Text` widgets automatically respect scaling.  
No theme mutation or manual font size adjustments are required.

---

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
