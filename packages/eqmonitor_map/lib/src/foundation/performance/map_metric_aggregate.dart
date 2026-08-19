final class MapPercentileValue {
  const new _({
    required this.percentile,
    required this.value,
  });

  final double percentile;
  final int value;
}

final class MapMetricAggregate {
  const new _({
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

final class MapMetricAccumulator {
  new(this._maxSamples) {
    if (_maxSamples <= 0) {
      throw ArgumentError.value(_maxSamples, 'maxSamples', 'must be positive');
    }
  }

  final int _maxSamples;
  final List<int> _samples = [];
  var _count = 0;
  var _sum = 0;
  int? _min;
  int? _max;

  void add(int sample) {
    if (_samples.length < _maxSamples) {
      _samples.add(sample);
    } else {
      _samples[_count % _maxSamples] = sample;
    }
    _count += 1;
    _sum += sample;

    final min = _min;
    if (min == null || sample < min) {
      _min = sample;
    }
    final max = _max;
    if (max == null || sample > max) {
      _max = sample;
    }
  }

  MapMetricAggregate snapshot(List<double> percentiles) {
    final min = _min;
    final max = _max;
    if (min == null || max == null) {
      throw StateError('cannot snapshot an empty accumulator');
    }

    final samples = List<int>.of(_samples)..sort();
    final values = <MapPercentileValue>[];
    for (final percentile in percentiles) {
      final rank = (percentile * samples.length / 100).ceil();
      values.add(
        createMapPercentileValue(
          percentile: percentile,
          value: samples[rank - 1],
        ),
      );
    }

    return createMapMetricAggregate(
      count: _count,
      sum: _sum,
      min: min,
      max: max,
      percentiles: values,
      percentileSampleCount: samples.length,
      percentileDroppedCount: _count - samples.length,
    );
  }
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
