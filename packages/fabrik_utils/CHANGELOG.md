## 0.2.0

A correctness release. Three helpers produced wrong output for inputs they
accepted without complaint; all three now behave sensibly.

### Fixes

- **Fix**: `formatDuration` no longer emits malformed strings for negative durations — `Duration(seconds: -65)` produced `-1:-5` and now produces `-01:05`. Countdown timers that overshoot zero render correctly.
- **Fix**: `splitDuration` no longer wraps around for negative input — `splitDuration(-65)` returned `(00, 58, 55)` and now returns `(-00, 01, 05)`. The sign is carried on the `hours` component; the record shape is unchanged, so existing destructuring keeps working.
- **Fix**: `timeAgo` now supports future dates. Every future timestamp previously read as `"just now"`, regardless of distance. Dates ahead now read as `"in 5 mins"`, `"in 2 hours"`, `"tomorrow"`, `"in 3 days"`, `"in 1 year"`. Past-date output is unchanged.

### Behaviour change

- **Changed**: `FabrikCasing` now groups runs of consecutive capitals into a single word, so acronyms survive conversion:
  - `'XMLHttpRequest'.snakeCase` → `xml_http_request` (was `x_m_l_http_request`)
  - `'APIKey'.snakeCase` → `api_key` (was `a_p_i_key`)
  - `'parseJSON'.camelCase` → `parseJson` (was `parseJSON`)

  This affects every casing getter. If you relied on the previous
  letter-by-letter splitting, review call sites before upgrading.

### Tests

- Test suite grown from 106 to 149 tests, covering negative durations, future-dated `timeAgo`, and acronym handling.

---

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
