import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final schemaVersion = createMapPerformanceSchemaVersion(value: 1);
  final clockDomain = createMapClockDomainId(value: 'performance-test');
  final sample = MapPerformanceSample.count(
    schemaVersion: schemaVersion,
    clockDomain: clockDomain,
    kind: MapPerformanceMetricKind.cacheHit,
    monotonicAt: const Duration(seconds: 2),
    value: 3,
  );

  test('exposes sample schema and domain with optional provenance', () {
    final event = createMapPerformanceEvent(
      frameSequence: 4,
      sample: sample,
      fixtureId: 'fixture-a',
      nodeKey: 'base-map',
      operationId: 'decode-1',
    );

    expect(event.frameSequence, 4);
    expect(event.sample, same(sample));
    expect(event.schemaVersion, schemaVersion);
    expect(event.clockDomain, clockDomain);
    expect(event.fixtureId, 'fixture-a');
    expect(event.nodeKey, 'base-map');
    expect(event.operationId, 'decode-1');
  });

  test('rejects negative frames and each blank provenance value', () {
    final invalid = <MapPerformanceEvent Function()>[
      () => createMapPerformanceEvent(frameSequence: -1, sample: sample),
      () => createMapPerformanceEvent(
        frameSequence: 0,
        sample: sample,
        fixtureId: ' ',
      ),
      () => createMapPerformanceEvent(
        frameSequence: 0,
        sample: sample,
        nodeKey: '\n',
      ),
      () => createMapPerformanceEvent(
        frameSequence: 0,
        sample: sample,
        operationId: '\t',
      ),
    ];

    for (final create in invalid) {
      expect(create, throwsArgumentError);
    }
  });
}
