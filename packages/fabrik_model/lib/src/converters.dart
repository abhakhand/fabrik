// Basic DateTime helpers
DateTime timestampToLocal(int ts) =>
    DateTime.fromMillisecondsSinceEpoch(ts).toLocal();

DateTime timestampToUtc(int ts) =>
    DateTime.fromMillisecondsSinceEpoch(ts).toUtc();

int dateTimeToTimestamp(DateTime dt) => dt.millisecondsSinceEpoch;

// Enum helpers
T stringToEnum<T>(String value, List<T> values) =>
    values.firstWhere((e) => e.toString().split('.').last == value);

String enumToString<T>(T e) => e.toString().split('.').last;
