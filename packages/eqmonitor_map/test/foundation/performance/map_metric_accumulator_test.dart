import 'package:eqmonitor_map/src/foundation/performance/map_metric_aggregate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('aggregates every sample with nearest-rank percentiles', () {
    final accumulator = MapMetricAccumulator(4)
      ..add(1)
      ..add(2)
      ..add(3)
      ..add(4);

    final aggregate = accumulator.snapshot(const [25, 50, 95, 100]);

    expect(
      (
        aggregate.count,
        aggregate.sum,
        aggregate.min,
        aggregate.max,
        aggregate.percentileSampleCount,
        aggregate.percentileDroppedCount,
      ),
      (4, 10, 1, 4, 4, 0),
    );
    expect(
      aggregate.percentiles.map((value) => (value.percentile, value.value)),
      [(25, 1), (50, 2), (95, 4), (100, 4)],
    );
  });

  test('bounds percentile samples while retaining whole-stream aggregates', () {
    final accumulator = MapMetricAccumulator(2)
      ..add(1)
      ..add(2)
      ..add(3)
      ..add(4);

    final aggregate = accumulator.snapshot(const [50, 100]);

    expect(
      (
        aggregate.count,
        aggregate.sum,
        aggregate.min,
        aggregate.max,
        aggregate.percentileSampleCount,
        aggregate.percentileDroppedCount,
      ),
      (4, 10, 1, 4, 2, 2),
    );
    expect(
      aggregate.percentiles.map((value) => (value.percentile, value.value)),
      [(50, 3), (100, 4)],
    );
  });

  test('replaces samples by sequence modulo capacity deterministically', () {
    MapMetricAggregate collect() {
      final accumulator = MapMetricAccumulator(3);
      for (final sample in [9, 1, 7, 3, 5]) {
        accumulator.add(sample);
      }
      return accumulator.snapshot(const [50, 100]);
    }

    final first = collect();
    final second = collect();
    final firstValues = first.percentiles
        .map((value) => (value.percentile, value.value))
        .toList();

    expect(firstValues, [(50, 5), (100, 7)]);
    expect(
      second.percentiles.map((value) => (value.percentile, value.value)),
      firstValues,
    );
    expect(() => MapMetricAccumulator(0), throwsArgumentError);
  });
}
