# fabrik_result

Lightweight, explicit result types for Dart and Flutter — model success, failure, and absence of values without exceptions or nulls.

[![pub.dev](https://img.shields.io/pub/v/fabrik_result.svg)](https://pub.dev/packages/fabrik_result)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![pure dart](https://img.shields.io/badge/pure-dart-02569B.svg?logo=dart)](https://dart.dev)

---

## What's included

| Type | Purpose |
| --- | --- |
| `Either<L, R>` | Success (`Right`) or failure (`Left`) with exhaustive handling |
| `Option<T>` | Value present (`Some`) or absent (`None`) |
| `Unit` | Typed replacement for `void` in generic APIs |

---

## Installation

```yaml
dependencies:
  fabrik_result: ^1.0.1
```

```sh
flutter pub get
```

---

## Quick Start

### Either — handle failures explicitly

```dart
Either<Failure, User> result = await getUser(id);

result.fold(
  (failure) => showError(failure.message),
  (user) => navigateToDashboard(user),
);
```

Return values using the helper functions:

```dart
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final user = await api.fetchUser(id);
    return right(user);
  } catch (e) {
    return left(Failure(e.toString()));
  }
}
```

### Option — model absence without null

```dart
Option<User> cached = findCachedUser();

cached.fold(
  () => showLoginScreen(),
  (user) => showDashboard(user),
);
```

### Unit — type-safe void

Use `Unit` when an operation succeeds but has nothing meaningful to return:

```dart
Future<Either<Failure, Unit>> saveSettings(Settings s) async {
  try {
    await storage.write(s);
    return right(unit);
  } catch (e) {
    return left(Failure(e.toString()));
  }
}
```

---

## Extras

`Either` also has side-effect helpers for imperative code:

```dart
result.onRight((user) => analytics.track('login'));
result.onLeft((failure) => logger.error(failure));

final user = result.rightOrNull;
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
