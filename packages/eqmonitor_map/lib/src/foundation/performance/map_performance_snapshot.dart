import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';

final class MapPerformanceSnapshot {
  const new _({
    required this.schemaVersion,
    required this.clockDomain,
    required this.windowStartedAt,
    required this.windowEndedAt,
    required this.isPartial,
    required this.metrics,
    required this.counters,
  });

  final MapPerformanceSchemaVersion schemaVersion;
  final MapClockDomainId clockDomain;
  final Duration windowStartedAt;
  final Duration windowEndedAt;
  final bool isPartial;
  final Map<MapPerformanceMetricKind, MapMetricAggregate> metrics;
  final Map<String, int> counters;
}

MapPerformanceSnapshot createMapPerformanceSnapshot({
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required Duration windowStartedAt,
  required Duration windowEndedAt,
  required bool isPartial,
  required Map<MapPerformanceMetricKind, MapMetricAggregate> metrics,
  required Map<String, int> counters,
}) {
  if (windowEndedAt <= windowStartedAt) {
    throw ArgumentError.value(
      windowEndedAt,
      'windowEndedAt',
      'must be after windowStartedAt',
    );
  }

  return MapPerformanceSnapshot._(
    schemaVersion: schemaVersion,
    clockDomain: clockDomain,
    windowStartedAt: windowStartedAt,
    windowEndedAt: windowEndedAt,
    isPartial: isPartial,
    metrics: Map.unmodifiable(metrics),
    counters: Map.unmodifiable(counters),
  );
}
