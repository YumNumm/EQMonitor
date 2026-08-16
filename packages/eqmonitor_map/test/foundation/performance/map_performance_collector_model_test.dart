import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_collector.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:flutter_test/flutter_test.dart';

MapPerformancePolicy createPolicy() => createMapPerformancePolicy(
  schemaVersion: createMapPerformanceSchemaVersion(value: 1),
  clockDomain: createMapClockDomainId(value: 'collector-test'),
  observationLevel: MapPerformanceObservationLevel.detailed,
  aggregationWindow: const Duration(seconds: 10),
  percentiles: const [50, 95],
  snapshotInterval: const Duration(seconds: 2),
  reservoirCapacity: 16,
  sampleEveryFrames: 2,
  minimumEventInterval: const Duration(milliseconds: 100),
  eventBufferCapacity: 8,
  dropPolicy: MapPerformanceDropPolicy.dropOldest,
  frameBudget: createMapFrameBudget(
    duration: const Duration(microseconds: 16667),
  ),
);

void main() {
  test('creates the exact record result variants', () {
    final results = [
      const MapPerformanceRecordResult.accepted(),
      const MapPerformanceRecordResult.aggregated(),
      const MapPerformanceRecordResult.ignored(),
      const MapPerformanceRecordResult.rejected(),
    ];

    expect(results.map((result) => result.kind), [
      MapPerformanceRecordResultKind.accepted,
      MapPerformanceRecordResultKind.aggregated,
      MapPerformanceRecordResultKind.ignored,
      MapPerformanceRecordResultKind.rejected,
    ]);
  });

  test('owns policy and window with zero initial counters', () {
    final policy = createPolicy();
    final collector = MapPerformanceCollector(
      policy: policy,
      windowStartedAt: const Duration(seconds: 1),
    );

    expect(collector.policy, same(policy));
    expect(collector.windowStartedAt, const Duration(seconds: 1));
    expect(
      (
        collector.acceptedCount,
        collector.aggregatedCount,
        collector.ignoredCount,
        collector.rejectedCount,
        collector.rateLimitedCount,
        collector.droppedCount,
        collector.bufferedEventCount,
      ),
      (0, 0, 0, 0, 0, 0, 0),
    );
  });

  test('rejects a negative window start', () {
    expect(
      () => MapPerformanceCollector(
        policy: createPolicy(),
        windowStartedAt: const Duration(microseconds: -1),
      ),
      throwsArgumentError,
    );
  });
}
