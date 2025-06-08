class CalendarDay {
  final DateTime date;
  final bool isStreak;
  final bool isFreeze;
  final bool isToday;
  final bool isDisabled;
  final bool isPlaceholder;

  CalendarDay({
    required this.date,
    this.isStreak = false,
    this.isFreeze = false,
    this.isToday = false,
    this.isDisabled = false,
    this.isPlaceholder = false,
  });

  @override
  bool operator ==(covariant CalendarDay other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.isStreak == isStreak &&
        other.isFreeze == isFreeze &&
        other.isToday == isToday &&
        other.isDisabled == isDisabled &&
        other.isPlaceholder == isPlaceholder;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        isStreak.hashCode ^
        isFreeze.hashCode ^
        isToday.hashCode ^
        isDisabled.hashCode ^
        isPlaceholder.hashCode;
  }
}
