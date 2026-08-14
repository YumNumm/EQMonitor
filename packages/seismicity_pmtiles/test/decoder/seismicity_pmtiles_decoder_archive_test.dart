import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_mvt_point_decoder.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import '../support/seismicity_archive_fixture_builder.dart';
import '../support/seismicity_mvt_fixture_builder.dart';
import '../support/seismicity_pmtiles_archive_writer.dart';

void main() {
  final fixtures = _Task61Fixtures();

  test(
    'decodes gzip z2 archive through public facade and real worker',
    () async {
      final built = fixtures.buildArchive();
      final archive = await fixtures.openAssetArchive(
        bytes: built.bytes,
        descriptor: built.descriptor,
      );
      final operation = SeismicityPmTilesDecoder().start(
        archive: archive,
        chunkCapacity: 1,
      );
      final states = operation.states.toList();

      final result = await operation.result;
      final observedStates = await states;
      expect(result, isA<SeismicityPmTilesSuccess<SeismicityPmTilesDataset>>());
      final dataset =
          (result as SeismicityPmTilesSuccess<SeismicityPmTilesDataset>).value;

      expect(dataset.archiveRevision, archive.descriptor.archiveRevision);
      expect(dataset.schemaVersion, archive.descriptor.schemaVersion);
      expect(dataset.dataZoom, archive.descriptor.dataZoom);
      expect(dataset.featureCount, archive.descriptor.expectedFeatureCount);
      expect(dataset.dataZoom, 2);
      expect(dataset.featureCount, 3);
      expect(dataset.chunks, hasLength(3));

      fixtures.expectZeroFalseEmptyChunk(chunk: dataset.chunks[0]);
      fixtures.expectBoundaryChunk(chunk: dataset.chunks[1]);
      fixtures.expectMissingOptionalChunk(chunk: dataset.chunks[2]);

      expect(observedStates, [
        const SeismicityPmTilesLoadState.openingSource(),
        const SeismicityPmTilesLoadState.readingDirectory(),
        const SeismicityPmTilesLoadState.decoding(
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 2,
            uniqueFeatureCount: 2,
          ),
        ),
        const SeismicityPmTilesLoadState.decoding(
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 2,
            rawFeatureCount: 4,
            uniqueFeatureCount: 3,
          ),
        ),
        const SeismicityPmTilesLoadState.completed(),
      ]);

      await expectLater(
        archive.readTile(tileId: built.occupiedTileIds.first),
        throwsA(isA<SeismicityPmTilesException>()),
      );
      await archive.close();
    },
  );
}

final class _Task61BuiltArchive {
  const _Task61BuiltArchive({
    required this.bytes,
    required this.descriptor,
    required this.occupiedTileIds,
  });

  final Uint8List bytes;
  final SeismicityPmTilesArchiveDescriptor descriptor;
  final List<int> occupiedTileIds;
}

final class _Task61Fixtures {
  static const uuidA = '00000000-0000-4000-8000-00000000000a';
  static const uuidB = '00000000-0000-4000-8000-00000000000b';
  static const uuidC = '00000000-0000-4000-8000-00000000000c';
  static const timeA = 1700000000001;
  static const timeB = 1700000000002;
  static const timeC = 1700000000003;
  static const schemaKeys =
      'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity '
      'determination_flag earthquake_event_id geometry_clamped';

  final tileId = const PmTilesV3TileId();
  final pointDecoder = const SeismicityMvtPointDecoder();
  final archiveWriter = const SeismicityPmTilesArchiveWriter();

  _Task61BuiltArchive buildArchive() {
    final tileIdA = tileId.tileIdForZxy(z: 2, x: 0, y: 0);
    final tileIdB = tileId.tileIdForZxy(z: 2, x: 1, y: 0);
    final bytes = archiveWriter.write(
      payloads: [
        SeismicityPmTilesArchiveTilePayload(
          tileId: tileIdA,
          bytes: Uint8List.fromList(buildTileA()),
        ),
        SeismicityPmTilesArchiveTilePayload(
          tileId: tileIdB,
          bytes: Uint8List.fromList(buildTileB()),
        ),
      ],
      internalCompression: PmTilesV3CompressionDecoder.gzipCompression,
      tileCompression: PmTilesV3CompressionDecoder.gzipCompression,
      minZoom: 2,
      maxZoom: 2,
      clustered: true,
    );
    final descriptor = SeismicityPmTilesArchiveDescriptor(
      source: const SeismicityPmTilesSource.asset(
        assetKey: SeismicityArchiveFixtureBuilder.assetKey,
      ),
      schemaVersion: 1,
      dataZoom: 2,
      expectedSizeBytes: bytes.length,
      expectedFeatureCount: 3,
      archiveRevision: 'rev-task-61',
      periodFrom: DateTime.utc(2024),
      periodTo: DateTime.utc(2025),
    );
    return _Task61BuiltArchive(
      bytes: bytes,
      descriptor: descriptor,
      occupiedTileIds: [tileIdA, tileIdB],
    );
  }

  List<int> buildTileA() {
    final values = [
      SeismicityFixtureScalar.string(uuidA),
      SeismicityFixtureScalar.signed('$timeA'),
      SeismicityFixtureScalar.double(0),
      SeismicityFixtureScalar.double(0),
      SeismicityFixtureScalar.string(''),
      SeismicityFixtureScalar.string(''),
      SeismicityFixtureScalar.string('event-a'),
      SeismicityFixtureScalar.boolean(value: false),
      SeismicityFixtureScalar.string(uuidB),
      SeismicityFixtureScalar.signed('$timeB'),
      SeismicityFixtureScalar.double(5.1),
      SeismicityFixtureScalar.double(10),
      SeismicityFixtureScalar.string('5弱'),
      SeismicityFixtureScalar.string('暫定'),
      SeismicityFixtureScalar.string('event-b'),
      SeismicityFixtureScalar.boolean(value: true),
    ];
    final featureZero = createVectorTileFeature(
      type: VectorTile_GeomType.POINT,
      tags: const [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
      geometry: encodeSeismicityFixturePoint(x: 100, y: 200),
    )..mergeFromJson('{"1":"1"}');
    final featureBoundary = createVectorTileFeature(
      type: VectorTile_GeomType.POINT,
      tags: const [0, 8, 1, 9, 2, 10, 3, 11, 4, 12, 5, 13, 6, 14, 7, 15],
      geometry: encodeSeismicityFixturePoint(x: 4092, y: 100),
    )..mergeFromJson('{"1":"2"}');
    return createVectorTile(
      layers: [
        createVectorTileLayer(
          name: 'hypocenters',
          version: 2,
          extent: 4096,
          keys: schemaKeys.split(' '),
          values: values.map((value) => value.raw).toList(growable: false),
          features: [featureZero, featureBoundary],
        ),
      ],
    ).writeToBuffer();
  }

  List<int> buildTileB() {
    final values = [
      SeismicityFixtureScalar.string(uuidB),
      SeismicityFixtureScalar.signed('$timeB'),
      SeismicityFixtureScalar.double(5.1),
      SeismicityFixtureScalar.double(10),
      SeismicityFixtureScalar.string('5弱'),
      SeismicityFixtureScalar.string('暫定'),
      SeismicityFixtureScalar.string('event-b'),
      SeismicityFixtureScalar.boolean(value: true),
      SeismicityFixtureScalar.string(uuidC),
      SeismicityFixtureScalar.signed('$timeC'),
    ];
    final featureBoundaryCopy = createVectorTileFeature(
      type: VectorTile_GeomType.POINT,
      tags: const [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
      geometry: encodeSeismicityFixturePoint(x: -4, y: 100),
    )..mergeFromJson('{"1":"1"}');
    final featureMissing = createVectorTileFeature(
      type: VectorTile_GeomType.POINT,
      tags: const [0, 8, 1, 9],
      geometry: encodeSeismicityFixturePoint(x: 50, y: 50),
    )..mergeFromJson('{"1":"2"}');
    return createVectorTile(
      layers: [
        createVectorTileLayer(
          name: 'hypocenters',
          version: 2,
          extent: 4096,
          keys: schemaKeys.split(' '),
          values: values.map((value) => value.raw).toList(growable: false),
          features: [featureBoundaryCopy, featureMissing],
        ),
      ],
    ).writeToBuffer();
  }

  SeismicityMvtPoint point({
    required int x,
    required int y,
    required int localX,
    required int localY,
  }) => pointDecoder.decode(
    geometry: encodeSeismicityFixturePoint(x: localX, y: localY),
    z: 2,
    x: x,
    y: y,
    extent: 4096,
    tileId: tileId.tileIdForZxy(z: 2, x: x, y: y),
    featureIndex: 0,
  );

  void expectZeroFalseEmptyChunk({required SeismicityPmTilesChunk chunk}) {
    final expected = point(x: 0, y: 0, localX: 100, localY: 200);
    expect(chunk.hypocenterIds, Uuid.parse(uuidA));
    expect(chunk.originTimeUnixMilliseconds, [timeA]);
    expect(chunk.magnitudes, [0.0]);
    expect(chunk.depthsKm, [0.0]);
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: chunk.magnitudeValidity,
        index: 0,
      ),
      isTrue,
    );
    expect(
      SeismicityValidityBitmap.isValid(bytes: chunk.depthValidity, index: 0),
      isTrue,
    );
    expect(chunk.latitudes.single, expected.latitude);
    expect(chunk.longitudes.single, expected.longitude);
    expect(chunk.maxIntensityDictionaryUtf8, isEmpty);
    expect(chunk.maxIntensityDictionaryOffsets, [0, 0]);
    expect(chunk.maxIntensityDictionaryIndexes, [0]);
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: chunk.maxIntensityValidity,
        index: 0,
      ),
      isTrue,
    );
  }

  void expectBoundaryChunk({required SeismicityPmTilesChunk chunk}) {
    final expected = point(x: 0, y: 0, localX: 4092, localY: 100);
    final storageMag = Float32List.fromList([5.1]).single;
    expect(chunk.hypocenterIds, Uuid.parse(uuidB));
    expect(chunk.originTimeUnixMilliseconds, [timeB]);
    expect(chunk.magnitudes.single, storageMag);
    expect(chunk.depthsKm, [10.0]);
    expect(chunk.latitudes.single, expected.latitude);
    expect(chunk.longitudes.single, expected.longitude);
    expect(chunk.maxIntensityDictionaryUtf8, utf8.encode('5弱'));
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: chunk.maxIntensityValidity,
        index: 0,
      ),
      isTrue,
    );
  }

  void expectMissingOptionalChunk({required SeismicityPmTilesChunk chunk}) {
    final expected = point(x: 1, y: 0, localX: 50, localY: 50);
    expect(chunk.hypocenterIds, Uuid.parse(uuidC));
    expect(chunk.originTimeUnixMilliseconds, [timeC]);
    expect(chunk.magnitudes.single.isNaN, isTrue);
    expect(chunk.depthsKm.single.isNaN, isTrue);
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: chunk.magnitudeValidity,
        index: 0,
      ),
      isFalse,
    );
    expect(
      SeismicityValidityBitmap.isValid(bytes: chunk.depthValidity, index: 0),
      isFalse,
    );
    expect(chunk.latitudes.single, expected.latitude);
    expect(chunk.longitudes.single, expected.longitude);
    expect(chunk.maxIntensityDictionaryUtf8, isEmpty);
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: chunk.maxIntensityValidity,
        index: 0,
      ),
      isFalse,
    );
  }

  Future<SeismicityPmTilesArchive> openAssetArchive({
    required Uint8List bytes,
    required SeismicityPmTilesArchiveDescriptor descriptor,
  }) async {
    final factory = SeismicityRandomAccessReaderFactory(
      assetLoader: ({required String assetKey}) async {
        expect(assetKey, SeismicityArchiveFixtureBuilder.assetKey);
        return bytes;
      },
      dio: Dio(),
      networkMaxCacheBytes: 1024,
    );
    final opened = await factory.create(
      descriptor: descriptor,
      cancelToken: CancelToken(),
    );
    final reader = switch (opened) {
      SeismicityPmTilesSuccess<PmTilesRandomAccessReader>(:final value) =>
        value,
      SeismicityPmTilesFailure<PmTilesRandomAccessReader>(:final exception) =>
        throw exception,
    };
    return SeismicityPmTilesArchive.open(
      reader: reader,
      descriptor: descriptor,
    );
  }
}
