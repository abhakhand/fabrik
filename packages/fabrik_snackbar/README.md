# fabrik_snackbar

`ScaffoldMessenger` requires a `Scaffold`, shows one snackbar at a time, and
gives you limited control over placement and animation.

`fabrik_snackbar` renders into the root `Overlay` instead — no `Scaffold`
requirement, snackbars that survive navigation, and top-or-bottom placement.

```dart
FabrikSnackbar.success(context, title: 'Saved');
FabrikToast.show(context, message: 'Copied to clipboard');
```

[![pub.dev](https://img.shields.io/pub/v/fabrik_snackbar.svg)](https://pub.dev/packages/fabrik_snackbar)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

![Fabrik Snackbar Demo](https://github.com/abhakhand/fabrik/blob/main/packages/fabrik_snackbar/assets/demo.gif?raw=true)

---

## Features

- Four prebuilt types: **success, error, info, warning**
- Lightweight **Toast** for simple inline messages
- Flexible content — plain text, rich text (`TextSpan`), or custom widgets
- Top / bottom positioning with **safe area** support
- Optional full-screen barrier with blur for modal-style feedback
- No setup, no extensions, no init code — just call it

---

## Installation

```yaml
dependencies:
  fabrik_snackbar: ^0.1.8
```

```sh
flutter pub get
```

---

## Quick Start

### Snackbars

`title` and `message` are both optional — provide whichever makes sense:

```dart
FabrikSnackbar.success(context, title: 'Saved!');

FabrikSnackbar.error(context, message: 'Something went wrong.');

FabrikSnackbar.warning(context, title: 'Heads up', message: 'Low storage.');

FabrikSnackbar.info(context, message: 'Syncing in the background…');
```

### Toast

```dart
FabrikToast.show(context, message: 'Copied to clipboard');
```

---

## Customization

Every detail is configurable via `FabrikSnackbarConfig`:

```dart
FabrikSnackbar.custom(
  context,
  config: FabrikSnackbarConfig(
    title: 'Order placed',
    message: 'Your items will arrive in 2–3 days.',
    icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
    backgroundColor: Colors.indigo,
    position: FabrikSnackbarPosition.top,
    duration: const Duration(seconds: 5),
    borderRadius: BorderRadius.circular(16),
    actionButton: TextButton(
      onPressed: () {},
      child: const Text('View', style: TextStyle(color: Colors.white)),
    ),
    onTap: () => debugPrint('snackbar tapped'),
  ),
);
```

### Styling the text

Plain-string `title` and `message` can be styled directly, without swapping
them for custom widgets:

```dart
FabrikSnackbar.success(
  context,
  title: 'Saved',
  message: 'Your changes are live.',
  titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  messageStyle: const TextStyle(color: Colors.white70),
);
```

Omit them and you get `FabrikSnackbarDefaults.defaultTitleStyle` and
`defaultMessageStyle`.

Toast is just as flexible:

```dart
FabrikToast.show(
  context,
  message: 'Link copied',
  icon: Icons.link,
  position: FabrikToastPosition.top,
  backgroundColor: Colors.black87,
);
```

---

## Documentation

Full API reference, guides, and the reasoning behind the design at
**[fabriktool.com](https://www.fabriktool.com)**.

- [Choosing a package](https://www.fabriktool.com/choosing-a-package/) — which package solves which problem
- [Core concepts](https://www.fabriktool.com/core-concepts/) — the patterns shared across the toolkit
- [`fabrik_snackbar` reference](https://www.fabriktool.com/packages/fabrik_snackbar/)

---

## Part of Fabrik

`fabrik_snackbar` is part of [Fabrik](https://github.com/abhakhand/fabrik), a
Flutter toolkit whose packages are independent — use this one on its own, or
reach for others as you need them.

| Package | Solves |
| --- | --- |
| [`fabrik_theme`](https://pub.dev/packages/fabrik_theme) | Semantic colors and typography |
| [`fabrik_result`](https://pub.dev/packages/fabrik_result) | Typed failures worth surfacing to the user |

---

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/abhakhand/fabrik). Changes are documented in
[CHANGELOG.md](CHANGELOG.md), with a migration note for anything breaking.

## License

[MIT](https://github.com/abhakhand/fabrik/blob/main/LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
