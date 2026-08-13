import 'dart:isolate';
import 'dart:typed_data';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:test/test.dart';

void main() {
  test('worker interfaces preserve values and terminal futures', () async {
    final descriptor = SeismicityPmTilesArchiveDescriptor(
      source: const SeismicityPmTilesSource.file(path: 'archive.pmtiles'),
      schemaVersion: 1,
      dataZoom: 14,
      expectedSizeBytes: 1,
      expectedFeatureCount: 0,
      archiveRevision: 'revision-31',
      periodFrom: DateTime.utc(2020),
      periodTo: DateTime.utc(2021),
    );
    final fake = WorkerFake();
    final handle = await fake.spawn(
      acceptedDescriptor: descriptor,
      chunkCapacity: 1024,
    );
    expect(fake.acceptedDescriptor, same(descriptor));
    expect(fake.chunkCapacity, 1024);
    final tileBytes = TransferableTypedData.fromList([
      Uint8List.fromList([31]),
    ]);
    expect(await handle.decode(tileId: 0, tileBytes: tileBytes), same(fake.progress));
    expect(fake.tileBytes, same(tileBytes));
    expect(await handle.finish(), same(fake.dataset));
    expect(handle.retired, same(handle.retired));
    await handle.retired;
    expect(handle.cancel(), same(handle.cancel()));
    expect(handle.close(), same(handle.close()));
  });
}

final class WorkerFake
    implements SeismicityDecoderWorkerFactory, SeismicityDecoderWorkerHandle {
  final progress = const SeismicityPmTilesDecodeProgress(
    decodedTileCount: 1,
    rawFeatureCount: 1,
    uniqueFeatureCount: 1,
  );
  final dataset = const SeismicityPmTilesDataset(
    archiveRevision: 'revision-31',
    schemaVersion: 1,
    dataZoom: 14,
    featureCount: 0,
    chunks: [],
  );
  final _retired = Future<void>.value();
  late SeismicityPmTilesArchiveDescriptor acceptedDescriptor;
  late int chunkCapacity;
  late TransferableTypedData tileBytes;
  Future<void>? _cancel;
  Future<void>? _close;
  @override
  Future<SeismicityDecoderWorkerHandle> spawn({
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) async {
    this.acceptedDescriptor = acceptedDescriptor;
    this.chunkCapacity = chunkCapacity;
    return this;
  }

  @override
  Future<SeismicityPmTilesDecodeProgress> decode({
    required int tileId,
    required TransferableTypedData tileBytes,
  }) async {
    this.tileBytes = tileBytes;
    return progress;
  }

  @override
  Future<SeismicityPmTilesDataset> finish() async => dataset;
  @override
  Future<void> cancel() => _cancel ??= Future<void>.value();
  @override
  Future<void> close() => _close ??= Future<void>.value();
  @override
  Future<void> get retired => _retired;
}
