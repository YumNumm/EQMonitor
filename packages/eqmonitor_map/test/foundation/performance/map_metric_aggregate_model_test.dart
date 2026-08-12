import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates aggregate fields without retaining the percentile input', () {
    final p50 = createMapPercentileValue(percentile: 50, value: 4);
    final p95 = createMapPercentileValue(percentile: 95, value: 8);
    final input = <MapPercentileValue>[p50, p95];
    final aggregate = createMapMetricAggregate(
      count: 4,
      sum: 20,
      min: 2,
      max: 8,
      percentiles: input,
      percentileSampleCount: 3,
      percentileDroppedCount: 1,
    );
    input
      ..clear()
      ..add(createMapPercentileValue(percentile: 99, value: 10));

    expect((p50.percentile, p50.value), (50, 4));
    expect(
      (
        aggregate.count,
        aggregate.sum,
        aggregate.min,
        aggregate.max,
        aggregate.percentileSampleCount,
        aggregate.percentileDroppedCount,
      ),
      (4, 20, 2, 8, 3, 1),
    );
    expect(aggregate.percentiles, [p50, p95]);
    expect(
      () => aggregate.percentiles.add(p50),
      throwsUnsupportedError,
    );
  });

  test('rejects negative or inconsistent sample counts', () {
    for (final counts in [
      (count: -1, sampled: 0, dropped: 0),
      (count: 1, sampled: -1, dropped: 2),
      (count: 1, sampled: 2, dropped: -1),
      (count: 2, sampled: 1, dropped: 0),
      (count: 2, sampled: 2, dropped: 1),
    ]) {
      expect(
        () => createMapMetricAggregate(
          count: counts.count,
          sum: 0,
          min: 0,
          max: 0,
          percentiles: const [],
          percentileSampleCount: counts.sampled,
          percentileDroppedCount: counts.dropped,
        ),
        throwsArgumentError,
      );
    }
  });
}
