final class MapPercentileValue {
  const MapPercentileValue._({
    required this.percentile,
    required this.value,
  });

  final double percentile;
  final int value;
}

final class MapMetricAggregate {
  const MapMetricAggregate._({
    required this.count,
    required this.sum,
    required this.min,
    required this.max,
    required this.percentiles,
    required this.percentileSampleCount,
    required this.percentileDroppedCount,
  });

  final int count;
  final int sum;
  final int min;
  final int max;
  final List<MapPercentileValue> percentiles;
  final int percentileSampleCount;
  final int percentileDroppedCount;
}

MapPercentileValue createMapPercentileValue({
  required double percentile,
  required int value,
}) => MapPercentileValue._(percentile: percentile, value: value);

MapMetricAggregate createMapMetricAggregate({
  required int count,
  required int sum,
  required int min,
  required int max,
  required List<MapPercentileValue> percentiles,
  required int percentileSampleCount,
  required int percentileDroppedCount,
}) {
  if (count < 0 ||
      percentileSampleCount < 0 ||
      percentileDroppedCount < 0 ||
      percentileSampleCount + percentileDroppedCount != count) {
    throw ArgumentError('sample counts must be non-negative and sum to count');
  }

  return MapMetricAggregate._(
    count: count,
    sum: sum,
    min: min,
    max: max,
    percentiles: List.unmodifiable(percentiles),
    percentileSampleCount: percentileSampleCount,
    percentileDroppedCount: percentileDroppedCount,
  );
}
