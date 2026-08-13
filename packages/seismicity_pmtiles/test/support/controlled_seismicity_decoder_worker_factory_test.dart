import 'dart:async';
import 'dart:isolate';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:test/test.dart';

import 'controlled_seismicity_decoder_worker_factory.dart';

void main() {
  final descriptor = SeismicityPmTilesArchiveDescriptor(
    source: const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
    schemaVersion: 1,
    dataZoom: 14,
    expectedSizeBytes: 1,
    expectedFeatureCount: 0,
    archiveRevision: 'revision-32',
    periodFrom: DateTime.utc(2020),
    periodTo: DateTime.utc(2021),
  );

  test('controls one spawn without invoking the injected handle', () async {
    final handle = RecordingWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final spawn = factory.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 1024,
    );
    var completed = false;
    unawaited(spawn.then((_) => completed = true));
    await Future<void>.delayed(Duration.zero);

    expect(completed, isFalse);
    expect(factory.spawnCount, 1);
    expect(factory.acceptedDescriptor, same(descriptor));
    expect(factory.chunkCapacity, 1024);
    expect(handle.callCount, 0);

    factory.succeedSpawn();
    expect(await spawn, same(handle));

    final failingFactory = ControlledSeismicityDecoderWorkerFactory(
      handle: handle,
    );
    const failure = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'spawn failed',
    );
    final failingSpawn = failingFactory.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 2048,
    );

    failingFactory.failSpawn(error: failure);

    await expectLater(failingSpawn, throwsA(same(failure)));
    expect(failingFactory.spawnCount, 1);
    expect(handle.callCount, 0);
  });
}

final class RecordingWorkerHandle implements SeismicityDecoderWorkerHandle {
  var _callCount = 0;
  int get callCount => _callCount;

  Never recordCall() {
    _callCount++;
    throw StateError('Unexpected handle call.');
  }

  @override
  Future<SeismicityPmTilesDecodeProgress> decode({
    required int tileId,
    required TransferableTypedData tileBytes,
  }) => recordCall();

  @override
  Future<SeismicityPmTilesDataset> finish() => recordCall();

  @override
  Future<void> cancel() => recordCall();

  @override
  Future<void> close() => recordCall();

  @override
  Future<void> get retired => recordCall();
}
