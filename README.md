<div align="center">

# Fabrik

**A Flutter toolkit for the parts of an app you build every time.**

[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)
[![docs](https://img.shields.io/badge/docs-fabriktool.com-60A5FA.svg)](https://www.fabriktool.com)

[Documentation](https://www.fabriktool.com) · [Choosing a package](https://www.fabriktool.com/choosing-a-package/) · [Core concepts](https://www.fabriktool.com/core-concepts/)

</div>

---

Every Flutter app needs some version of the same things: a theming system,
responsive layout, form validation, a snackbar, a way to return errors, and a
handful of string and date helpers.

Most teams rebuild these each time, slightly differently. Fabrik is that layer —
written once, tested properly, and published as independent packages you can
adopt one at a time.

## Packages

| Package | pub.dev | Solves |
| --- | --- | --- |
| [`fabrik_theme`](packages/fabrik_theme) | [![pub](https://img.shields.io/pub/v/fabrik_theme.svg?label=%20)](https://pub.dev/packages/fabrik_theme) | Semantic colors and typography instead of scattered `Color(0xFF…)` literals |
| [`fabrik_layout`](packages/fabrik_layout) | [![pub](https://img.shields.io/pub/v/fabrik_layout.svg?label=%20)](https://pub.dev/packages/fabrik_layout) | One UI across phone, tablet and desktop without ad-hoc width checks |
| [`fabrik_forms`](packages/fabrik_forms) | [![pub](https://img.shields.io/pub/v/fabrik_forms.svg?label=%20)](https://pub.dev/packages/fabrik_forms) | Form state and validation that lives outside your widgets, so it can be tested |
| [`fabrik_snackbar`](packages/fabrik_snackbar) | [![pub](https://img.shields.io/pub/v/fabrik_snackbar.svg?label=%20)](https://pub.dev/packages/fabrik_snackbar) | Snackbars and toasts with no `Scaffold` requirement |
| [`fabrik_utils`](packages/fabrik_utils) | [![pub](https://img.shields.io/pub/v/fabrik_utils.svg?label=%20)](https://pub.dev/packages/fabrik_utils) | The helpers every app hand-rolls: `timeAgo`, casing, debounce, throttle |
| [`fabrik_result`](packages/fabrik_result) | [![pub](https://img.shields.io/pub/v/fabrik_result.svg?label=%20)](https://pub.dev/packages/fabrik_result) | Failures visible in the type signature, in pure Dart |

Nothing here depends on anything else. Install what solves your problem and
ignore the rest.

```yaml
dependencies:
  fabrik_theme: ^1.1.0
  fabrik_layout: ^1.2.0
```

## Tooling

| | Description |
| --- | --- |
| [`fabrik`](fabrik) | A CLI for scaffolding feature folders using a layered architecture |

## Repository layout

```text
packages/      Published Flutter and Dart packages
fabrik/        The Fabrik CLI, published to pub.dev as `fabrik`
bricks/        Mason bricks used by the CLI
apps/website/  Documentation site (Astro + Starlight)
```

## Design principles

**Semantic over literal.** `context.colors.error` says why a color was chosen;
`Colors.red` only says what it is. Names that carry meaning survive redesigns.

**Independent packages.** Splitting the toolkit means you never ship code you do
not use. A package that only needs `Either` should not pull in a theming system.

**Fail loudly, with a fix.** Where a mistake cannot be caught by the type
system, it becomes an error that names the solution — an unknown form field
lists the valid keys, a missing theme extension names the factory to call.

**Testable without widgets.** Form state, validation and results are plain Dart
objects. Business rules should not need a `WidgetTester`.

**Defaults that work, everything replaceable.** Get something on screen first,
learn the full API when you need it.

## Contributing

Issues and pull requests are welcome. Each package is self-contained:

```bash
cd packages/fabrik_theme
flutter pub get
flutter test
flutter analyze
```

`fabrik_result` is pure Dart, so it uses `dart` rather than `flutter` for the
same commands.

Please keep the test suite green and add coverage for behaviour changes. Every
package documents its own changes in a `CHANGELOG.md`, with a migration note for
anything breaking.

## License

[MIT](LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
