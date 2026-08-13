import 'dart:async';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decode_operation.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_archive.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_handle.dart';

void main() {
  final fixtures = _Task55Fixtures();

  test('archive close failure replaces success only', () async {
    final cleanupFailure = SeismicityPmTilesException.closed(
      source: fixtures.source,
    );
    final setup = fixtures.startSuccessPath(
      archiveMutator: (archive) {
        archive.queueCloseFailure(error: cleanupFailure);
      },
    );
    await fixtures.driveToFinish(setup: setup);
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: cleanupFailure,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 0);
  });

  test('worker close failure replaces success only', () async {
    final cleanupFailure = const SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'close failed',
    );
    final setup = fixtures.startSuccessPath();
    await fixtures.driveToFinish(setup: setup);
    await fixtures.waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.failClose(error: cleanupFailure);
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: cleanupFailure,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 1);
  });

  test('retirement failure replaces success only', () async {
    final cleanupFailure = const SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'retired failed',
    );
    final setup = fixtures.startSuccessPath();
    await fixtures.driveToFinish(setup: setup);
    await fixtures.waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.succeedClose();
    setup.handle.failRetired(error: cleanupFailure);
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: cleanupFailure,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 1);
  });

  test('cleanup failure never masks primary source failure', () async {
    final primary = SeismicityPmTilesException.sourceReadFailed(
      source: fixtures.source,
      reason: 'primary',
    );
    final cleanupFailure = SeismicityPmTilesException.closed(
      source: fixtures.source,
    );
    final setup = fixtures.startSuccessPath(
      archiveMutator: (archive) {
        archive
          ..queueEnumerationFailure(error: primary)
          ..queueCloseFailure(error: cleanupFailure);
      },
    );
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: primary,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 0);
  });

  test('cleanup failure never masks primary worker failure', () async {
    final primary = const SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'decode primary',
    );
    final cleanupFailure = const SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'close secondary',
    );
    final setup = fixtures.startSuccessPath();
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await fixtures.waitUntil(() => setup.handle.decodeCount == 1);
    setup.handle.failDecode(error: primary);
    await fixtures.waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.failClose(error: cleanupFailure);
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: primary,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 1);
  });

  test('cleanup remains memoized after cleanup failure', () async {
    final cleanupFailure = SeismicityPmTilesException.closed(
      source: fixtures.source,
    );
    final setup = fixtures.startSuccessPath(
      archiveMutator: (archive) {
        archive.queueCloseFailure(error: cleanupFailure);
      },
    );
    await fixtures.driveToFinish(setup: setup);
    final result = await setup.operation.result;
    expect(
      result,
      isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
        (value) => value.exception,
        'exception',
        cleanupFailure,
      ),
    );
    await setup.operation.cancel();
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.closeCount, 0);
    expect(setup.handle.cancelCount, 0);
  });
}

final class _Task55Setup {
  _Task55Setup({
    required this.archive,
    required this.handle,
    required this.factory,
    required this.operation,
    required this.states,
  });

  final ControlledSeismicityArchive archive;
  final ControlledSeismicityDecoderWorkerHandle handle;
  final ControlledSeismicityDecoderWorkerFactory factory;
  final SeismicityPmTilesDecodeOperation operation;
  final Future<List<SeismicityPmTilesLoadState>> states;
}

final class _Task55Fixtures {
  final source = SeismicityPmTilesSource.network(
    archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
  );

  SeismicityPmTilesArchiveDescriptor descriptor() =>
      SeismicityPmTilesArchiveDescriptor(
        source: source,
        schemaVersion: 1,
        dataZoom: 2,
        expectedSizeBytes: 64,
        expectedFeatureCount: 1,
        archiveRevision: 'rev-task-55',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

  SeismicityPmTilesChunk chunk() => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List.fromList(List.filled(16, 1)),
    latitudes: Float64List.fromList([35]),
    longitudes: Float64List.fromList([139]),
    depthsKm: Float32List.fromList([double.nan]),
    depthValidity: Uint8List(1),
    magnitudes: Float32List.fromList([double.nan]),
    magnitudeValidity: Uint8List(1),
    originTimeUnixMilliseconds: Int64List.fromList([1]),
    maxIntensityDictionaryIndexes: Uint32List(1),
    maxIntensityValidity: Uint8List(1),
    maxIntensityDictionaryUtf8: Uint8List(0),
    maxIntensityDictionaryOffsets: Uint32List.fromList([0]),
  );

  _Task55Setup startSuccessPath({
    void Function(ControlledSeismicityArchive archive)? archiveMutator,
  }) {
    final descriptor = this.descriptor();
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor,
      occupiedTileIds: const [1],
      tileBytes: {
        1: Uint8List.fromList([1]),
      },
    );
    archiveMutator?.call(archive);
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    return _Task55Setup(
      archive: archive,
      handle: handle,
      factory: factory,
      operation: operation,
      states: operation.states.toList(),
    );
  }

  Future<void> driveToFinish({required _Task55Setup setup}) async {
    final descriptor = this.descriptor();
    await waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await waitUntil(() => setup.handle.decodeCount == 1);
    setup.handle.succeedDecode(
      progress: const SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 1,
        uniqueFeatureCount: 1,
      ),
    );
    await waitUntil(() => setup.handle.finishCount == 1);
    setup.handle.succeedFinish(
      dataset: SeismicityPmTilesDataset(
        archiveRevision: descriptor.archiveRevision,
        schemaVersion: descriptor.schemaVersion,
        dataZoom: descriptor.dataZoom,
        featureCount: descriptor.expectedFeatureCount,
        chunks: [chunk()],
      ),
    );
  }

  void expectExactFailure({
    required SeismicityPmTilesResult<SeismicityPmTilesDataset> result,
    required List<SeismicityPmTilesLoadState> states,
    required SeismicityPmTilesException failure,
  }) {
    expect(
      result,
      isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
        (value) => value.exception,
        'exception',
        failure,
      ),
    );
    expect(
      states,
      isNot(contains(const SeismicityPmTilesLoadState.completed())),
    );
    expect(
      states.whereType<SeismicityPmTilesLoadFailed>().single.exception,
      failure,
    );
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for Task 55 signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
