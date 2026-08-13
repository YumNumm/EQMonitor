import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final domain = createMapClockDomainId(value: 'render-loop');

  group('typed clock instants', () {
    test('normalizes the domain and rejects blank values', () {
      expect(
        createMapClockDomainId(value: ' render-loop ').value,
        'render-loop',
      );
      expect(
        () => createMapClockDomainId(value: ' \n\t '),
        throwsArgumentError,
      );
    });

    test('rejects local wall time and negative monotonic time', () {
      final sourceIdentity = createMapMonotonicSourceIdentity();

      expect(
        () => createMapWallInstant(value: DateTime(2026)),
        throwsArgumentError,
      );
      expect(
        () => createMapMonotonicInstant(
          domain: domain,
          sourceIdentity: sourceIdentity,
          elapsed: const Duration(microseconds: -1),
        ),
        throwsArgumentError,
      );
    });
  });

  group('createMapClockCapture', () {
    test('rejects a monotonic instant from another domain or source', () {
      final expectedSource = createMapMonotonicSourceIdentity();
      final otherSource = createMapMonotonicSourceIdentity();
      final wallInstant = createMapWallInstant(value: DateTime.utc(2026));

      expect(
        () => createMapClockCapture(
          domain: domain,
          sourceIdentity: expectedSource,
          wallInstant: wallInstant,
          monotonicInstant: createMapMonotonicInstant(
            domain: createMapClockDomainId(value: 'other'),
            sourceIdentity: expectedSource,
            elapsed: Duration.zero,
          ),
          previousMonotonicInstant: null,
        ),
        throwsArgumentError,
      );
      expect(
        () => createMapClockCapture(
          domain: domain,
          sourceIdentity: expectedSource,
          wallInstant: wallInstant,
          monotonicInstant: createMapMonotonicInstant(
            domain: domain,
            sourceIdentity: otherSource,
            elapsed: Duration.zero,
          ),
          previousMonotonicInstant: null,
        ),
        throwsArgumentError,
      );
    });

    test('rejects monotonic regression for the owned source', () {
      final sourceIdentity = createMapMonotonicSourceIdentity();
      final previous = createMapMonotonicInstant(
        domain: domain,
        sourceIdentity: sourceIdentity,
        elapsed: const Duration(microseconds: 2),
      );

      expect(
        () => createMapClockCapture(
          domain: domain,
          sourceIdentity: sourceIdentity,
          wallInstant: createMapWallInstant(value: DateTime.utc(2026)),
          monotonicInstant: createMapMonotonicInstant(
            domain: domain,
            sourceIdentity: sourceIdentity,
            elapsed: const Duration(microseconds: 1),
          ),
          previousMonotonicInstant: previous,
        ),
        throwsStateError,
      );
    });
  });

  group('SystemMapClock', () {
    test('captures each injected source and creator exactly once in order', () {
      final calls = <String>[];
      final sourceIdentity = createMapMonotonicSourceIdentity();
      final wallSource = SequenceUtcWallSource(
        values: [DateTime.utc(2026, 8, 9, 1), DateTime.utc(2026, 8, 9, 2)],
        calls: calls,
      );
      final monotonicSource = SequenceMonotonicSource(
        domain: domain,
        sourceIdentity: sourceIdentity,
        elapsedValues: const [
          Duration(microseconds: 10),
          Duration(microseconds: 20),
        ],
        calls: calls,
      );
      final creator = RecordingMapClockCaptureCreator(calls: calls);
      final clock = SystemMapClock.withSources(
        domain: domain,
        utcWallSource: wallSource,
        monotonicSource: monotonicSource,
        captureCreator: creator.create,
      );

      final first = clock.capture();
      final second = clock.capture();

      expect(calls, [
        'wall',
        'monotonic',
        'creator',
        'wall',
        'monotonic',
        'creator',
      ]);
      expect(wallSource.captureCount, 2);
      expect(monotonicSource.captureCount, 2);
      expect(creator.captureCount, 2);
      expect(first.domain, domain);
      expect(first.monotonicInstant.sourceIdentity, same(sourceIdentity));
      expect(first.wallInstant.value, DateTime.utc(2026, 8, 9, 1));
      expect(second.domain, domain);
      expect(second.monotonicInstant.sourceIdentity, same(sourceIdentity));
      expect(second.monotonicInstant.elapsed, const Duration(microseconds: 20));
    });

    test('rejects a monotonic source owned by another domain', () {
      final foreignDomain = createMapClockDomainId(value: 'foreign');
      final sourceIdentity = createMapMonotonicSourceIdentity();

      expect(
        () => SystemMapClock.withSources(
          domain: domain,
          utcWallSource: SequenceUtcWallSource(
            values: [DateTime.utc(2026)],
            calls: [],
          ),
          monotonicSource: SequenceMonotonicSource(
            domain: foreignDomain,
            sourceIdentity: sourceIdentity,
            elapsedValues: const [Duration.zero],
            calls: [],
          ),
          captureCreator: createMapClockCapture,
        ),
        throwsArgumentError,
      );
    });

    test('rejects local wall source output before reading monotonic time', () {
      final calls = <String>[];
      final sourceIdentity = createMapMonotonicSourceIdentity();
      final wallSource = SequenceUtcWallSource(
        values: [DateTime(2026)],
        calls: calls,
      );
      final monotonicSource = SequenceMonotonicSource(
        domain: domain,
        sourceIdentity: sourceIdentity,
        elapsedValues: const [Duration.zero],
        calls: calls,
      );
      final clock = SystemMapClock.withSources(
        domain: domain,
        utcWallSource: wallSource,
        monotonicSource: monotonicSource,
        captureCreator: createMapClockCapture,
      );

      expect(clock.capture, throwsArgumentError);
      expect(calls, ['wall']);
      expect(monotonicSource.captureCount, 0);
    });

    test(
      'rejects source regression without advancing the accepted instant',
      () {
        final sourceIdentity = createMapMonotonicSourceIdentity();
        final clock = SystemMapClock.withSources(
          domain: domain,
          utcWallSource: SequenceUtcWallSource(
            values: [
              DateTime.utc(2026),
              DateTime.utc(2026),
              DateTime.utc(2026),
            ],
            calls: [],
          ),
          monotonicSource: SequenceMonotonicSource(
            domain: domain,
            sourceIdentity: sourceIdentity,
            elapsedValues: const [
              Duration(microseconds: 10),
              Duration(microseconds: 9),
              Duration(microseconds: 11),
            ],
            calls: [],
          ),
          captureCreator: createMapClockCapture,
        );

        expect(
          clock.capture().monotonicInstant.elapsed,
          const Duration(microseconds: 10),
        );
        expect(clock.capture, throwsStateError);
        expect(
          clock.capture().monotonicInstant.elapsed,
          const Duration(microseconds: 11),
        );
      },
    );

    test('rejects a creator result that replaces source ownership', () {
      final sourceIdentity = createMapMonotonicSourceIdentity();
      final clock = SystemMapClock.withSources(
        domain: domain,
        utcWallSource: SequenceUtcWallSource(
          values: [DateTime.utc(2026)],
          calls: [],
        ),
        monotonicSource: SequenceMonotonicSource(
          domain: domain,
          sourceIdentity: sourceIdentity,
          elapsedValues: const [Duration.zero],
          calls: [],
        ),
        captureCreator: ForeignMapClockCaptureCreator().create,
      );

      expect(clock.capture, throwsStateError);
    });
  });
}

final class SequenceUtcWallSource implements MapUtcWallSource {
  SequenceUtcWallSource({required List<DateTime> values, required this.calls})
    : _values = List<DateTime>.of(values);

  final List<DateTime> _values;
  final List<String> calls;
  var _captureCount = 0;

  int get captureCount => _captureCount;

  @override
  DateTime captureUtc() {
    _captureCount += 1;
    calls.add('wall');
    return _values.removeAt(0);
  }
}

final class SequenceMonotonicSource implements MapMonotonicSource {
  SequenceMonotonicSource({
    required this.domain,
    required this.sourceIdentity,
    required List<Duration> elapsedValues,
    required this.calls,
  }) : _elapsedValues = List<Duration>.of(elapsedValues);

  final List<Duration> _elapsedValues;
  final List<String> calls;
  var _captureCount = 0;

  int get captureCount => _captureCount;

  @override
  final MapClockDomainId domain;

  @override
  final MapMonotonicSourceIdentity sourceIdentity;

  @override
  MapMonotonicInstant capture() {
    _captureCount += 1;
    calls.add('monotonic');
    return createMapMonotonicInstant(
      domain: domain,
      sourceIdentity: sourceIdentity,
      elapsed: _elapsedValues.removeAt(0),
    );
  }
}

final class RecordingMapClockCaptureCreator {
  RecordingMapClockCaptureCreator({required this.calls});

  final List<String> calls;
  var _captureCount = 0;

  int get captureCount => _captureCount;

  MapClockCapture create({
    required MapClockDomainId domain,
    required MapMonotonicSourceIdentity sourceIdentity,
    required MapWallInstant wallInstant,
    required MapMonotonicInstant monotonicInstant,
    required MapMonotonicInstant? previousMonotonicInstant,
  }) {
    _captureCount += 1;
    calls.add('creator');
    return createMapClockCapture(
      domain: domain,
      sourceIdentity: sourceIdentity,
      wallInstant: wallInstant,
      monotonicInstant: monotonicInstant,
      previousMonotonicInstant: previousMonotonicInstant,
    );
  }
}

final class ForeignMapClockCaptureCreator {
  MapClockCapture create({
    required MapClockDomainId domain,
    required MapMonotonicSourceIdentity sourceIdentity,
    required MapWallInstant wallInstant,
    required MapMonotonicInstant monotonicInstant,
    required MapMonotonicInstant? previousMonotonicInstant,
  }) {
    final foreignDomain = createMapClockDomainId(value: 'foreign');
    final foreignSource = createMapMonotonicSourceIdentity();
    return createMapClockCapture(
      domain: foreignDomain,
      sourceIdentity: foreignSource,
      wallInstant: wallInstant,
      monotonicInstant: createMapMonotonicInstant(
        domain: foreignDomain,
        sourceIdentity: foreignSource,
        elapsed: monotonicInstant.elapsed,
      ),
      previousMonotonicInstant: null,
    );
  }
}
