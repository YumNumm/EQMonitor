import 'dart:io';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';

import 'support/counting_decoder_worker_factory.dart';
import 'support/seismicity_benchmark_archive.dart';

/// Correctness-first decode benchmark over Task 65/66 with a real worker.
final class SeismicityDecodeBenchmarkResult {
  const SeismicityDecodeBenchmarkResult({
    required this.featureCount,
    required this.tileCount,
    required this.chunkCapacity,
    required this.rawFeatureCount,
    required this.uniqueFeatureCount,
    required this.chunkFeatureSum,
    required this.typedColumnBytes,
    required this.expectedTypedColumnBytes,
    required this.workerSpawnCount,
    required this.archiveCloseCount,
    required this.elapsed,
    required this.rssBytes,
    required this.informationalTimeThreshold,
    required this.withinTarget,
    required this.firstHypocenterId,
    required this.lastHypocenterId,
    required this.descriptor,
  });

  final int featureCount;
  final int tileCount;
  final int chunkCapacity;
  final int rawFeatureCount;
  final int uniqueFeatureCount;
  final int chunkFeatureSum;
  final int typedColumnBytes;
  final int expectedTypedColumnBytes;
  final int workerSpawnCount;
  final int archiveCloseCount;
  final Duration elapsed;
  final int rssBytes;
  final Duration? informationalTimeThreshold;
  final bool? withinTarget;
  final Uint8List firstHypocenterId;
  final Uint8List lastHypocenterId;
  final SeismicityPmTilesArchiveDescriptor descriptor;
}

Future<SeismicityDecodeBenchmarkResult> runSeismicityDecodeBenchmark({
  required int featureCount,
  required int tileCount,
  required int chunkCapacity,
  Duration? informationalTimeThreshold,
}) async {
  if (featureCount <= 0 || tileCount <= 0 || chunkCapacity <= 0) {
    throw ArgumentError(
      'featureCount, tileCount, and chunkCapacity must be positive.',
    );
  }
  if (featureCount % tileCount != 0) {
    throw ArgumentError('featureCount must divide evenly by tileCount.');
  }
  final archive = SeismicityBenchmarkArchive(
    featureCount: featureCount,
    featuresPerTile: featureCount ~/ tileCount,
  );
  final counting = CountingDecoderWorkerFactory(
    delegate: IsolateSeismicityDecoderWorkerFactory(),
  );
  final runner = SeismicityPmTilesDecoderRunner(factory: counting);
  final states = <SeismicityPmTilesLoadState>[];
  final stopwatch = Stopwatch()..start();
  final operation = runner.start(
    archive: archive,
    chunkCapacity: chunkCapacity,
  );
  final subscription = operation.states.listen(states.add);
  final result = await operation.result;
  stopwatch.stop();
  await subscription.cancel();
  final rssBytes = ProcessInfo.currentRss;

  if (result case SeismicityPmTilesFailure(:final exception)) {
    throw exception;
  }
  final dataset =
      (result as SeismicityPmTilesSuccess<SeismicityPmTilesDataset>).value;
  const chunkValidator = SeismicityPmTilesChunkValidator();
  var chunkFeatureSum = 0;
  var typedColumnBytes = 0;
  for (final chunk in dataset.chunks) {
    chunkValidator.validate(chunk: chunk);
    final rowCount = chunk.latitudes.length;
    chunkFeatureSum += rowCount;
    typedColumnBytes +=
        chunk.hypocenterIds.lengthInBytes +
        chunk.latitudes.lengthInBytes +
        chunk.longitudes.lengthInBytes +
        chunk.depthsKm.lengthInBytes +
        chunk.magnitudes.lengthInBytes +
        chunk.originTimeUnixMilliseconds.lengthInBytes +
        chunk.maxIntensityDictionaryIndexes.lengthInBytes +
        chunk.maxIntensityDictionaryUtf8.lengthInBytes;
  }
  if (dataset.featureCount != featureCount ||
      chunkFeatureSum != featureCount ||
      dataset.archiveRevision != archive.descriptor.archiveRevision ||
      dataset.schemaVersion != archive.descriptor.schemaVersion ||
      dataset.dataZoom != archive.descriptor.dataZoom) {
    throw StateError('Benchmark dataset identity/count mismatch.');
  }
  if (typedColumnBytes != archive.expectedTotalPublicBytes) {
    throw StateError(
      'Typed-column bytes $typedColumnBytes != expected '
      '${archive.expectedTotalPublicBytes}.',
    );
  }
  final firstHypocenterId = Uint8List.fromList(
    dataset.chunks.first.hypocenterIds.sublist(0, 16),
  );
  final lastIds = dataset.chunks.last.hypocenterIds;
  final lastHypocenterId = Uint8List.fromList(
    lastIds.sublist(lastIds.lengthInBytes - 16),
  );
  if (!const _BenchmarkUuidBytes().equal(
        left: firstHypocenterId,
        right: archive.firstHypocenterId,
      ) ||
      !const _BenchmarkUuidBytes().equal(
        left: lastHypocenterId,
        right: archive.lastHypocenterId,
      )) {
    throw StateError('Benchmark first/last UUID mismatch.');
  }
  if (counting.spawnCount != 1 || archive.closeCount != 1) {
    throw StateError('Benchmark spawn/close invariant failed.');
  }
  final progress = states.reversed
      .whereType<SeismicityPmTilesLoadDecoding>()
      .map((state) => state.progress)
      .firstOrNull;
  if (progress == null ||
      progress.rawFeatureCount != featureCount ||
      progress.uniqueFeatureCount != featureCount ||
      progress.decodedTileCount != tileCount) {
    throw StateError('Benchmark progress counts mismatch.');
  }
  final withinTarget = informationalTimeThreshold == null
      ? null
      : !stopwatch.elapsed.isNegative &&
            stopwatch.elapsed <= informationalTimeThreshold;
  return SeismicityDecodeBenchmarkResult(
    featureCount: featureCount,
    tileCount: tileCount,
    chunkCapacity: chunkCapacity,
    rawFeatureCount: progress.rawFeatureCount,
    uniqueFeatureCount: progress.uniqueFeatureCount,
    chunkFeatureSum: chunkFeatureSum,
    typedColumnBytes: typedColumnBytes,
    expectedTypedColumnBytes: archive.expectedTotalPublicBytes,
    workerSpawnCount: counting.spawnCount,
    archiveCloseCount: archive.closeCount,
    elapsed: stopwatch.elapsed,
    rssBytes: rssBytes,
    informationalTimeThreshold: informationalTimeThreshold,
    withinTarget: withinTarget,
    firstHypocenterId: firstHypocenterId,
    lastHypocenterId: lastHypocenterId,
    descriptor: archive.descriptor,
  );
}

final class _BenchmarkUuidBytes {
  const _BenchmarkUuidBytes();

  bool equal({required Uint8List left, required Uint8List right}) {
    if (left.lengthInBytes != right.lengthInBytes) {
      return false;
    }
    for (var index = 0; index < left.lengthInBytes; index++) {
      if (left[index] != right[index]) {
        return false;
      }
    }
    return true;
  }
}
