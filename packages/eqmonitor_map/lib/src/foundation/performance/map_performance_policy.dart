enum MapPerformanceObservationLevel { off, aggregate, detailed }

enum MapPerformanceDropPolicy { dropOldest, dropNewest }

extension type const MapFrameBudget._(Duration duration) {}

final class MapPerformancePolicy {
  const MapPerformancePolicy._();
}

MapFrameBudget createMapFrameBudget({required Duration duration}) {
  if (duration <= Duration.zero) {
    throw ArgumentError.value(duration, 'duration', 'must be positive');
  }

  return MapFrameBudget._(duration);
}
