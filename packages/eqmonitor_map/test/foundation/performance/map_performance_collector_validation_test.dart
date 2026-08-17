import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_collector.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';
import 'package:flutter_test/flutter_test.dart';

MapPerformanceCollector collector(MapPerformanceObservationLevel level) =>
    MapPerformanceCollector(
      policy: createMapPerformancePolicy(
        schemaVersion: createMapPerformanceSchemaVersion(value: 1),
        clockDomain: createMapClockDomainId(value: 'collector-test'),
        observationLevel: level,
        aggregationWindow: const Duration(seconds: 10),
        percentiles: const [50, 95],
        snapshotInterval: const Duration(seconds: 2),
        reservoirCapacity: 4,
        sampleEveryFrames: 1,
        minimumEventInterval: const Duration(milliseconds: 100),
        eventBufferCapacity: 2,
        dropPolicy: MapPerformanceDropPolicy.dropOldest,
        frameBudget: createMapFrameBudget(
          duration: const Duration(microseconds: 16667),
        ),
      ),
      windowStartedAt: Duration.zero,
    );

MapPerformanceEvent event({
  int version = 1,
  String domain = 'collector-test',
  int seconds = 1,
}) => createMapPerformanceEvent(
  frameSequence: seconds,
  sample: MapPerformanceSample.count(
    schemaVersion: createMapPerformanceSchemaVersion(value: version),
    clockDomain: createMapClockDomainId(value: domain),
    kind: MapPerformanceMetricKind.cacheHit,
    monotonicAt: Duration(seconds: seconds),
    value: seconds,
  ),
);

void main() {
  test('rejects mismatches and rollback without changing aggregates', () {
    final subject = collector(MapPerformanceObservationLevel.detailed);
    final results = [
      subject.record(event(version: 2, seconds: 9)),
      subject.record(event(domain: 'other', seconds: 8)),
      subject.record(event(seconds: 2)),
      subject.record(event()),
      subject.record(event()),
    ];

    expect(results.map((result) => result.kind), [
      MapPerformanceRecordResultKind.rejected,
      MapPerformanceRecordResultKind.rejected,
      MapPerformanceRecordResultKind.accepted,
      MapPerformanceRecordResultKind.rejected,
      MapPerformanceRecordResultKind.rejected,
    ]);
    expect(
      (subject.acceptedCount, subject.aggregatedCount, subject.rejectedCount),
      (1, 1, 4),
    );
  });

  test('applies the exact observation level behavior', () {
    const cases = [
      (
        MapPerformanceObservationLevel.off,
        MapPerformanceRecordResultKind.ignored,
        (0, 0, 1),
      ),
      (
        MapPerformanceObservationLevel.aggregate,
        MapPerformanceRecordResultKind.aggregated,
        (0, 1, 0),
      ),
      (
        MapPerformanceObservationLevel.detailed,
        MapPerformanceRecordResultKind.accepted,
        (1, 1, 0),
      ),
    ];

    for (final (level, expected, counts) in cases) {
      final subject = collector(level);
      expect(subject.record(event()).kind, expected);
      expect(
        (subject.acceptedCount, subject.aggregatedCount, subject.ignoredCount),
        counts,
      );
    }
  });
}
