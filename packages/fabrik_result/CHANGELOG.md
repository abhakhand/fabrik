# Changelog

All notable changes to this package are documented in this file.

The format is based on **Keep a Changelog**, and this project adheres to **semantic versioning**.

---

## 1.0.1

- **Fix:** Added `==` and `hashCode` to `Left`, `Right`, `Some`, and `None` — value equality was broken (`right(42) == right(42)` previously returned `false`)
- **Fix:** Removed Flutter as a runtime dependency — `fabrik_result` is pure Dart and now works in any Dart project, not just Flutter apps
- Added equality test coverage for all four types

---

## 1.0.0

This is a **major, stabilizing release** that defines the long-term scope and philosophy of `fabrik_result`.

The package has been refined to provide a minimal, explicit, and predictable result-handling toolkit for Dart and Flutter applications, without introducing unnecessary functional abstractions.

### Added

- `Either<L, R>` for explicit success and failure modeling
  - `Left` and `Right` sealed variants
  - `fold` for exhaustive handling
  - Convenience helpers for common access patterns:
    - `onRight`
    - `onLeft`
    - `rightOrNull`
    - `leftOrNull`
- `Option<T>` for modeling presence or absence of a value
  - `Some` and `None` sealed variants
  - `fold`, `isSome`, and `isNone`
  - Factory helpers `some()` and `none()`
- `Unit` type as a typed replacement for `void`
  - Singleton `unit` instance for ergonomic usage
- Comprehensive documentation and examples
- Full test coverage for all core types

---

## 0.1.1

- Fixed repository URL
- Minor documentation corrections

---

## 0.1.0

- Initial public release
- Introduced `Either<L, R>` with `Left`, `Right`, and `fold`
- Introduced `Unit` as a typed alternative to `void`
