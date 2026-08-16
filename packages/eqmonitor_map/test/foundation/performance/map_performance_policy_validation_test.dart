import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:flutter_test/flutter_test.dart';

MapPerformancePolicy createPolicy({
  Duration aggregationWindow = const Duration(seconds: 10),
  List<double> percentiles = const [50, 95],
  Duration snapshotInterval = const Duration(seconds: 2),
  int reservoirCapacity = 16,
  int sampleEveryFrames = 2,
  Duration minimumEventInterval = const Duration(milliseconds: 100),
  int eventBufferCapacity = 8,
}) => createMapPerformancePolicy(
  schemaVersion: createMapPerformanceSchemaVersion(value: 1),
  clockDomain: createMapClockDomainId(value: 'policy-test'),
  observationLevel: MapPerformanceObservationLevel.detailed,
  aggregationWindow: aggregationWindow,
  percentiles: percentiles,
  snapshotInterval: snapshotInterval,
  reservoirCapacity: reservoirCapacity,
  sampleEveryFrames: sampleEveryFrames,
  minimumEventInterval: minimumEventInterval,
  eventBufferCapacity: eventBufferCapacity,
  dropPolicy: MapPerformanceDropPolicy.dropOldest,
  frameBudget: createMapFrameBudget(
    duration: const Duration(microseconds: 16667),
  ),
);

void main() {
  test('owns every required policy field and the percentile list', () {
    final input = <double>[50, 95];
    final policy = createPolicy(percentiles: input);
    input[0] = 25;

    expect(policy.schemaVersion, createMapPerformanceSchemaVersion(value: 1));
    expect(policy.clockDomain, createMapClockDomainId(value: 'policy-test'));
    expect(policy.observationLevel, MapPerformanceObservationLevel.detailed);
    expect(policy.aggregationWindow, const Duration(seconds: 10));
    expect(policy.percentiles, [50, 95]);
    expect(policy.snapshotInterval, const Duration(seconds: 2));
    expect(policy.reservoirCapacity, 16);
    expect(policy.sampleEveryFrames, 2);
    expect(policy.minimumEventInterval, const Duration(milliseconds: 100));
    expect(policy.eventBufferCapacity, 8);
    expect(policy.dropPolicy, MapPerformanceDropPolicy.dropOldest);
    expect(policy.frameBudget.duration, const Duration(microseconds: 16667));
    expect(() => policy.percentiles.add(99), throwsUnsupportedError);
  });

  test('rejects non-positive durations and capacities', () {
    for (final create in <MapPerformancePolicy Function()>[
      () => createPolicy(aggregationWindow: Duration.zero),
      () => createPolicy(snapshotInterval: Duration.zero),
      () => createPolicy(minimumEventInterval: Duration.zero),
      () => createPolicy(reservoirCapacity: 0),
      () => createPolicy(sampleEveryFrames: 0),
      () => createPolicy(eventBufferCapacity: 0),
    ]) {
      expect(create, throwsArgumentError);
    }
  });

  test('requires sorted unique percentiles in the range (0, 100]', () {
    for (final percentiles in <List<double>>[
      [],
      [0],
      [101],
      [double.nan],
      [95, 50],
      [50, 50],
    ]) {
      expect(() => createPolicy(percentiles: percentiles), throwsArgumentError);
    }
  });

  test('keeps the snapshot interval within the aggregation window', () {
    expect(
      () => createPolicy(snapshotInterval: const Duration(seconds: 11)),
      throwsArgumentError,
    );
    expect(
      createPolicy(snapshotInterval: const Duration(seconds: 10)),
      isA<MapPerformancePolicy>(),
    );
  });
}
