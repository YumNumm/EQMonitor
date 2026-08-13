import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_isolate_launcher.dart';

void main() {
  final fixtures = _Task44Fixtures();

  test('invalid finish settles pending and retires once after kill', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final handle = await fixtures.spawnReady(
      controlled: controlled,
      expectedFeatureCount: 1,
    );
    final finish = handle.finish();
    await fixtures.waitUntil(
      () => controlled.sent.any(
        (request) => request is SeismicityDecoderWorkerFinishRequest,
      ),
    );
    final finishId = controlled.sent
        .whereType<SeismicityDecoderWorkerFinishRequest>()
        .single
        .requestId;
    final invalid = expectLater(
      finish,
      throwsA(isA<SeismicityPmTilesException>()),
    );
    controlled.emitInvalidTransfer(
      requestId: finishId,
      invalidChunk: fixtures.corruptOffsetChunk(),
    );
    await invalid;
    await handle.retired;
    expect(controlled.closeReceivePortCount, 1);
    expect(controlled.killCount, 1);
    await handle.retired;
    expect(controlled.killCount, 1);
  });

  test('crash settles pending decode and retires after exited', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final handle = await fixtures.spawnReady(
      controlled: controlled,
      expectedFeatureCount: 1,
    );
    final pending = handle.decode(
      tileBytes: TransferableTypedData.fromList([Uint8List(1)]),
    );
    await fixtures.waitUntil(
      () => controlled.sent
              .whereType<SeismicityDecoderWorkerDecodeRequest>()
              .length ==
          1,
    );
    final crashed = expectLater(
      pending,
      throwsA(isA<SeismicityPmTilesException>()),
    );
    controlled.crash(message: 'boom');
    await crashed;
    await handle.retired;
    expect(controlled.closeReceivePortCount, 1);
    expect(controlled.killCount, 1);
  });

  test('unexpected port close settles and retires once', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final handle = await fixtures.spawnReady(
      controlled: controlled,
      expectedFeatureCount: 1,
    );
    final pending = handle.decode(
      tileBytes: TransferableTypedData.fromList([Uint8List(1)]),
    );
    await fixtures.waitUntil(
      () => controlled.sent
              .whereType<SeismicityDecoderWorkerDecodeRequest>()
              .length ==
          1,
    );
    final closed = expectLater(
      pending,
      throwsA(isA<SeismicityPmTilesException>()),
    );
    await controlled.closePorts();
    await closed;
    await handle.retired;
    expect(controlled.closeReceivePortCount, 1);
    expect(controlled.killCount, 1);
  });

  test('cancel and close are memoized and never send worker cancel', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final handle = await fixtures.spawnReady(
      controlled: controlled,
      expectedFeatureCount: 1,
    );
    final pending = handle.decode(
      tileBytes: TransferableTypedData.fromList([Uint8List(1)]),
    );
    await fixtures.waitUntil(
      () => controlled.sent
              .whereType<SeismicityDecoderWorkerDecodeRequest>()
              .length ==
          1,
    );
    final sentBefore = controlled.sent.length;
    final cancelled = expectLater(
      pending,
      throwsA(isA<SeismicityPmTilesException>()),
    );
    final first = handle.cancel();
    final second = handle.cancel();
    await Future.wait<void>([cancelled, first, second, handle.retired]);
    expect(controlled.sent.length, sentBefore);
    expect(controlled.killCount, 1);
    expect(controlled.closeReceivePortCount, 1);

    final closer = ControlledSeismicityIsolateLauncher();
    final closeHandle = await fixtures.spawnReady(
      controlled: closer,
      expectedFeatureCount: 0,
    );
    await Future.wait<void>([closeHandle.close(), closeHandle.close()]);
    await closeHandle.retired;
    expect(closer.killCount, 1);
    expect(closer.closeReceivePortCount, 1);
  });

  test('late exit after success keeps sticky result and retires once', () async {
    final controlled = ControlledSeismicityIsolateLauncher();
    final handle = await fixtures.spawnReady(
      controlled: controlled,
      expectedFeatureCount: 1,
    );
    final descriptor = fixtures.descriptor(expectedFeatureCount: 1);
    final finish = handle.finish();
    await fixtures.waitUntil(
      () => controlled.sent.any(
        (request) => request is SeismicityDecoderWorkerFinishRequest,
      ),
    );
    final finishId = controlled.sent
        .whereType<SeismicityDecoderWorkerFinishRequest>()
        .single
        .requestId;
    controlled.emitResponse(
      response: SeismicityDecoderWorkerResponse.finished(
        requestId: finishId,
        datasetTransfer: fixtures.transfer(descriptor: descriptor),
      ),
    );
    final dataset = await finish;
    await handle.retired;
    expect(controlled.killCount, 0);
    expect(controlled.closeReceivePortCount, 1);

    controlled.exit();
    await handle.cancel();
    expect(identical(dataset, await finish), isTrue);
    expect(controlled.killCount, 1);
    await handle.retired;
    expect(controlled.killCount, 1);
  });
}

final class _Task44Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: SeismicityPmTilesSource.network(
      archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
    ),
    schemaVersion: 1,
    dataZoom: 0,
    expectedSizeBytes: 128,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-44',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityDatasetTransfer transfer({
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) => SeismicityDatasetTransfer(
    archiveRevision: descriptor.archiveRevision,
    schemaVersion: descriptor.schemaVersion,
    dataZoom: descriptor.dataZoom,
    featureCount: descriptor.expectedFeatureCount,
    chunks: [
      for (var id = 1; id <= descriptor.expectedFeatureCount; id++)
        SeismicityChunkTransfer.fromChunk(chunk: chunk(id: id)),
    ],
  );

  SeismicityPmTilesChunk chunk({required int id}) => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List.fromList(List.filled(16, id)),
    latitudes: Float64List.fromList([(35 + id).toDouble()]),
    longitudes: Float64List.fromList([(139 + id).toDouble()]),
    depthsKm: Float32List.fromList([double.nan]),
    depthValidity: Uint8List(1),
    magnitudes: Float32List.fromList([double.nan]),
    magnitudeValidity: Uint8List(1),
    originTimeUnixMilliseconds: Int64List.fromList([id]),
    maxIntensityDictionaryIndexes: Uint32List(1),
    maxIntensityValidity: Uint8List(1),
    maxIntensityDictionaryUtf8: Uint8List(0),
    maxIntensityDictionaryOffsets: Uint32List.fromList([0]),
  );

  SeismicityPmTilesChunk corruptOffsetChunk() => SeismicityPmTilesChunk(
    hypocenterIds: Uint8List(16),
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
    maxIntensityDictionaryOffsets: Uint32List.fromList([1]),
  );

  Future<IsolateSeismicityDecoderWorkerHandle> spawnReady({
    required ControlledSeismicityIsolateLauncher controlled,
    required int expectedFeatureCount,
  }) async {
    final factory = IsolateSeismicityDecoderWorkerFactory(
      launcher: controlled,
      probe: controlled,
    );
    final spawnFuture = factory.spawn(
      acceptedDescriptor: descriptor(expectedFeatureCount: expectedFeatureCount),
      chunkCapacity: 8,
    );
    await waitUntil(
      () => controlled.sent.any(
        (request) => request is SeismicityDecoderWorkerInitializeRequest,
      ),
    );
    controlled.emitReady(requestId: 0);
    final handle = await spawnFuture;
    return handle as IsolateSeismicityDecoderWorkerHandle;
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for lifecycle signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
