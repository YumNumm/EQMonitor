import 'package:eqmonitor_map/src/foundation/frame/map_clock.dart';
import 'package:eqmonitor_map/src/foundation/performance/map_performance_metric.dart';

enum MapPerformanceObservationLevel { off, aggregate, detailed }

enum MapPerformanceDropPolicy { dropOldest, dropNewest }

extension type const MapFrameBudget._(Duration duration) {}

final class MapPerformancePolicy {
  const MapPerformancePolicy._({
    required this.schemaVersion,
    required this.clockDomain,
    required this.observationLevel,
    required this.aggregationWindow,
    required this.percentiles,
    required this.snapshotInterval,
    required this.reservoirCapacity,
    required this.sampleEveryFrames,
    required this.minimumEventInterval,
    required this.eventBufferCapacity,
    required this.dropPolicy,
    required this.frameBudget,
  });

  final MapPerformanceSchemaVersion schemaVersion;
  final MapClockDomainId clockDomain;
  final MapPerformanceObservationLevel observationLevel;
  final Duration aggregationWindow;
  final List<double> percentiles;
  final Duration snapshotInterval;
  final int reservoirCapacity;
  final int sampleEveryFrames;
  final Duration minimumEventInterval;
  final int eventBufferCapacity;
  final MapPerformanceDropPolicy dropPolicy;
  final MapFrameBudget frameBudget;
}

MapFrameBudget createMapFrameBudget({required Duration duration}) {
  if (duration <= Duration.zero) {
    throw ArgumentError.value(duration, 'duration', 'must be positive');
  }

  return MapFrameBudget._(duration);
}

MapPerformancePolicy createMapPerformancePolicy({
  required MapPerformanceSchemaVersion schemaVersion,
  required MapClockDomainId clockDomain,
  required MapPerformanceObservationLevel observationLevel,
  required Duration aggregationWindow,
  required List<double> percentiles,
  required Duration snapshotInterval,
  required int reservoirCapacity,
  required int sampleEveryFrames,
  required Duration minimumEventInterval,
  required int eventBufferCapacity,
  required MapPerformanceDropPolicy dropPolicy,
  required MapFrameBudget frameBudget,
}) {
  if (aggregationWindow <= Duration.zero ||
      snapshotInterval <= Duration.zero ||
      snapshotInterval > aggregationWindow ||
      minimumEventInterval <= Duration.zero) {
    throw ArgumentError('durations must be positive and within the window');
  }
  if (reservoirCapacity <= 0 ||
      sampleEveryFrames <= 0 ||
      eventBufferCapacity <= 0) {
    throw ArgumentError('capacities must be positive');
  }
  if (percentiles.isEmpty) {
    throw ArgumentError.value(percentiles, 'percentiles');
  }
  var previous = 0.0;
  for (final percentile in percentiles) {
    if (!percentile.isFinite || percentile <= previous || percentile > 100) {
      throw ArgumentError.value(percentiles, 'percentiles');
    }
    previous = percentile;
  }

  return MapPerformancePolicy._(
    schemaVersion: schemaVersion,
    clockDomain: clockDomain,
    observationLevel: observationLevel,
    aggregationWindow: aggregationWindow,
    percentiles: List.unmodifiable(percentiles),
    snapshotInterval: snapshotInterval,
    reservoirCapacity: reservoirCapacity,
    sampleEveryFrames: sampleEveryFrames,
    minimumEventInterval: minimumEventInterval,
    eventBufferCapacity: eventBufferCapacity,
    dropPolicy: dropPolicy,
    frameBudget: frameBudget,
  );
}
