import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_sample.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final schemaVersion = createMapPerformanceSchemaVersion(value: 1);
  final clockDomain = createMapClockDomainId(value: 'performance-test');
  const monotonicAt = Duration(seconds: 2);
  const cases = [
    (
      unit: MapPerformanceMetricUnit.duration,
      kind: MapPerformanceMetricKind.frameReconciliation,
      value: 250,
    ),
    (
      unit: MapPerformanceMetricUnit.count,
      kind: MapPerformanceMetricKind.cacheHit,
      value: 3,
    ),
    (
      unit: MapPerformanceMetricUnit.bytes,
      kind: MapPerformanceMetricKind.requestBytes,
      value: 512,
    ),
  ];

  MapPerformanceSample createSample({
    required MapPerformanceMetricUnit factoryUnit,
    required MapPerformanceMetricKind kind,
    required Duration at,
    required int value,
  }) => switch (factoryUnit) {
    .duration => MapPerformanceSample.duration(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: at,
      value: Duration(microseconds: value),
    ),
    .count => MapPerformanceSample.count(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: at,
      value: value,
    ),
    .bytes => MapPerformanceSample.bytes(
      schemaVersion: schemaVersion,
      clockDomain: clockDomain,
      kind: kind,
      monotonicAt: at,
      value: value,
    ),
  };

  test('creates typed samples and stores durations in microseconds', () {
    final samples = cases
        .map(
          (entry) => createSample(
            factoryUnit: entry.unit,
            kind: entry.kind,
            at: monotonicAt,
            value: entry.value,
          ),
        )
        .toList();

    expect(samples.map((sample) => sample.value), [250, 3, 512]);
    expect(
      samples.map((sample) => sample.kind),
      cases.map((entry) => entry.kind),
    );
    expect(samples.first.schemaVersion, schemaVersion);
    expect(samples.first.clockDomain, clockDomain);
    expect(samples.first.monotonicAt, monotonicAt);
  });

  test('rejects every factory and metric unit mismatch', () {
    for (final factoryUnit in MapPerformanceMetricUnit.values) {
      for (final entry in cases.where((entry) => entry.unit != factoryUnit)) {
        expect(
          () => createSample(
            factoryUnit: factoryUnit,
            kind: entry.kind,
            at: monotonicAt,
            value: 0,
          ),
          throwsArgumentError,
        );
      }
    }
  });
}
