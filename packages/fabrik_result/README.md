# fabrik_result

A minimal and lightweight result-handling toolkit for real-world Dart and Flutter apps.

This package provides:

- A sealed `Either<L, R>` type to model success/failure without using try-catch
- A `Unit` type to represent a typed `void` for functional-style APIs

## Philosophy

`fabrik_result` is built for **clarity, simplicity, and real usage** in domain-driven apps.  
It provides only what you need, making it extremely lightweight.

## Installation

```sh
dart pub add fabrik_result
```

## Usage

### Either

```dart
Either<Failure, User> result = await getUser();

result.fold(
  (failure) => handleError(failure),
  (user) => handleSuccess(user),
);
```

### Unit

```dart
Either<Failure, Unit> result = await save();

result.fold(
  (failure) => showError(failure),
  (_) => showSuccessToast(),
);

```
