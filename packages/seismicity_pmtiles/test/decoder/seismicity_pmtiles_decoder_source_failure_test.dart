import 'dart:async';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
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
  final fixtures = _Task53Fixtures();

  test('invalid archive descriptor fails after archive cleanup', () async {
    const failure = SeismicityPmTilesException.unsupportedSchema(
      expected: 1,
      actual: 2,
    );
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(schemaVersion: 2),
      occupiedTileIds: const [1],
      tileBytes: {
        1: Uint8List.fromList([1]),
      },
    )..deferCloseCompletion = true;
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    final states = operation.states.toList();
    var resultCompleted = false;
    unawaited(operation.result.then((_) => resultCompleted = true));

    await fixtures.waitUntil(() => archive.closeCount == 1);
    expect(resultCompleted, isFalse);
    expect(factory.spawnCount, 0);
    expect(archive.readRequests, isEmpty);

    archive.releaseClose();
    final result = await operation.result;
    fixtures.expectFailure(
      result: result,
      states: await states,
      failure: failure,
    );
    expect(archive.closeCount, 1);
    expect(handle.closeCount, 0);
  });

  test(
    'enumeration failure closes archive and worker before failure',
    () async {
      final failure = SeismicityPmTilesException.sourceReadFailed(
        source: fixtures.source,
        reason: 'directory unavailable',
      );
      final archive =
          ControlledSeismicityArchive(
              descriptor: fixtures.descriptor(),
              occupiedTileIds: const [1],
              tileBytes: {
                1: Uint8List.fromList([1]),
              },
            )
            ..queueEnumerationFailure(error: failure)
            ..deferCloseCompletion = true;
      final handle = ControlledSeismicityDecoderWorkerHandle();
      final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
      final runner = SeismicityPmTilesDecoderRunner(factory: factory);
      final operation = runner.start(archive: archive, chunkCapacity: 4);
      final states = operation.states.toList();
      var resultCompleted = false;
      unawaited(operation.result.then((_) => resultCompleted = true));

      await fixtures.waitUntil(() => factory.spawnCount == 1);
      factory.succeedSpawn();
      await fixtures.waitUntil(() => archive.closeCount == 1);
      expect(resultCompleted, isFalse);
      expect(archive.zoomRequests, [2]);
      expect(archive.readRequests, isEmpty);

      archive.releaseClose();
      await fixtures.waitUntil(() => handle.closeCount == 1);
      handle.succeedClose();
      handle.succeedRetired();
      final result = await operation.result;
      fixtures.expectFailure(
        result: result,
        states: await states,
        failure: failure,
      );
      expect(handle.cancelCount, 0);
    },
  );

  test(
    'read failure after one acknowledgement stops requesting tiles',
    () async {
      final failure = SeismicityPmTilesException.sourceReadFailed(
        source: fixtures.source,
        reason: 'tile read failed',
      );
      final archive = ControlledSeismicityArchive(
        descriptor: fixtures.descriptor(),
        occupiedTileIds: const [1, 2, 3],
        tileBytes: {
          1: Uint8List.fromList([1]),
          2: Uint8List.fromList([2]),
          3: Uint8List.fromList([3]),
        },
      )..deferCloseCompletion = true;
      final handle = ControlledSeismicityDecoderWorkerHandle();
      final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
      final runner = SeismicityPmTilesDecoderRunner(factory: factory);
      final operation = runner.start(archive: archive, chunkCapacity: 4);
      final states = operation.states.toList();

      await fixtures.waitUntil(() => factory.spawnCount == 1);
      factory.succeedSpawn();
      await fixtures.waitUntil(() => handle.decodeCount == 1);
      archive.queueReadFailure(error: failure);
      handle.succeedDecode(progress: fixtures.progress(decodedTileCount: 1));
      await fixtures.waitUntil(() => archive.closeCount == 1);
      expect(archive.readRequests, [1, 2]);
      expect(handle.decodeCount, 1);
      expect(handle.finishCount, 0);

      archive.releaseClose();
      await fixtures.waitUntil(() => handle.closeCount == 1);
      handle.succeedClose();
      handle.succeedRetired();
      final result = await operation.result;
      fixtures.expectFailure(
        result: result,
        states: await states,
        failure: failure,
      );
      expect(archive.readRequests, [1, 2]);
      expect(handle.cancelCount, 0);
    },
  );

  test('typed worker decode failure closes source and worker', () async {
    const failure = SeismicityPmTilesException.invalidVectorTile(
      tileId: 1,
      reason: 'decode failed',
    );
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(),
      occupiedTileIds: const [1, 2],
      tileBytes: {
        1: Uint8List.fromList([1]),
        2: Uint8List.fromList([2]),
      },
    )..deferCloseCompletion = true;
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    final states = operation.states.toList();

    await fixtures.waitUntil(() => factory.spawnCount == 1);
    factory.succeedSpawn();
    await fixtures.waitUntil(() => handle.decodeCount == 1);
    handle.failDecode(error: failure);
    await fixtures.waitUntil(() => archive.closeCount == 1);
    expect(archive.readRequests, [1]);
    expect(handle.finishCount, 0);

    archive.releaseClose();
    await fixtures.waitUntil(() => handle.closeCount == 1);
    handle.succeedClose();
    handle.succeedRetired();
    final result = await operation.result;
    fixtures.expectFailure(
      result: result,
      states: await states,
      failure: failure,
    );
    expect(handle.cancelCount, 0);
  });

  test('typed finish failure closes source and worker', () async {
    const failure = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'finish failed',
    );
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(),
      occupiedTileIds: const [1],
      tileBytes: {
        1: Uint8List.fromList([1]),
      },
    )..deferCloseCompletion = true;
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    final states = operation.states.toList();

    await fixtures.waitUntil(() => factory.spawnCount == 1);
    factory.succeedSpawn();
    await fixtures.waitUntil(() => handle.decodeCount == 1);
    handle.succeedDecode(progress: fixtures.progress(decodedTileCount: 1));
    await fixtures.waitUntil(() => handle.finishCount == 1);
    handle.failFinish(error: failure);
    await fixtures.waitUntil(() => archive.closeCount == 1);

    archive.releaseClose();
    await fixtures.waitUntil(() => handle.closeCount == 1);
    handle.succeedClose();
    handle.succeedRetired();
    final result = await operation.result;
    fixtures.expectFailure(
      result: result,
      states: await states,
      failure: failure,
    );
    expect(handle.cancelCount, 0);
  });
}

final class _Task53Fixtures {
  final source = SeismicityPmTilesSource.network(
    archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
  );

  SeismicityPmTilesArchiveDescriptor descriptor({int schemaVersion = 1}) =>
      SeismicityPmTilesArchiveDescriptor(
        source: source,
        schemaVersion: schemaVersion,
        dataZoom: 2,
        expectedSizeBytes: 64,
        expectedFeatureCount: 0,
        archiveRevision: 'rev-task-53',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

  SeismicityPmTilesDecodeProgress progress({required int decodedTileCount}) =>
      SeismicityPmTilesDecodeProgress(
        decodedTileCount: decodedTileCount,
        rawFeatureCount: decodedTileCount,
        uniqueFeatureCount: decodedTileCount,
      );

  void expectFailure({
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
        throw StateError('Timed out waiting for source failure signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
