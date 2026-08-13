import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

import '../../benchmark/seismicity_pmtiles_decode_benchmark.dart';
import '../../benchmark/seismicity_pmtiles_decode_benchmark_runner.dart';

void main() {
  test('writes fixed-key JSON and exits zero on success', () async {
    final stdout = StringBuffer();
    final stderr = StringBuffer();
    final code = await runSeismicityDecodeBenchmarkCli(
      arguments: const [
        '--features',
        '10000',
        '--features-per-tile',
        '1000',
        '--chunk-capacity',
        '1024',
        '--informational-time-threshold-ms',
        '60000',
      ],
      stdout: stdout,
      stderr: stderr,
      runBenchmark: _fakeSuccess,
    );
    expect(code, 0);
    expect(stderr.toString(), isEmpty);
    final json = jsonDecode(stdout.toString().trim()) as Map<String, dynamic>;
    expect(json['feature_count'], 10_000);
    expect(json['tile_count'], 10);
    expect(json['chunk_capacity'], 1_024);
    expect(json['raw_feature_count'], 10_000);
    expect(json['unique_feature_count'], 10_000);
    expect(json['chunk_feature_sum'], 10_000);
    expect(json['typed_column_bytes'], 520_000);
    expect(json['expected_typed_column_bytes'], 520_000);
    expect(json['worker_spawn_count'], 1);
    expect(json['archive_close_count'], 1);
    expect(json['elapsed_ms'], 12);
    expect(json['rss_bytes'], 99);
    expect(json['informational_time_threshold_ms'], 60_000);
    expect(json['within_target'], isTrue);
  });

  test('maps correctness failure nonzero and threshold miss zero', () async {
    final failStdout = StringBuffer();
    final failStderr = StringBuffer();
    final failCode = await runSeismicityDecodeBenchmarkCli(
      arguments: const ['--features', '1000', '--features-per-tile', '1000'],
      stdout: failStdout,
      stderr: failStderr,
      runBenchmark:
          ({
            required int featureCount,
            required int tileCount,
            required int chunkCapacity,
            Duration? informationalTimeThreshold,
          }) async {
            throw StateError('worker count mismatch');
          },
    );
    expect(failCode, 1);
    expect(failStdout.toString(), isEmpty);
    expect(failStderr.toString(), contains('worker count mismatch'));

    final missStdout = StringBuffer();
    final missCode = await runSeismicityDecodeBenchmarkCli(
      arguments: const [
        '--features',
        '1000',
        '--features-per-tile',
        '1000',
        '--informational-time-threshold-ms',
        '1',
      ],
      stdout: missStdout,
      stderr: StringBuffer(),
      runBenchmark:
          ({
            required int featureCount,
            required int tileCount,
            required int chunkCapacity,
            Duration? informationalTimeThreshold,
          }) async => _result(
            featureCount: featureCount,
            tileCount: tileCount,
            chunkCapacity: chunkCapacity,
            informationalTimeThreshold: informationalTimeThreshold,
            withinTarget: false,
          ),
    );
    expect(missCode, 0);
    final missJson =
        jsonDecode(missStdout.toString().trim()) as Map<String, dynamic>;
    expect(missJson['within_target'], isFalse);
  });

  test('rejects bad CLI args with usage exit 64', () async {
    final code = await runSeismicityDecodeBenchmarkCli(
      arguments: const ['--features'],
      stdout: StringBuffer(),
      stderr: StringBuffer(),
      runBenchmark: _fakeSuccess,
    );
    expect(code, 64);
  });
}

Future<SeismicityDecodeBenchmarkResult> _fakeSuccess({
  required int featureCount,
  required int tileCount,
  required int chunkCapacity,
  Duration? informationalTimeThreshold,
}) async => _result(
  featureCount: featureCount,
  tileCount: tileCount,
  chunkCapacity: chunkCapacity,
  informationalTimeThreshold: informationalTimeThreshold,
  withinTarget: informationalTimeThreshold == null ? null : true,
);

SeismicityDecodeBenchmarkResult _result({
  required int featureCount,
  required int tileCount,
  required int chunkCapacity,
  required Duration? informationalTimeThreshold,
  required bool? withinTarget,
}) => SeismicityDecodeBenchmarkResult(
  featureCount: featureCount,
  tileCount: tileCount,
  chunkCapacity: chunkCapacity,
  rawFeatureCount: featureCount,
  uniqueFeatureCount: featureCount,
  chunkFeatureSum: featureCount,
  typedColumnBytes: featureCount * 52,
  expectedTypedColumnBytes: featureCount * 52,
  workerSpawnCount: 1,
  archiveCloseCount: 1,
  elapsed: const Duration(milliseconds: 12),
  rssBytes: 99,
  informationalTimeThreshold: informationalTimeThreshold,
  withinTarget: withinTarget,
  firstHypocenterId: Uint8List(16),
  lastHypocenterId: Uint8List(16),
  descriptor: SeismicityPmTilesArchiveDescriptor(
    source: const SeismicityPmTilesSource.asset(
      assetKey: 'benchmark.seismicity.pmtiles',
    ),
    schemaVersion: 1,
    dataZoom: 6,
    expectedSizeBytes: featureCount * 52,
    expectedFeatureCount: featureCount,
    archiveRevision: 'benchmark',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  ),
);
