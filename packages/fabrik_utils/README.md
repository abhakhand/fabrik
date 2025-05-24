# Fabrik Utils

`fabrik_utils` is a lightweight, real-world-first utility package for Flutter apps. It includes essential extensions, helpers, and utilities used across real products — crafted to improve DX and save development time.

---

## Features

- 🗓 DateTime extensions (`isToday`, `timeAgo`, `weekdayName`, etc.)
- 🔠 String casing helpers (`camelCase`, `PascalCase`, `titleCase`, etc.)
- 🧼 String validation and formatting (`isNullOrBlank`, `capitalizeFirst`)
- ⏱ Duration formatting and splitting
- 🔁 Debounce & Throttle classes with status stream support
- 🔽 Scroll helpers (`isApproachingScrollEnd`)
- 🔢 Tuple-style time splitting for seconds

---

## Quick Start

### 1. Install

```yaml
dependencies:
  fabrik_utils: ^<latest-version>
```

### 2. Import

```dart
import 'package:fabrik_utils/fabrik_utils.dart';
```

---

## Examples

### ➤ String Casing

```dart
'hello world'.titleCase       // "Hello World"
'FABRIK Utils'.camelCase      // "fabrikUtils"
'this is a test'.snakeCase    // "this_is_a_test"
'TextCase'.kebabCase          // "text-case"
```

### ➤ DateTime

```dart
DateTime.now().isToday         // true
DateTime.now().timeAgo         // "just now"
someDate.fullDateTime          // "September 7, 2025 2:30 PM"
```

### ➤ Duration

```dart
formatDuration(Duration(seconds: 3665))        // "01:01:05"
splitDuration(3665)                            // (hours: "01", minutes: "01", seconds: "05")
```

### ➤ Debounce / Throttle

```dart
final throttle = Throttle<void>(duration: Duration(seconds: 1));
throttle(() => print('Only once per second'));

final debounce = Debounce<void>(duration: Duration(milliseconds: 300));
debounce(() => print('Triggered after pause'));
```

### ➤ Scroll

```dart
isApproachingScrollEnd(scrollController)       // true if near bottom
```

---

## Maintainers

- [Ashish Bhakhand](https://github.com/abhakhand)
