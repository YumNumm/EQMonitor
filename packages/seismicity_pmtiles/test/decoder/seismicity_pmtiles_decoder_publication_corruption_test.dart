import 'dart:async';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_pmtiles_decoder_runner.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_load_state.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_result.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import '../support/controlled_seismicity_archive.dart';
import '../support/controlled_seismicity_decoder_worker_factory.dart';
import '../support/controlled_seismicity_decoder_worker_handle.dart';

void main() {
  final fixtures = _Task54Fixtures();

  for (final case_ in fixtures.chunkCorruptionCases()) {
    test(
      'rejects injected ${case_.name} without completed publication',
      () async {
        await fixtures.runCorruptFinish(
          dataset: fixtures.dataset(
            descriptor: fixtures.descriptor(expectedFeatureCount: 1),
            chunks: [case_.chunk],
          ),
        );
      },
    );
  }

  for (final case_ in fixtures.identityCorruptionCases()) {
    test(
      'rejects injected ${case_.name} without completed publication',
      () async {
        final descriptor = fixtures.descriptor(expectedFeatureCount: 1);
        await fixtures.runCorruptFinish(
          dataset: case_.mutate(
            fixtures.dataset(
              descriptor: descriptor,
              chunks: [fixtures.chunk(id: 1)],
            ),
          ),
          descriptor: descriptor,
        );
      },
    );
  }
}

final class _ChunkCorruptionCase {
  const _ChunkCorruptionCase({required this.name, required this.chunk});

  final String name;
  final SeismicityPmTilesChunk chunk;
}

final class _IdentityCorruptionCase {
  const _IdentityCorruptionCase({
    required this.name,
    required this.mutate,
  });

  final String name;
  final SeismicityPmTilesDataset Function(SeismicityPmTilesDataset dataset)
  mutate;
}

final class _Task54Fixtures {
  SeismicityPmTilesSource get source => SeismicityPmTilesSource.network(
    archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
  );

  SeismicityPmTilesArchiveDescriptor descriptor({
    required int expectedFeatureCount,
  }) => SeismicityPmTilesArchiveDescriptor(
    source: source,
    schemaVersion: 1,
    dataZoom: 2,
    expectedSizeBytes: 64,
    expectedFeatureCount: expectedFeatureCount,
    archiveRevision: 'rev-task-54',
    periodFrom: DateTime.utc(2024),
    periodTo: DateTime.utc(2025),
  );

  SeismicityPmTilesDataset dataset({
    required SeismicityPmTilesArchiveDescriptor descriptor,
    required List<SeismicityPmTilesChunk> chunks,
  }) => SeismicityPmTilesDataset(
    archiveRevision: descriptor.archiveRevision,
    schemaVersion: descriptor.schemaVersion,
    dataZoom: descriptor.dataZoom,
    featureCount: descriptor.expectedFeatureCount,
    chunks: chunks,
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

  List<_ChunkCorruptionCase> chunkCorruptionCases() => [
    _ChunkCorruptionCase(
      name: 'dictionary offsets',
      chunk: chunk(id: 1).copyWith(
        maxIntensityDictionaryOffsets: Uint32List.fromList([1]),
      ),
    ),
    _ChunkCorruptionCase(
      name: 'validity tail bit',
      chunk: chunk(id: 1).copyWith(depthValidity: Uint8List.fromList([0x80])),
    ),
    _ChunkCorruptionCase(
      name: 'validity/NaN agreement',
      chunk: chunk(id: 1).copyWith(
        depthsKm: Float32List.fromList([1]),
        depthValidity: Uint8List(1),
      ),
    ),
    _ChunkCorruptionCase(
      name: 'fixed-column length',
      chunk: chunk(
        id: 1,
      ).copyWith(longitudes: Float64List.fromList([139, 140])),
    ),
  ];

  List<_IdentityCorruptionCase> identityCorruptionCases() => [
    _IdentityCorruptionCase(
      name: 'schema version',
      mutate: (dataset) => dataset.copyWith(schemaVersion: 2),
    ),
    _IdentityCorruptionCase(
      name: 'data zoom',
      mutate: (dataset) => dataset.copyWith(dataZoom: 3),
    ),
    _IdentityCorruptionCase(
      name: 'archive revision',
      mutate: (dataset) => dataset.copyWith(archiveRevision: 'other'),
    ),
    _IdentityCorruptionCase(
      name: 'feature count',
      mutate: (dataset) => dataset.copyWith(featureCount: 3),
    ),
  ];

  Future<void> runCorruptFinish({
    required SeismicityPmTilesDataset dataset,
    SeismicityPmTilesArchiveDescriptor? descriptor,
  }) async {
    final accepted =
        descriptor ??
        this.descriptor(expectedFeatureCount: dataset.featureCount);
    final archive = ControlledSeismicityArchive(
      descriptor: accepted,
      occupiedTileIds: const [1],
      tileBytes: {
        1: Uint8List.fromList([1]),
      },
    );
    final handle = ControlledSeismicityDecoderWorkerHandle();
    final factory = ControlledSeismicityDecoderWorkerFactory(handle: handle);
    final runner = SeismicityPmTilesDecoderRunner(factory: factory);
    final operation = runner.start(archive: archive, chunkCapacity: 4);
    final states = operation.states.toList();

    await waitUntil(() => factory.spawnCount == 1);
    factory.succeedSpawn();
    await waitUntil(() => handle.decodeCount == 1);
    handle.succeedDecode(
      progress: const SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 1,
        uniqueFeatureCount: 1,
      ),
    );
    await waitUntil(() => handle.finishCount == 1);
    handle.succeedFinish(dataset: dataset);
    handle.succeedClose();
    handle.succeedRetired();

    final result = await operation.result;
    final observed = await states;
    expect(result, isA<SeismicityPmTilesFailure<SeismicityPmTilesDataset>>());
    expect(
      observed,
      isNot(contains(const SeismicityPmTilesLoadState.completed())),
    );
    expect(observed.whereType<SeismicityPmTilesLoadFailed>().length, 1);
  }

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for Task 54 signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
