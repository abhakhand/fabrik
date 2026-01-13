# fabrik_result

A lightweight, explicit result-handling foundation for Dart and Flutter applications.

`fabrik_result` provides small, focused primitives for modeling **success**, **failure**, and **absence of values** without relying on exceptions, nulls, or heavy functional abstractions.

This package focuses on clarity, predictability, and real-world usage.

---

## Learn more

Detailed documentation and examples are available at  
**<https://fabriktool.com>**

---

## Overview

The goal of `fabrik_result` is to make failure and absence **explicit** in application code.

It encourages:

- Clear success and failure modeling
- Explicit domain boundaries
- Predictable control flow
- Typed APIs without `try-catch` or nullable ambiguity

The package is intentionally minimal and avoids introducing a full functional programming framework.

---

## What this package provides

### Result types

Core primitives for modeling outcomes:

- `Either<L, R>`  
  Represents either a failure (`Left`) or a success (`Right`)

- `Option<T>`  
  Represents the presence (`Some`) or absence (`None`) of a value

- `Unit`  
  A typed replacement for `void` when no meaningful value is returned

---

## Installation

```yaml
dependencies:
  fabrik_result: ^1.0.0
```

---

## Basic usage

### Either

Use `Either` when an operation can fail for expected reasons and the caller must handle it explicitly.

```dart
Either<Failure, User> result = await getUser();

result.fold(
  (failure) => handleError(failure),
  (user) => handleSuccess(user),
);
```

---

### Option

Use `Option` when a value may or may not exist, and `null` would be ambiguous or unsafe.

```dart
Option<User> user = findCachedUser();

user.fold(
  () => showLogin(),
  (u) => showDashboard(u),
);
```

---

### Unit

Use `Unit` when an operation returns no meaningful data but must still be typed.

```dart
Either<Failure, Unit> result = await saveSettings();

result.fold(
  (failure) => showError(failure),
  (_) => showSuccessToast(),
);
```

This avoids mixing `void` with typed APIs and keeps function signatures consistent.

---

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
