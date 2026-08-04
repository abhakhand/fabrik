# fabrik_utils

A lightweight, real-world-first utility toolkit for Flutter apps.

[![pub.dev](https://img.shields.io/pub/v/fabrik_utils.svg)](https://pub.dev/packages/fabrik_utils)
[![license](https://img.shields.io/github/license/abhakhand/fabrik)](https://github.com/abhakhand/fabrik/blob/main/LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-02569B.svg?logo=flutter)](https://flutter.dev)

---

## What's included

| API | What it does |
| --- | --- |
| **`DateTimeX`** | Formatters, checkers, `timeAgo`, date math |
| **`StringX` / `FabrikCasing`** | 10 case conversions, `isNullOrBlank`, `capitalizeFirst` |
| **`formatDuration`** | Format a `Duration` as `HH:mm:ss` or `mm:ss` |
| **`splitDuration`** | Split seconds into padded `(hours, minutes, seconds)` record |
| **`Throttle<T>`** | Stream-backed throttler with `ThrottleStatus` |
| **`Debounce<T>`** | Stream-backed debouncer with `cancel()` and `maxWait` |
| **`isApproachingScrollEnd`** | Detect when a list is near the bottom |

---

## Installation

```yaml
dependencies:
  fabrik_utils: ^0.1.0
```

```sh
flutter pub get
```

---

## Usage

### String casing

```dart
'hello world'.titleCase      // "Hello World"
'helloWorld'.snakeCase       // "hello_world"
'user_name'.camelCase        // "userName"
'http_request'.pascalCase    // "HttpRequest"
'Hello World'.kebabCase      // "hello-world"
'Hello World'.constantCase   // "HELLO_WORLD"

// Acronyms stay intact
'XMLHttpRequest'.snakeCase   // "xml_http_request"
'APIKey'.snakeCase           // "api_key"
'parseJSON'.camelCase        // "parseJson"

// Null safety
String? value = null;
value.isNullOrBlank          // true
```

### DateTime

```dart
DateTime.now().isToday       // true
DateTime.now().isWeekend     // false (on a weekday)
// Relative time, in both directions
pastDate.timeAgo             // "3 hours ago" / "yesterday" / "1 month ago"
futureDate.timeAgo           // "in 3 hours" / "tomorrow" / "in 2 days"

// Formatters
date.isoDate                 // "2024-06-15"
date.dayMonthYear            // "15 Jun 2024"
date.fullWithWeekday         // "Saturday, June 15, 2024"
date.time12Hour              // "2:30 PM"
date.hourMinute24h           // "14:30"

// Date math
date.startOfDay              // 2024-06-15 00:00:00.000
date.endOfDay                // 2024-06-15 23:59:59.999
date.startOfWeek             // Monday of that week

// Range check
date.isBetween(start, end)   // true if start <= date <= end
```

### Duration

```dart
formatDuration(Duration(seconds: 3665))          // "01:01:05"
formatDuration(Duration(minutes: 4, seconds: 5)) // "04:05"
formatDuration(Duration(seconds: 90), alwaysShowHours: true) // "00:01:30"

// Negative durations render with a sign, for countdowns that overshoot zero
formatDuration(Duration(seconds: -65))           // "-01:05"

final parts = splitDuration(3665);
parts.hours    // "01"
parts.minutes  // "01"
parts.seconds  // "05"
```

### Throttle

```dart
final throttle = Throttle<void>(duration: Duration(seconds: 1));

throttle.throttle(() {
  print('Runs at most once per second');
});

// Stream-based status
throttle.listen((status) {
  print(status); // "idle" or "busy"
});

throttle.close();
```

### Debounce

```dart
final debounce = Debounce<void>(duration: Duration(milliseconds: 300));

// Basic usage — fires after 300ms of inactivity
debounce.debounce(() => search(query));

// With maxWait — fires after at most 1 second regardless of call frequency
final debounce = Debounce<void>(
  duration: Duration(milliseconds: 300),
  maxWait: Duration(seconds: 1),
);

// Cancel a pending call without closing the stream
debounce.cancel();

// Stream-based status
debounce.listen((status) {
  print(status); // "idle" or "waiting"
});

debounce.close();
```

### Scroll

```dart
scrollController.addListener(() {
  if (isApproachingScrollEnd(scrollController)) {
    loadNextPage();
  }
});

// Custom threshold — trigger at 90% instead of default 70%
isApproachingScrollEnd(controller, scrollOffsetThreshold: 0.9)
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
