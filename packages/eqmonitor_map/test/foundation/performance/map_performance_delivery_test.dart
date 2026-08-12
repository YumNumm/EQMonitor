import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_collector.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';
import 'package:flutter_test/flutter_test.dart';

final MapPerformanceSchemaVersion schema = createMapPerformanceSchemaVersion(
  value: 1,
);
final MapClockDomainId domain = createMapClockDomainId(value: 'delivery-test');

MapPerformanceCollector collector({
  int sampleEveryFrames = 1,
  Duration minimumEventInterval = const Duration(milliseconds: 100),
  int eventBufferCapacity = 2,
  MapPerformanceDropPolicy dropPolicy = MapPerformanceDropPolicy.dropOldest,
}) => MapPerformanceCollector(
  policy: createMapPerformancePolicy(
    schemaVersion: schema,
    clockDomain: domain,
    observationLevel: MapPerformanceObservationLevel.detailed,
    aggregationWindow: const Duration(seconds: 10),
    percentiles: const [50],
    snapshotInterval: const Duration(seconds: 1),
    reservoirCapacity: 8,
    sampleEveryFrames: sampleEveryFrames,
    minimumEventInterval: minimumEventInterval,
    eventBufferCapacity: eventBufferCapacity,
    dropPolicy: dropPolicy,
    frameBudget: createMapFrameBudget(duration: const Duration(seconds: 1)),
  ),
  windowStartedAt: Duration.zero,
);

MapPerformanceEvent event({
  required int frame,
  required int milliseconds,
  MapPerformanceMetricKind kind = MapPerformanceMetricKind.cacheHit,
}) => createMapPerformanceEvent(
  frameSequence: frame,
  sample: MapPerformanceSample.count(
    schemaVersion: schema,
    clockDomain: domain,
    kind: kind,
    monotonicAt: Duration(milliseconds: milliseconds),
    value: 1,
  ),
);

void main() {
  test('aggregates before applying a per-kind rate limit', () {
    final subject = collector();
    final results = [
      subject.record(event(frame: 0, milliseconds: 1000)),
      subject.record(event(frame: 1, milliseconds: 1050)),
      subject.record(
        event(
          frame: 2,
          milliseconds: 1060,
          kind: MapPerformanceMetricKind.cacheMiss,
        ),
      ),
    ];
    final snapshot = subject.takePartialSnapshot(
      const Duration(seconds: 2),
    );

    expect(results.map((result) => result.kind), [
      MapPerformanceRecordResultKind.accepted,
      MapPerformanceRecordResultKind.aggregated,
      MapPerformanceRecordResultKind.accepted,
    ]);
    expect(snapshot?.metrics[MapPerformanceMetricKind.cacheHit]?.count, 2);
    expect(snapshot?.metrics[MapPerformanceMetricKind.cacheMiss]?.count, 1);
    expect((subject.aggregatedCount, subject.acceptedCount), (3, 2));
    expect((subject.rateLimitedCount, subject.bufferedEventCount), (1, 2));
  });

  test('samples detailed delivery by frame after aggregation', () {
    final subject = collector(sampleEveryFrames: 2);

    expect(
      subject.record(event(frame: 1, milliseconds: 1000)).kind,
      MapPerformanceRecordResultKind.aggregated,
    );
    expect(
      subject.record(event(frame: 2, milliseconds: 2000)).kind,
      MapPerformanceRecordResultKind.accepted,
    );
    expect(subject.drainEvents().map((event) => event.frameSequence), [2]);
    expect((subject.aggregatedCount, subject.acceptedCount), (2, 1));
  });
}
