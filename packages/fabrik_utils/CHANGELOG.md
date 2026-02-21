## 0.1.0

- **New**: `Debounce.cancel()` — cancels pending execution without closing the stream
- **New**: `Debounce(maxWait:)` — forces execution after a maximum wait time, regardless of call frequency
- **New**: `DateTime.isBetween(start, end)` — inclusive range check
- **New**: `DateTime.startOfDay` — midnight of the same day
- **New**: `DateTime.endOfDay` — 23:59:59.999 of the same day
- **New**: `DateTime.startOfWeek` — midnight of the most recent Monday
- **Fix**: `timeAgo` month/year calculation now uses 30.44 and 365.25 day averages for more accurate results
- **Fix**: `Debounce._pendingFunc` is now properly typed as `T Function()?` instead of `VoidCallback?`
- **Fix**: `FabrikCasing._extractWords` now filters empty segments defensively
- **Improvement**: `concurrency.dart` no longer imports `package:flutter/material.dart`
- **Tests**: Added full test suite — 106 tests across strings, DateTime, duration, concurrency, and scroll utilities

## 0.0.2

- Updated dart and packages

## 0.0.1

- DateTime extensions (`isToday`, `isWeekend`, `timeAgo`, etc.)
- String casing system (`FabrikCasing`) and extensions (`camelCase`, `titleCase`, `snakeCase`, etc.)
- `capitalizeFirst` and `isNullOrBlank` for smart string handling
- Duration formatters:
  - `formatDuration` (HH:mm:ss or mm:ss)
  - `splitDuration` (returns hours, minutes, seconds as strings)
- Debounce and Throttle classes with stream-based `Status` updates
- Scroll utility: `isApproachingScrollEnd()`
