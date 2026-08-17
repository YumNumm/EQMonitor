extension type MapClockDomainId._(String value) {}

final class MapMonotonicSourceIdentity {
  MapMonotonicSourceIdentity._();
}

final class MapWallInstant {
  const MapWallInstant._({required this.value});

  final DateTime value;
}

final class MapMonotonicInstant {
  const MapMonotonicInstant._({
    required this.domain,
    required this.sourceIdentity,
    required this.elapsed,
  });

  final MapClockDomainId domain;
  final MapMonotonicSourceIdentity sourceIdentity;
  final Duration elapsed;
}

final class MapClockCapture {
  const MapClockCapture._({
    required this.domain,
    required this.wallInstant,
    required this.monotonicInstant,
  });

  final MapClockDomainId domain;
  final MapWallInstant wallInstant;
  final MapMonotonicInstant monotonicInstant;
}

abstract interface class MapClock {
  MapClockCapture capture();
}

abstract interface class MapUtcWallSource {
  DateTime captureUtc();
}

abstract interface class MapMonotonicSource {
  MapClockDomainId get domain;

  MapMonotonicSourceIdentity get sourceIdentity;

  MapMonotonicInstant capture();
}

typedef MapClockCaptureCreator = MapClockCapture Function({
  required MapClockDomainId domain,
  required MapMonotonicSourceIdentity sourceIdentity,
  required MapWallInstant wallInstant,
  required MapMonotonicInstant monotonicInstant,
  required MapMonotonicInstant? previousMonotonicInstant,
});

final class SystemUtcWallSource implements MapUtcWallSource {
  const SystemUtcWallSource();

  @override
  DateTime captureUtc() => DateTime.now().toUtc();
}

final class SystemMonotonicSource implements MapMonotonicSource {
  SystemMonotonicSource._({
    required this.domain,
    required this.sourceIdentity,
    required this._stopwatch,
  });

  factory SystemMonotonicSource.start({required MapClockDomainId domain}) =>
      SystemMonotonicSource._(
        domain: domain,
        sourceIdentity: createMapMonotonicSourceIdentity(),
        stopwatch: Stopwatch()..start(),
      );

  final Stopwatch _stopwatch;

  @override
  final MapClockDomainId domain;

  @override
  final MapMonotonicSourceIdentity sourceIdentity;

  @override
  MapMonotonicInstant capture() => createMapMonotonicInstant(
    domain: domain,
    sourceIdentity: sourceIdentity,
    elapsed: _stopwatch.elapsed,
  );
}

final class SystemMapClock implements MapClock {
  SystemMapClock._({
    required this._domain,
    required this._utcWallSource,
    required this._monotonicSource,
    required this._captureCreator,
  });

  factory SystemMapClock.start({required MapClockDomainId domain}) {
    final monotonicSource = SystemMonotonicSource.start(domain: domain);
    return SystemMapClock.withSources(
      domain: domain,
      utcWallSource: const SystemUtcWallSource(),
      monotonicSource: monotonicSource,
      captureCreator: createMapClockCapture,
    );
  }

  factory SystemMapClock.withSources({
    required MapClockDomainId domain,
    required MapUtcWallSource utcWallSource,
    required MapMonotonicSource monotonicSource,
    required MapClockCaptureCreator captureCreator,
  }) {
    if (monotonicSource.domain != domain) {
      throw ArgumentError.value(
        monotonicSource.domain,
        'monotonicSource',
        'must belong to the clock domain',
      );
    }

    return SystemMapClock._(
      domain: domain,
      utcWallSource: utcWallSource,
      monotonicSource: monotonicSource,
      captureCreator: captureCreator,
    );
  }

  final MapClockDomainId _domain;
  final MapUtcWallSource _utcWallSource;
  final MapMonotonicSource _monotonicSource;
  final MapClockCaptureCreator _captureCreator;
  MapMonotonicInstant? _previousMonotonicInstant;

  @override
  MapClockCapture capture() {
    final wallInstant = createMapWallInstant(
      value: _utcWallSource.captureUtc(),
    );
    final monotonicInstant = _monotonicSource.capture();
    final capture = _captureCreator(
      domain: _domain,
      sourceIdentity: _monotonicSource.sourceIdentity,
      wallInstant: wallInstant,
      monotonicInstant: monotonicInstant,
      previousMonotonicInstant: _previousMonotonicInstant,
    );
    if (capture.domain != _domain ||
        !identical(capture.wallInstant, wallInstant) ||
        !identical(capture.monotonicInstant, monotonicInstant)) {
      throw StateError('capture creator must preserve captured instants');
    }
    _previousMonotonicInstant = capture.monotonicInstant;
    return capture;
  }
}

MapClockDomainId createMapClockDomainId({required String value}) {
  final normalizedValue = value.trim();
  if (normalizedValue.isEmpty) {
    throw ArgumentError.value(value, 'value', 'must not be blank');
  }

  return MapClockDomainId._(normalizedValue);
}

MapMonotonicSourceIdentity createMapMonotonicSourceIdentity() =>
    MapMonotonicSourceIdentity._();

MapWallInstant createMapWallInstant({required DateTime value}) {
  if (!value.isUtc) {
    throw ArgumentError.value(value, 'value', 'must be UTC');
  }

  return MapWallInstant._(value: value);
}

MapMonotonicInstant createMapMonotonicInstant({
  required MapClockDomainId domain,
  required MapMonotonicSourceIdentity sourceIdentity,
  required Duration elapsed,
}) {
  if (elapsed.isNegative) {
    throw ArgumentError.value(elapsed, 'elapsed', 'must not be negative');
  }

  return MapMonotonicInstant._(
    domain: domain,
    sourceIdentity: sourceIdentity,
    elapsed: elapsed,
  );
}

MapClockCapture createMapClockCapture({
  required MapClockDomainId domain,
  required MapMonotonicSourceIdentity sourceIdentity,
  required MapWallInstant wallInstant,
  required MapMonotonicInstant monotonicInstant,
  required MapMonotonicInstant? previousMonotonicInstant,
}) {
  if (!wallInstant.value.isUtc || monotonicInstant.domain != domain) {
    throw ArgumentError('capture instants must belong to the clock domain');
  }
  if (!identical(monotonicInstant.sourceIdentity, sourceIdentity)) {
    throw ArgumentError('monotonic instant must belong to the clock source');
  }
  if (previousMonotonicInstant != null &&
      (previousMonotonicInstant.domain != domain ||
          !identical(
            previousMonotonicInstant.sourceIdentity,
            sourceIdentity,
          ))) {
    throw ArgumentError('previous instant must belong to the clock source');
  }
  if (previousMonotonicInstant != null &&
      monotonicInstant.elapsed < previousMonotonicInstant.elapsed) {
    throw StateError('monotonic time must not regress');
  }

  return MapClockCapture._(
    domain: domain,
    wallInstant: wallInstant,
    monotonicInstant: monotonicInstant,
  );
}
