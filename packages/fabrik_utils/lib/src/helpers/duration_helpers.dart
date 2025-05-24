/// Formats a [Duration] into a readable string.
///
/// Example outputs:
/// - `01:23:45`
/// - `04:05`
String formatDuration(Duration duration, {bool alwaysShowHours = false}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  if (hours > 0 || alwaysShowHours) {
    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  } else {
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}

/// Converts an integer duration in seconds into a `(HH, mm, ss)` tuple of padded strings.
///
/// Useful when you need separate components for display (e.g., for custom timers or UI segments).
///
/// Example:
/// ```dart
/// final (h, m, s) = splitDuration(3665);
/// print('$h:$m:$s'); // 01:01:05
/// ```
({String hours, String minutes, String seconds}) splitDuration(
  int totalSeconds,
) {
  final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
  final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
  final seconds = (totalSeconds % 60).toString().padLeft(2, '0');

  return (hours: hours, minutes: minutes, seconds: seconds);
}
