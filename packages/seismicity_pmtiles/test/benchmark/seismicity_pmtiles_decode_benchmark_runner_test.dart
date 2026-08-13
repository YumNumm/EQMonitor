import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import '../../benchmark/seismicity_pmtiles_decode_benchmark_runner.dart';
import '../../benchmark/support/seismicity_benchmark_feature_source.dart';

void main() {
  const featureCount = 10_000;
  const tileCount = 10;
  const chunkCapacity = 1_024;

  test('validates 10k-row decode correctness without threshold', () async {
    final result = await runSeismicityDecodeBenchmark(
      featureCount: featureCount,
      tileCount: tileCount,
      chunkCapacity: chunkCapacity,
    );
    final source = const SeismicityBenchmarkFeatureSource();
    expect(result.workerSpawnCount, 1);
    expect(result.archiveCloseCount, 1);
    expect(result.featureCount, featureCount);
    expect(result.rawFeatureCount, featureCount);
    expect(result.uniqueFeatureCount, featureCount);
    expect(result.chunkFeatureSum, featureCount);
    expect(result.typedColumnBytes, result.expectedTypedColumnBytes);
    expect(result.firstHypocenterId, source.featureAt(index: 0).hypocenterId);
    expect(
      result.lastHypocenterId,
      source.featureAt(index: featureCount - 1).hypocenterId,
    );
    expect(result.descriptor.expectedFeatureCount, featureCount);
    expect(
      result.descriptor.dataZoom,
      SeismicityBenchmarkFeatureSource.dataZoom,
    );
    expect(result.elapsed.isNegative, isFalse);
    expect(result.rssBytes, greaterThan(0));
    expect(result.withinTarget, isNull);
    expect(result.informationalTimeThreshold, isNull);
  });

  test('threshold is informational and does not change success', () async {
    final zero = await runSeismicityDecodeBenchmark(
      featureCount: featureCount,
      tileCount: tileCount,
      chunkCapacity: chunkCapacity,
      informationalTimeThreshold: Duration.zero,
    );
    final large = await runSeismicityDecodeBenchmark(
      featureCount: featureCount,
      tileCount: tileCount,
      chunkCapacity: chunkCapacity,
      informationalTimeThreshold: const Duration(days: 1),
    );
    expect(zero.withinTarget, isFalse);
    expect(large.withinTarget, isTrue);
    expect(zero.featureCount, large.featureCount);
    expect(zero.typedColumnBytes, large.typedColumnBytes);
    expect(zero.workerSpawnCount, large.workerSpawnCount);
    expect(zero.archiveCloseCount, large.archiveCloseCount);
    expect(zero.firstHypocenterId, large.firstHypocenterId);
    expect(zero.lastHypocenterId, large.lastHypocenterId);
  });
}
