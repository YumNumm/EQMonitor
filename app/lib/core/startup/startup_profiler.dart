/// 起動フェーズごとの所要時間をマイクロ秒で記録する。
///
/// [clockMicros] を注入するとテストで決定的に検証できる。省略時は内部の
/// [Stopwatch] を時刻源に使う。
class StartupProfiler {
  StartupProfiler({int Function()? clockMicros})
    : _clockMicros = clockMicros ?? _defaultClock();

  static int Function() _defaultClock() {
    final stopwatch = Stopwatch()..start();
    return () => stopwatch.elapsedMicroseconds;
  }

  final int Function() _clockMicros;
  final Map<String, int> _timings = {};

  void mark(String phase) => _timings[phase] = _clockMicros();

  void measure(String phase, int micros) => _timings[phase] = micros;

  Map<String, int> get timingsMicros => Map.unmodifiable(_timings);

  Map<String, dynamic> toPayload() => {
    'phases': Map<String, int>.from(_timings),
  };
}
