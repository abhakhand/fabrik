# fabrik_result

A `Future<User>` tells you nothing about what can go wrong. The caller finds out
at runtime, or reads the implementation, or wraps everything in `try`/`catch`
and hopes.

```dart
Future<Either<Failure, User>> getUser(String id);
```

Now the signature *is* the documentation, and the compiler makes sure the
failure case is handled.

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
  fabrik_result: ^1.1.0
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

Because `Either` is a `sealed` class, you can also pattern match on it and the
compiler will tell you if you miss a case — no `default` branch needed:

```dart
final message = switch (result) {
  Left(value: final failure) => 'Failed: ${failure.message}',
  Right(value: final user) => 'Welcome, ${user.name}',
};
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

### Capture exceptions at the boundary

`tryCatch` and `tryCatchAsync` replace that hand-written try/catch:

```dart
Future<Either<Failure, User>> getUser(String id) {
  return Either.tryCatchAsync(
    () => api.fetchUser(id),
    (error, stackTrace) => Failure('$error'),
  );
}
```

### Transform and chain

Use `map` to change the success value and `flatMap` to run another fallible
step. A `Left` short-circuits the whole chain, so failures propagate untouched:

```dart
final result = await getUser(id)
    .then((r) => r.map((user) => user.profile))
    .then((r) => r.flatMap(validateProfile));

// Read it back with a fallback:
final name = result.getOrElse((failure) => 'Anonymous');
```

Available on `Either`: `map`, `mapLeft`, `flatMap`, `flatMapAsync`,
`getOrElse`, `swap`.

### Option — model absence without null

```dart
Option<User> cached = findCachedUser();

cached.fold(
  () => showLoginScreen(),
  (user) => showDashboard(user),
);
```

`Option` interoperates with Dart's nullable types in both directions, which
makes it useful for loosely typed data such as JSON:

```dart
final name = Option.fromNullable(json['name'] as String?)
    .where((n) => n.isNotEmpty)
    .map((n) => n.trim())
    .getOrElse(() => 'Anonymous');

// And back to a nullable when an API expects one:
final String? raw = cached.map((u) => u.email).toNullable();
```

Turn a missing value into a typed failure with `toEither`:

```dart
Either<Failure, User> result =
    cached.toEither(() => Failure('no cached user'));
```

Available on `Option`: `map`, `flatMap`, `getOrElse`, `where`, `toNullable`,
`toEither`, plus the static `Option.fromNullable`.

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

Full API reference, guides, and the reasoning behind the design at
**[fabriktool.com](https://www.fabriktool.com)**.

- [Choosing a package](https://www.fabriktool.com/choosing-a-package/) — which package solves which problem
- [Core concepts](https://www.fabriktool.com/core-concepts/) — the patterns shared across the toolkit
- [`fabrik_result` reference](https://www.fabriktool.com/packages/fabrik_result/)

---

## Part of Fabrik

`fabrik_result` is part of [Fabrik](https://github.com/abhakhand/fabrik), a Flutter
toolkit whose packages are independent — use this one on its own, or reach for
others as you need them.

| Package | Solves |
| --- | --- |
| [`fabrik_forms`](https://pub.dev/packages/fabrik_forms) | Testable form state and validation |
| [`fabrik_utils`](https://pub.dev/packages/fabrik_utils) | Everyday extensions and helpers |

---

## Contributing

Issues and pull requests are welcome on
[GitHub](https://github.com/abhakhand/fabrik). Changes are documented in
[CHANGELOG.md](CHANGELOG.md), with a migration note for anything breaking.

## License

[MIT](https://github.com/abhakhand/fabrik/blob/main/LICENSE) © [Ashish Bhakhand](https://github.com/abhakhand)
