class Weekdays {
  const Weekdays({
    this.monday = 'Mon',
    this.tuesday = 'Tue',
    this.wednesday = 'Wed',
    this.thursday = 'Thu',
    this.friday = 'Fri',
    this.saturday = 'Sat',
    this.sunday = 'Sun',
  });

  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  List<String> get list => [
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
        sunday,
      ];

  @override
  bool operator ==(covariant Weekdays other) {
    if (identical(this, other)) return true;

    return other.monday == monday &&
        other.tuesday == tuesday &&
        other.wednesday == wednesday &&
        other.thursday == thursday &&
        other.friday == friday &&
        other.saturday == saturday &&
        other.sunday == sunday;
  }

  @override
  int get hashCode {
    return monday.hashCode ^
        tuesday.hashCode ^
        wednesday.hashCode ^
        thursday.hashCode ^
        friday.hashCode ^
        saturday.hashCode ^
        sunday.hashCode;
  }

  Weekdays copyWith({
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
    String? sunday,
  }) {
    return Weekdays(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }
}
