import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';

enum MapPerformanceRecordResultKind {
  accepted,
  aggregated,
  ignored,
  rejected,
}

final class MapPerformanceRecordResult {
  const MapPerformanceRecordResult.accepted()
    : kind = MapPerformanceRecordResultKind.accepted;

  const MapPerformanceRecordResult.aggregated()
    : kind = MapPerformanceRecordResultKind.aggregated;

  const MapPerformanceRecordResult.ignored()
    : kind = MapPerformanceRecordResultKind.ignored;

  const MapPerformanceRecordResult.rejected()
    : kind = MapPerformanceRecordResultKind.rejected;

  final MapPerformanceRecordResultKind kind;
}

final class MapPerformanceCollector {
  MapPerformanceCollector({
    required this.policy,
    required this.windowStartedAt,
  }) {
    if (windowStartedAt.isNegative) {
      throw ArgumentError.value(
        windowStartedAt,
        'windowStartedAt',
        'must not be negative',
      );
    }
  }

  final MapPerformancePolicy policy;
  final Duration windowStartedAt;

  final Map<MapPerformanceMetricKind, MapMetricAccumulator> _aggregates = {};
  Duration? _lastMonotonicAt;
  var _acceptedCount = 0;
  var _aggregatedCount = 0;
  var _ignoredCount = 0;
  var _rejectedCount = 0;
  final _rateLimitedCount = 0;
  final _droppedCount = 0;
  final _bufferedEventCount = 0;

  int get acceptedCount => _acceptedCount;

  int get aggregatedCount => _aggregatedCount;

  int get ignoredCount => _ignoredCount;

  int get rejectedCount => _rejectedCount;

  int get rateLimitedCount => _rateLimitedCount;

  int get droppedCount => _droppedCount;

  int get bufferedEventCount => _bufferedEventCount;

  MapPerformanceRecordResult record(MapPerformanceEvent event) {
    final lastMonotonicAt = _lastMonotonicAt;
    if (event.schemaVersion != policy.schemaVersion ||
        event.clockDomain != policy.clockDomain ||
        lastMonotonicAt != null && event.sample.monotonicAt < lastMonotonicAt) {
      _rejectedCount += 1;
      return const MapPerformanceRecordResult.rejected();
    }
    _lastMonotonicAt = event.sample.monotonicAt;

    if (policy.observationLevel == MapPerformanceObservationLevel.off) {
      _ignoredCount += 1;
      return const MapPerformanceRecordResult.ignored();
    }

    (_aggregates[event.sample.kind] ??= MapMetricAccumulator(
      policy.reservoirCapacity,
    )).add(event.sample.value);
    _aggregatedCount += 1;
    if (policy.observationLevel == MapPerformanceObservationLevel.aggregate) {
      return const MapPerformanceRecordResult.aggregated();
    }

    _acceptedCount += 1;
    return const MapPerformanceRecordResult.accepted();
  }
}
