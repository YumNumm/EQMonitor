import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_event.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_policy.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_snapshot.dart';

enum MapPerformanceRecordResultKind {
  accepted,
  aggregated,
  ignored,
  rejected,
}

final class MapPerformanceRecordResult {
  const MapPerformanceRecordResult.accepted()
    : this._(kind: MapPerformanceRecordResultKind.accepted);

  const MapPerformanceRecordResult.aggregated()
    : this._(kind: MapPerformanceRecordResultKind.aggregated);

  const MapPerformanceRecordResult.ignored()
    : this._(kind: MapPerformanceRecordResultKind.ignored);

  const MapPerformanceRecordResult.rejected()
    : this._(kind: MapPerformanceRecordResultKind.rejected);

  const MapPerformanceRecordResult._({
    required this.kind,
    this.completedSnapshots = const [],
  });

  final MapPerformanceRecordResultKind kind;
  final List<MapPerformanceSnapshot> completedSnapshots;
}

final class MapPerformanceCollector {
  MapPerformanceCollector({
    required this.policy,
    required Duration windowStartedAt,
  }) : _windowStartedAt = windowStartedAt {
    if (windowStartedAt.isNegative) {
      throw ArgumentError.value(
        windowStartedAt,
        'windowStartedAt',
        'must not be negative',
      );
    }
  }

  final MapPerformancePolicy policy;
  Duration _windowStartedAt;

  Duration get windowStartedAt => _windowStartedAt;

  final Map<MapPerformanceMetricKind, MapMetricAccumulator> _aggregates = {};
  Duration? _lastMonotonicAt;
  Duration? _lastPartialAt;
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
    final completedSnapshots = advanceWindows(event.sample.monotonicAt);

    if (policy.observationLevel == MapPerformanceObservationLevel.off) {
      _ignoredCount += 1;
      return MapPerformanceRecordResult._(
        kind: MapPerformanceRecordResultKind.ignored,
        completedSnapshots: completedSnapshots,
      );
    }

    (_aggregates[event.sample.kind] ??= MapMetricAccumulator(
      policy.reservoirCapacity,
    )).add(event.sample.value);
    _aggregatedCount += 1;
    if (policy.observationLevel == MapPerformanceObservationLevel.aggregate) {
      return MapPerformanceRecordResult._(
        kind: MapPerformanceRecordResultKind.aggregated,
        completedSnapshots: completedSnapshots,
      );
    }

    _acceptedCount += 1;
    return MapPerformanceRecordResult._(
      kind: MapPerformanceRecordResultKind.accepted,
      completedSnapshots: completedSnapshots,
    );
  }

  MapPerformanceSnapshot? takePartialSnapshot(Duration at) {
    final nextPartialAt =
        (_lastPartialAt ?? windowStartedAt) + policy.snapshotInterval;
    if (at < nextPartialAt ||
        at >= windowStartedAt + policy.aggregationWindow ||
        at <= windowStartedAt) {
      return null;
    }
    _lastPartialAt = at;
    return _buildMapPerformanceSnapshot(
      collector: this,
      windowEndedAt: at,
      isPartial: true,
    );
  }

  List<MapPerformanceSnapshot> advanceWindows(Duration until) {
    final completed = <MapPerformanceSnapshot>[];
    while (until >= windowStartedAt + policy.aggregationWindow) {
      final endedAt = windowStartedAt + policy.aggregationWindow;
      completed.add(
        _buildMapPerformanceSnapshot(
          collector: this,
          windowEndedAt: endedAt,
          isPartial: false,
        ),
      );
      _windowStartedAt = endedAt;
      _aggregates.clear();
      _lastPartialAt = null;
    }
    return List.unmodifiable(completed);
  }
}

MapPerformanceSnapshot _buildMapPerformanceSnapshot({
  required MapPerformanceCollector collector,
  required Duration windowEndedAt,
  required bool isPartial,
}) => createMapPerformanceSnapshot(
  schemaVersion: collector.policy.schemaVersion,
  clockDomain: collector.policy.clockDomain,
  windowStartedAt: collector.windowStartedAt,
  windowEndedAt: windowEndedAt,
  isPartial: isPartial,
  metrics: {
    for (final entry in collector._aggregates.entries)
      entry.key: entry.value.snapshot(collector.policy.percentiles),
  },
  counters: const {},
);
