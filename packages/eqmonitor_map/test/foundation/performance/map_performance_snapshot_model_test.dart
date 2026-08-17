import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('owns the exact snapshot fields and nested collections', () {
    final percentileInput = <MapPercentileValue>[
      createMapPercentileValue(percentile: 50, value: 4),
    ];
    final metrics = <MapPerformanceMetricKind, MapMetricAggregate>{
      MapPerformanceMetricKind.cacheHit: createMapMetricAggregate(
        count: 1,
        sum: 4,
        min: 4,
        max: 4,
        percentiles: percentileInput,
        percentileSampleCount: 1,
        percentileDroppedCount: 0,
      ),
    };
    final counters = <String, int>{'accepted': 1};
    final schemaVersion = createMapPerformanceSchemaVersion(value: 1);
    final clockDomain = createMapClockDomainId(value: 'snapshot-test');

    final snapshot = createMapPerformanceSnapshot(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      windowStartedAt: const Duration(seconds: 10),
      windowEndedAt: const Duration(seconds: 20),
      isPartial: true,
      metrics: metrics,
      counters: counters,
    );
    percentileInput.clear();
    metrics.clear();
    counters['accepted'] = 2;

    expect(
      (
        snapshot.schemaVersion,
        snapshot.clockDomain,
        snapshot.windowStartedAt,
        snapshot.windowEndedAt,
        snapshot.isPartial,
      ),
      (
        schemaVersion,
        clockDomain,
        const Duration(seconds: 10),
        const Duration(seconds: 20),
        true,
      ),
    );
    expect(snapshot.metrics.keys, [MapPerformanceMetricKind.cacheHit]);
    expect(snapshot.metrics.values.single.percentiles.length, 1);
    expect(snapshot.counters, {'accepted': 1});
    expect(
      snapshot.metrics.clear,
      throwsUnsupportedError,
    );
    expect(
      snapshot.counters.clear,
      throwsUnsupportedError,
    );
  });

  test('requires the window end to be after its start', () {
    for (final end in [
      const Duration(seconds: 10),
      const Duration(seconds: 9),
    ]) {
      expect(
        () => createMapPerformanceSnapshot(
          schemaVersion: createMapPerformanceSchemaVersion(value: 1),
          clockDomain: createMapClockDomainId(value: 'snapshot-test'),
          windowStartedAt: const Duration(seconds: 10),
          windowEndedAt: end,
          isPartial: false,
          metrics: const {},
          counters: const {},
        ),
        throwsArgumentError,
      );
    }
  });
}
