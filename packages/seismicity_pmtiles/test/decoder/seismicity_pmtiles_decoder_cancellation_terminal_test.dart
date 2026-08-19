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
  final fixtures = _Task60Fixtures();

  test('cancel after acknowledgement wins before finish', () async {
    final setup = fixtures.start(
      occupiedTileIds: const [1, 2],
      tileBytes: {
        1: Uint8List.fromList([1]),
        2: Uint8List.fromList([2]),
      },
    );
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await fixtures.waitUntil(() => setup.handle.decodeCount == 1);
    setup.archive.pauseBeforeNextRead();
    setup.handle.succeedDecode(
      progress: const SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 1,
        uniqueFeatureCount: 1,
      ),
    );
    await fixtures.waitUntil(() => setup.archive.readRequests.length == 2);
    expect(setup.handle.finishCount, 0);

    final first = setup.operation.cancel();
    final second = setup.operation.cancel();
    expect(identical(first, second), isTrue);
    setup.handle.succeedCancel();
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    await Future.wait<void>([first, second]);

    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 1);
    expect(setup.handle.closeCount, 1);
    expect(setup.handle.finishCount, 0);
  });

  test('cancel during finish wins before authoritative result', () async {
    final setup = fixtures.start();
    await fixtures.driveThroughAck(setup: setup);
    await fixtures.waitUntil(() => setup.handle.finishCount == 1);

    final first = setup.operation.cancel();
    final second = setup.operation.cancel();
    setup.handle.succeedCancel();
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    await Future.wait<void>([first, second]);

    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 1);
    expect(setup.handle.closeCount, 1);
  });

  test('cancel after completed result preserves success', () async {
    final setup = fixtures.start();
    await fixtures.driveToSuccess(setup: setup);
    final result = await setup.operation.result;
    final states = await setup.states;

    await setup.operation.cancel();
    expect(result, isA<SeismicityPmTilesSuccess<SeismicityPmTilesDataset>>());
    expect(states, contains(const SeismicityPmTilesLoadState.completed()));
    expect(
      states,
      isNot(contains(const SeismicityPmTilesLoadState.cancelled())),
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
    expect(setup.handle.closeCount, 1);
  });

  test('spawn failure is not masked by late cancel', () async {
    const primary = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'spawn primary',
    );
    final setup = fixtures.start();
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.failSpawn(error: primary);
    final result = await setup.operation.result;
    await setup.operation.cancel();
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: primary,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
    expect(setup.handle.closeCount, 0);
  });

  test('cancel before spawn failure keeps cancelled', () async {
    const primary = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'spawn late',
    );
    final setup = fixtures.start();
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    final cancel = setup.operation.cancel();
    await fixtures.waitUntil(() => setup.archive.closeCount == 1);
    await cancel;
    setup.factory.failSpawn(error: primary);
    final result = await setup.operation.result;
    final states = await setup.states;
    fixtures.expectCancelled(result: result, states: states);
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
  });

  test('read failure is not masked by late cancel', () async {
    final primary = SeismicityPmTilesException.sourceReadFailed(
      source: fixtures.source,
      reason: 'read primary',
    );
    final setup = fixtures.start(
      archiveMutator: (archive) {
        archive.queueReadFailure(error: primary);
      },
    );
    await fixtures.waitUntil(() => setup.factory.spawnCount == 1);
    setup.factory.succeedSpawn();
    await fixtures.waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    final result = await setup.operation.result;
    await setup.operation.cancel();
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: primary,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
    expect(setup.handle.closeCount, 1);
  });

  test('worker finish failure is not masked by late cancel', () async {
    const primary = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'finish primary',
    );
    final setup = fixtures.start();
    await fixtures.driveThroughAck(setup: setup);
    await fixtures.waitUntil(() => setup.handle.finishCount == 1);
    setup.handle.failFinish(error: primary);
    await fixtures.waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
    final result = await setup.operation.result;
    await setup.operation.cancel();
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: primary,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
    expect(setup.handle.closeCount, 1);
  });

  test('archive-close failure after success is surfaced once', () async {
    final cleanupFailure = SeismicityPmTilesException.closed(
      source: fixtures.source,
    );
    final setup = fixtures.start(
      archiveMutator: (archive) {
        archive.queueCloseFailure(error: cleanupFailure);
      },
    );
    await fixtures.driveThroughAck(setup: setup);
    await fixtures.waitUntil(() => setup.handle.finishCount == 1);
    setup.handle.succeedFinish(dataset: fixtures.dataset());
    final result = await setup.operation.result;
    await setup.operation.cancel();
    final states = await setup.states;
    fixtures.expectExactFailure(
      result: result,
      states: states,
      failure: cleanupFailure,
    );
    expect(setup.archive.closeCount, 1);
    expect(setup.handle.cancelCount, 0);
    expect(setup.handle.closeCount, 0);
  });
}

final class _Task60Setup {
  new({
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

final class _Task60Fixtures {
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
        archiveRevision: 'rev-task-60',
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

  SeismicityPmTilesDataset dataset() {
    final descriptor = this.descriptor();
    return SeismicityPmTilesDataset(
      archiveRevision: descriptor.archiveRevision,
      schemaVersion: descriptor.schemaVersion,
      dataZoom: descriptor.dataZoom,
      featureCount: descriptor.expectedFeatureCount,
      chunks: [chunk()],
    );
  }

  _Task60Setup start({
    void Function(ControlledSeismicityArchive archive)? archiveMutator,
    List<int> occupiedTileIds = const [1],
    Map<int, Uint8List>? tileBytes,
  }) {
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor(),
      occupiedTileIds: occupiedTileIds,
      tileBytes:
          tileBytes ??
          {
            1: Uint8List.fromList([1]),
          },
    );
    archiveMutator?.call(archive);
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    return _Task60Setup(
      archive: archive,
      handle: handle,
      factory: factory,
      operation: operation,
      states: operation.states.toList(),
    );
  }

  Future<void> driveThroughAck({required _Task60Setup setup}) async {
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
  }

  Future<void> driveToSuccess({required _Task60Setup setup}) async {
    await driveThroughAck(setup: setup);
    await waitUntil(() => setup.handle.finishCount == 1);
    setup.handle.succeedFinish(dataset: dataset());
    await waitUntil(() => setup.handle.closeCount == 1);
    setup.handle.succeedClose();
    setup.handle.succeedRetired();
  }

  void expectCancelled({
    required SeismicityPmTilesResult<SeismicityPmTilesDataset> result,
    required List<SeismicityPmTilesLoadState> states,
  }) {
    expect(
      result,
      isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>().having(
        (value) => value.exception,
        'exception',
        isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
          (value) => value.reason,
          'reason',
          'cancelled',
        ),
      ),
    );
    expect(states, contains(const SeismicityPmTilesLoadState.cancelled()));
    expect(
      states,
      isNot(contains(const SeismicityPmTilesLoadState.completed())),
    );
    expect(states.whereType<SeismicityPmTilesLoadCancelled>().length, 1);
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
      states,
      isNot(contains(const SeismicityPmTilesLoadState.cancelled())),
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
        throw StateError('Timed out waiting for Task 60 signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
