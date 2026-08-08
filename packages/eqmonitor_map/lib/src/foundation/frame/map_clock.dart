extension type MapClockDomainId._(String value) {}

final class MapClockCapture {
  const MapClockCapture._({
    required this.domain,
    required this.wallTime,
    required this.monotonicElapsed,
  });

  final MapClockDomainId domain;
  final DateTime wallTime;
  final Duration monotonicElapsed;
}

abstract interface class MapClock {
  MapClockCapture capture();
}

final class SystemMapClock implements MapClock {
  SystemMapClock._({
    required MapClockDomainId domain,
    required Stopwatch stopwatch,
  }) : _domain = domain,
       _stopwatch = stopwatch;

  factory SystemMapClock.start({required MapClockDomainId domain}) =>
      SystemMapClock._(domain: domain, stopwatch: Stopwatch()..start());

  final MapClockDomainId _domain;
  final Stopwatch _stopwatch;

  @override
  MapClockCapture capture() => createMapClockCapture(
    domain: _domain,
    wallTime: DateTime.now().toUtc(),
    monotonicElapsed: _stopwatch.elapsed,
  );
}

MapClockDomainId createMapClockDomainId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapClockDomainId._(normalizedValue);
}

MapClockCapture createMapClockCapture({
  required MapClockDomainId domain,
  required DateTime wallTime,
  required Duration monotonicElapsed,
}) {
  if (!wallTime.isUtc) {
    throw ArgumentError.value(wallTime, 'wallTime', 'must be UTC');
  }
  if (monotonicElapsed.isNegative) {
    throw ArgumentError.value(
      monotonicElapsed,
      'monotonicElapsed',
      'must not be negative',
    );
  }

  return MapClockCapture._(
    domain: domain,
    wallTime: wallTime,
    monotonicElapsed: monotonicElapsed,
  );
}
