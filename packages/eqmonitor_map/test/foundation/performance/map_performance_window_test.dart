import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_collector.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

final MapPerformanceSchemaVersion schema = createMapPerformanceSchemaVersion(
  value: 1,
);
final MapClockDomainId domain = createMapClockDomainId(value: 'window-test');

MapPerformanceCollector collector() => MapPerformanceCollector(
  policy: createMapPerformancePolicy(
    schemaVersion: schema,
    clockDomain: domain,
    observationLevel: MapPerformanceObservationLevel.aggregate,
    aggregationWindow: const Duration(seconds: 10),
    percentiles: const [50],
    snapshotInterval: const Duration(seconds: 2),
    reservoirCapacity: 4,
    sampleEveryFrames: 1,
    minimumEventInterval: const Duration(milliseconds: 1),
    eventBufferCapacity: 1,
    dropPolicy: MapPerformanceDropPolicy.dropOldest,
    frameBudget: createMapFrameBudget(duration: const Duration(seconds: 1)),
  ),
  windowStartedAt: Duration.zero,
);

MapPerformanceEvent event(int second) => createMapPerformanceEvent(
  frameSequence: second,
  sample: MapPerformanceSample.count(
    schemaVersion: schema,
    clockDomain: domain,
    kind: MapPerformanceMetricKind.cacheHit,
    monotonicAt: Duration(seconds: second),
    value: 1,
  ),
);

int sampleCount(MapPerformanceSnapshot snapshot) =>
    snapshot.metrics[MapPerformanceMetricKind.cacheHit]?.count ?? 0;
MapPerformanceSnapshot requireSnapshot(MapPerformanceSnapshot? value) =>
    value ?? (throw StateError('expected a snapshot'));
int partialCount(MapPerformanceCollector subject, int second) => sampleCount(
  requireSnapshot(subject.takePartialSnapshot(Duration(seconds: second))),
);

void main() {
  test('partials retain aggregates and records auto-advance exact windows', () {
    final subject = collector();
    subject.record(event(1));
    subject.record(event(2));

    final firstPartial = requireSnapshot(
      subject.takePartialSnapshot(const Duration(seconds: 2)),
    );
    expect(sampleCount(firstPartial), 2);
    expect(firstPartial.isPartial, isTrue);
    expect(subject.takePartialSnapshot(const Duration(seconds: 2)), isNull);
    subject.record(event(3));
    expect(partialCount(subject, 4), 3);

    final atBoundary = subject.record(event(10));
    expect(atBoundary.completedSnapshots.length, 1);
    expect(
      (
        atBoundary.completedSnapshots.single.windowStartedAt,
        atBoundary.completedSnapshots.single.windowEndedAt,
        atBoundary.completedSnapshots.single.isPartial,
        sampleCount(atBoundary.completedSnapshots.single),
      ),
      (Duration.zero, const Duration(seconds: 10), false, 3),
    );
    expect(subject.record(event(10)).completedSnapshots, isEmpty);
    expect(partialCount(subject, 12), 2);

    final afterGap = subject.record(event(31)).completedSnapshots;
    expect(afterGap.map((snapshot) => snapshot.windowStartedAt), [
      const Duration(seconds: 10),
      const Duration(seconds: 20),
    ]);
    expect(afterGap.map(sampleCount), [2, 0]);
    expect(afterGap.clear, throwsUnsupportedError);
  });

  test('advanceWindows finalizes empty windows without an event', () {
    final snapshots = collector().advanceWindows(const Duration(seconds: 21));

    expect(snapshots.map((snapshot) => snapshot.windowEndedAt), [
      const Duration(seconds: 10),
      const Duration(seconds: 20),
    ]);
    expect(snapshots.map(sampleCount), [0, 0]);
    expect(snapshots.clear, throwsUnsupportedError);
  });
}
