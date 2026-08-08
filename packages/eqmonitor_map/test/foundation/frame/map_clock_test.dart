import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapClockDomainId', () {
    test('normalizes surrounding whitespace and rejects blank values', () {
      expect(
        createMapClockDomainId(value: '  render-loop  ').value,
        'render-loop',
      );
      expect(
        () => createMapClockDomainId(value: ' \n\t '),
        throwsArgumentError,
      );
    });
  });

  group('createMapClockCapture', () {
    test('rejects a local wall time', () {
      expect(
        () => createMapClockCapture(
          domain: createMapClockDomainId(value: 'render-loop'),
          wallTime: DateTime(2026),
          monotonicElapsed: Duration.zero,
        ),
        throwsArgumentError,
      );
    });

    test('rejects a negative monotonic elapsed duration', () {
      expect(
        () => createMapClockCapture(
          domain: createMapClockDomainId(value: 'render-loop'),
          wallTime: DateTime.utc(2026),
          monotonicElapsed: const Duration(microseconds: -1),
        ),
        throwsArgumentError,
      );
    });
  });

  test(
    'SystemMapClock retains one started stopwatch across captures',
    () async {
      final domain = createMapClockDomainId(value: 'render-loop');
      final clock = SystemMapClock.start(domain: domain);

      await Future<void>.delayed(const Duration(milliseconds: 5));
      final first = clock.capture();
      await Future<void>.delayed(const Duration(milliseconds: 5));
      final second = clock.capture();

      expect(first.domain, domain);
      expect(first.wallTime.isUtc, isTrue);
      expect(first.monotonicElapsed, greaterThan(Duration.zero));
      expect(second.monotonicElapsed, greaterThan(first.monotonicElapsed));
    },
  );
}
