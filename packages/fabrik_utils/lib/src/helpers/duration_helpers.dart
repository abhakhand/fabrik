/// Formats a [Duration] into a readable string.
///
/// Negative durations are rendered with a leading minus sign, which matters for
/// countdown timers that overshoot zero.
///
/// Example outputs:
/// - `01:23:45`
/// - `04:05`
/// - `-01:05`
String formatDuration(Duration duration, {bool alwaysShowHours = false}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final isNegative = duration.isNegative;
  final absolute = isNegative ? -duration : duration;
  final sign = isNegative ? '-' : '';

  final hours = absolute.inHours;
  final minutes = absolute.inMinutes.remainder(60);
  final seconds = absolute.inSeconds.remainder(60);

  if (hours > 0 || alwaysShowHours) {
    return '$sign${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  } else {
    return '$sign${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}

/// Converts an integer duration in seconds into a `(HH, mm, ss)` tuple of padded strings.
///
/// Useful when you need separate components for display (e.g., for custom timers or UI segments).
///
/// A negative [totalSeconds] is split by magnitude and the minus sign is carried
/// on the [hours] component, so `splitDuration(-65)` yields `('-00', '01', '05')`.
/// This keeps the components consistent with [formatDuration] rather than
/// producing the wrap-around values Dart's `%` gives for negative operands.
///
/// Example:
/// ```dart
/// final (h, m, s) = splitDuration(3665);
/// print('$h:$m:$s'); // 01:01:05
/// ```
({String hours, String minutes, String seconds}) splitDuration(
  int totalSeconds,
) {
  final isNegative = totalSeconds < 0;
  final absolute = totalSeconds.abs();

  final hours = (absolute ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((absolute % 3600) ~/ 60).toString().padLeft(2, '0');
  final seconds = (absolute % 60).toString().padLeft(2, '0');

  return (
    hours: isNegative ? '-$hours' : hours,
    minutes: minutes,
    seconds: seconds,
  );
}
