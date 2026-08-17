import 'dart:async';
import 'dart:isolate';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:test/test.dart';

import '../../benchmark/support/counting_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';

void main() {
  final descriptor = SeismicityPmTilesArchiveDescriptor(
    source: const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
    schemaVersion: 1,
    dataZoom: 14,
    expectedSizeBytes: 1,
    expectedFeatureCount: 0,
    archiveRevision: 'revision-66',
    periodFrom: DateTime.utc(2020),
    periodTo: DateTime.utc(2021),
  );

  test('counts controlled spawn success and failure once each', () async {
    final handle = _RecordingHandle();
    final controlled = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final counting = CountingDecoderWorkerFactory(delegate: controlled);

    final spawn = counting.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 1024,
    );
    expect(counting.spawnCount, 1);
    expect(controlled.spawnCount, 1);
    expect(controlled.acceptedDescriptor, same(descriptor));
    expect(controlled.chunkCapacity, 1024);

    controlled.succeedSpawn();
    expect(await spawn, same(handle));
    expect(counting.spawnCount, 1);

    final failingControlled = ControlledSeismicityDecoderWorkerFactory(
      handle: handle,
    );
    final failingCounting = CountingDecoderWorkerFactory(
      delegate: failingControlled,
    );
    const failure = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'spawn failed',
    );
    final failingSpawn = failingCounting.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 2048,
    );
    expect(failingCounting.spawnCount, 1);
    failingControlled.failSpawn(error: failure);
    await expectLater(failingSpawn, throwsA(same(failure)));
    expect(failingCounting.spawnCount, 1);
    expect(handle.callCount, 0);
  });

  test('counts one real isolate spawn and returns its handle', () async {
    final real = IsolateSeismicityDecoderWorkerFactory();
    final counting = CountingDecoderWorkerFactory(delegate: real);
    final handle = await counting.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 64,
    );
    expect(counting.spawnCount, 1);
    expect(handle, isA<IsolateSeismicityDecoderWorkerHandle>());
    await handle.cancel();
    await handle.close();
    await handle.retired;
  });
}

final class _RecordingHandle implements SeismicityDecoderWorkerHandle {
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
