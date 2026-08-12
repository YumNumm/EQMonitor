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

  final _acceptedCount = 0;
  final _aggregatedCount = 0;
  final _ignoredCount = 0;
  final _rejectedCount = 0;
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
}
