import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_tile_id.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import 'seismicity_mvt_fixture_builder.dart';
import 'seismicity_pmtiles_archive_writer.dart';

final class SeismicityArchiveFixture {
  const new({
    required this.bytes,
    required this.descriptor,
    required this.occupiedTileIds,
    required this.decompressedTiles,
    required this.truncatedHeader,
    required this.truncatedDirectory,
    required this.truncatedTileData,
  });

  final Uint8List bytes;
  final SeismicityPmTilesArchiveDescriptor descriptor;
  final List<int> occupiedTileIds;
  final Map<int, Uint8List> decompressedTiles;
  final Uint8List truncatedHeader;
  final Uint8List truncatedDirectory;
  final Uint8List truncatedTileData;
}

/// Test-only gzip PMTiles fixture composition over Task 57 writer.
final class SeismicityArchiveFixtureBuilder {
  new({
    this.archiveWriter = const SeismicityPmTilesArchiveWriter(),
    SeismicityMvtFixtureBuilder? mvtBuilder,
    this.tileId = const PmTilesV3TileId(),
  }) : mvtBuilder = mvtBuilder ?? SeismicityMvtFixtureBuilder();

  final SeismicityPmTilesArchiveWriter archiveWriter;
  final SeismicityMvtFixtureBuilder mvtBuilder;
  final PmTilesV3TileId tileId;

  static const assetKey = 'fixture.gzip.pmtiles';
  static const dataZoom = 2;

  SeismicityArchiveFixture buildGzipZ2({
    required int schemaVersion,
    required int expectedFeatureCount,
    required String archiveRevision,
    required DateTime periodFrom,
    required DateTime periodTo,
  }) {
    final tileIdA = tileId.tileIdForZxy(z: dataZoom, x: 0, y: 0);
    final tileIdB = tileId.tileIdForZxy(z: dataZoom, x: 1, y: 0);
    final mvtA = Uint8List.fromList(
      mvtBuilder.build(
        layerName: 'hypocenters',
        layerVersion: 2,
        layerExtent: 4096,
        featureId: '1',
        featureTags: const [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
        featureType: VectorTile_GeomType.POINT,
        point: (x: 1, y: 2),
        keys: schemaKeys,
        values: schemaValues(hypocenterId: 'h-a', eventId: 'e-a'),
      ),
    );
    final mvtB = Uint8List.fromList(
      mvtBuilder.build(
        layerName: 'hypocenters',
        layerVersion: 2,
        layerExtent: 4096,
        featureId: '2',
        featureTags: const [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7],
        featureType: VectorTile_GeomType.POINT,
        point: (x: 3, y: 4),
        keys: schemaKeys,
        values: schemaValues(hypocenterId: 'h-b', eventId: 'e-b'),
      ),
    );
    final bytes = archiveWriter.write(
      payloads: [
        SeismicityPmTilesArchiveTilePayload(tileId: tileIdA, bytes: mvtA),
        SeismicityPmTilesArchiveTilePayload(tileId: tileIdB, bytes: mvtB),
      ],
      internalCompression: PmTilesV3CompressionDecoder.gzipCompression,
      tileCompression: PmTilesV3CompressionDecoder.gzipCompression,
      minZoom: dataZoom,
      maxZoom: dataZoom,
      clustered: true,
    );
    final descriptor = SeismicityPmTilesArchiveDescriptor(
      source: const SeismicityPmTilesSource.asset(assetKey: assetKey),
      schemaVersion: schemaVersion,
      dataZoom: dataZoom,
      expectedSizeBytes: bytes.length,
      expectedFeatureCount: expectedFeatureCount,
      archiveRevision: archiveRevision,
      periodFrom: periodFrom,
      periodTo: periodTo,
    );
    return SeismicityArchiveFixture(
      bytes: bytes,
      descriptor: descriptor,
      occupiedTileIds: [tileIdA, tileIdB],
      decompressedTiles: {tileIdA: mvtA, tileIdB: mvtB},
      truncatedHeader: Uint8List.fromList(
        bytes.sublist(0, PmTilesV3HeaderDecoder.headerLength - 1),
      ),
      truncatedDirectory: truncateAfterHeader(
        bytes: bytes,
        keepRootBytes: 1,
      ),
      truncatedTileData: truncateTiles(bytes: bytes, keepTileBytes: 1),
    );
  }

  List<String> get schemaKeys =>
      'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity '
              'determination_flag earthquake_event_id geometry_clamped'
          .split(' ');

  List<SeismicityFixtureScalar> schemaValues({
    required String hypocenterId,
    required String eventId,
  }) => [
    SeismicityFixtureScalar.string(hypocenterId),
    SeismicityFixtureScalar.signed('1700'),
    SeismicityFixtureScalar.float(5.5),
    SeismicityFixtureScalar.double(12.25),
    SeismicityFixtureScalar.unsigned('6'),
    SeismicityFixtureScalar.zigZagSigned('-2'),
    SeismicityFixtureScalar.string(eventId),
    SeismicityFixtureScalar.boolean(value: false),
  ];

  Uint8List truncateAfterHeader({
    required Uint8List bytes,
    required int keepRootBytes,
  }) {
    const headerLength = PmTilesV3HeaderDecoder.headerLength;
    final view = ByteData.sublistView(bytes);
    final rootLength = view.getUint64(16, Endian.little);
    if (keepRootBytes <= 0 || keepRootBytes >= rootLength) {
      throw ArgumentError('keepRootBytes must truncate the root directory.');
    }
    return Uint8List.fromList(bytes.sublist(0, headerLength + keepRootBytes));
  }

  Uint8List truncateTiles({
    required Uint8List bytes,
    required int keepTileBytes,
  }) {
    final view = ByteData.sublistView(bytes);
    final tileOffset = view.getUint64(56, Endian.little);
    final tileLength = view.getUint64(64, Endian.little);
    if (keepTileBytes <= 0 || keepTileBytes >= tileLength) {
      throw ArgumentError('keepTileBytes must truncate the tile data.');
    }
    return Uint8List.fromList(
      bytes.sublist(0, tileOffset + keepTileBytes),
    );
  }
}
