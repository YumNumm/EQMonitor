enum EarthquakeActivityBinInterval {
  oneHour(duration: Duration(hours: 1), label: '1時間'),
  sixHours(duration: Duration(hours: 6), label: '6時間'),
  oneDay(duration: Duration(days: 1), label: '1日'),
  oneWeek(duration: Duration(days: 7), label: '1週間');

  const EarthquakeActivityBinInterval({
    required this.duration,
    required this.label,
  });

  final Duration duration;
  final String label;

  static EarthquakeActivityBinInterval forDuration(Duration duration) {
    if (duration <= const Duration(hours: 24)) {
      return .oneHour;
    }
    if (duration <= const Duration(days: 8)) {
      return .sixHours;
    }
    if (duration <= const Duration(days: 30)) {
      return .oneDay;
    }
    return .oneWeek;
  }

  DateTime align(DateTime value) {
    final utc = value.toUtc();
    return switch (this) {
      .oneHour => DateTime.utc(utc.year, utc.month, utc.day, utc.hour),
      .sixHours => DateTime.utc(
        utc.year,
        utc.month,
        utc.day,
        utc.hour ~/ 6 * 6,
      ),
      .oneDay => DateTime.utc(utc.year, utc.month, utc.day),
      .oneWeek => DateTime.utc(
        utc.year,
        utc.month,
        utc.day,
      ).subtract(Duration(days: utc.weekday - DateTime.monday)),
    };
  }
}
