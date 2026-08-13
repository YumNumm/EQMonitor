import 'dart:async';
import 'dart:io';

import 'seismicity_benchmark_arguments.dart';
import 'seismicity_pmtiles_decode_benchmark_runner.dart';

typedef SeismicityDecodeBenchmarkRun =
    Future<SeismicityDecodeBenchmarkResult> Function({
      required int featureCount,
      required int tileCount,
      required int chunkCapacity,
      Duration? informationalTimeThreshold,
    });

/// CLI adapter: one JSON line on stdout; correctness-only nonzero exits.
Future<int> runSeismicityDecodeBenchmarkCli({
  required List<String> arguments,
  required StringSink stdout,
  required StringSink stderr,
  SeismicityDecodeBenchmarkRun runBenchmark = runSeismicityDecodeBenchmark,
}) async {
  try {
    final args = const SeismicityBenchmarkArgumentsParser().parse(
      arguments: arguments,
    );
    final result = await runBenchmark(
      featureCount: args.featureCount,
      tileCount: args.tileCount,
      chunkCapacity: args.chunkCapacity,
      informationalTimeThreshold: args.informationalTimeThreshold,
    );
    stdout.writeln(const SeismicityBenchmarkJsonWriter().write(result: result));
    return 0;
  } on SeismicityBenchmarkArgumentsException catch (error) {
    stderr.writeln(error.message);
    return 64;
  } catch (error, stackTrace) {
    stderr
      ..writeln(error)
      ..writeln(stackTrace);
    return 1;
  }
}

/// Fixed-key JSON writer without retaining a string-key result map.
final class SeismicityBenchmarkJsonWriter {
  const SeismicityBenchmarkJsonWriter();

  String write({required SeismicityDecodeBenchmarkResult result}) {
    final threshold = result.informationalTimeThreshold;
    final withinTarget = result.withinTarget;
    final thresholdJson = threshold == null
        ? 'null'
        : '${threshold.inMilliseconds}';
    final withinTargetJson = withinTarget == null ? 'null' : '$withinTarget';
    return '{"feature_count":${result.featureCount},'
        '"tile_count":${result.tileCount},'
        '"chunk_capacity":${result.chunkCapacity},'
        '"raw_feature_count":${result.rawFeatureCount},'
        '"unique_feature_count":${result.uniqueFeatureCount},'
        '"chunk_feature_sum":${result.chunkFeatureSum},'
        '"typed_column_bytes":${result.typedColumnBytes},'
        '"expected_typed_column_bytes":${result.expectedTypedColumnBytes},'
        '"worker_spawn_count":${result.workerSpawnCount},'
        '"archive_close_count":${result.archiveCloseCount},'
        '"elapsed_ms":${result.elapsed.inMilliseconds},'
        '"rss_bytes":${result.rssBytes},'
        '"informational_time_threshold_ms":$thresholdJson,'
        '"within_target":$withinTargetJson}';
  }
}

Future<void> main(List<String> arguments) async {
  exitCode = await runSeismicityDecodeBenchmarkCli(
    arguments: arguments,
    stdout: stdout,
    stderr: stderr,
  );
}
