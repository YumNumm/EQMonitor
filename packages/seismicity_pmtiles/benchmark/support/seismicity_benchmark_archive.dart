import 'dart:convert';
import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

import 'seismicity_benchmark_feature_source.dart';

/// On-demand deterministic [SeismicityPmTilesArchive] for decoder benchmarks.
///
/// Builds one raw MVT tile during [readTile] and retains no tile map.
final class SeismicityBenchmarkArchive implements SeismicityPmTilesArchive {
  factory SeismicityBenchmarkArchive({
    required int featureCount,
    required int featuresPerTile,
    SeismicityBenchmarkFeatureSource featureSource =
        const SeismicityBenchmarkFeatureSource(),
    PmTilesV3TileId tileIdCodec = const PmTilesV3TileId(),
  }) {
    if (featureCount <= 0 || featuresPerTile <= 0) {
      throw ArgumentError('featureCount and featuresPerTile must be positive.');
    }
    if (featureCount % featuresPerTile != 0) {
      throw ArgumentError(
        'featureCount must divide evenly by featuresPerTile.',
      );
    }
    final tileCount = featureCount ~/ featuresPerTile;
    final occupiedTileIds = List<int>.unmodifiable([
      for (var tileIndex = 0; tileIndex < tileCount; tileIndex++)
        tileIdCodec.tileIdForZxy(
          z: SeismicityBenchmarkFeatureSource.dataZoom,
          x: tileIndex,
          y: 0,
        ),
    ]);
    var totalBytes = 0;
    for (var index = 0; index < featureCount; index++) {
      totalBytes = featureSource.checkedAdd(
        left: totalBytes,
        right: featureSource.featureAt(index: index).expectedPublicBytes,
      );
    }
    return SeismicityBenchmarkArchive._(
      featureCount: featureCount,
      featuresPerTile: featuresPerTile,
      featureSource: featureSource,
      tileIdCodec: tileIdCodec,
      occupiedTileIds: occupiedTileIds,
      firstHypocenterId: featureSource.featureAt(index: 0).hypocenterId,
      lastHypocenterId: featureSource
          .featureAt(index: featureCount - 1)
          .hypocenterId,
      expectedTotalPublicBytes: totalBytes,
      descriptor: SeismicityPmTilesArchiveDescriptor(
        source: const SeismicityPmTilesSource.asset(
          assetKey: 'benchmark.seismicity.pmtiles',
        ),
        schemaVersion: 1,
        dataZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        expectedSizeBytes: totalBytes,
        expectedFeatureCount: featureCount,
        archiveRevision: 'benchmark-$featureCount-$featuresPerTile',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      ),
      header: PmTilesV3Header(
        rootDirectoryOffset: 0,
        rootDirectoryLength: 0,
        metadataOffset: 0,
        metadataLength: 0,
        leafDirectoriesOffset: 0,
        leafDirectoriesLength: 0,
        tileDataOffset: 0,
        tileDataLength: 0,
        addressedTilesCount: tileCount,
        tileEntriesCount: tileCount,
        tileContentsCount: tileCount,
        clustered: true,
        internalCompression: 0,
        tileCompression: 0,
        tileType: 1,
        minZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        maxZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        minLongitude: 0,
        minLatitude: 0,
        maxLongitude: 0,
        maxLatitude: 0,
        centerZoom: SeismicityBenchmarkFeatureSource.dataZoom,
        centerLongitude: 0,
        centerLatitude: 0,
      ),
    );
  }

  SeismicityBenchmarkArchive._({
    required this.featureCount,
    required this.featuresPerTile,
    required this.featureSource,
    required this.tileIdCodec,
    required this.occupiedTileIds,
    required this.firstHypocenterId,
    required this.lastHypocenterId,
    required this.expectedTotalPublicBytes,
    required this.descriptor,
    required this.header,
  });

  final int featureCount;
  final int featuresPerTile;
  final SeismicityBenchmarkFeatureSource featureSource;
  final PmTilesV3TileId tileIdCodec;

  @override
  final SeismicityPmTilesArchiveDescriptor descriptor;

  @override
  final PmTilesV3Header header;

  final List<int> occupiedTileIds;
  final Uint8List firstHypocenterId;
  final Uint8List lastHypocenterId;
  final int expectedTotalPublicBytes;

  var readCount = 0;
  var closeCount = 0;
  var maxRetainedPayloads = 0;
  var _retainedPayloads = 0;
  var _closed = false;
  Future<void>? _close;

  Uint8List tileBytesAt({required int tileIndex}) {
    final start = tileIndex * featuresPerTile;
    return encodeTile(
      features: [
        for (var index = start; index < start + featuresPerTile; index++)
          featureSource.featureAt(index: index),
      ],
      tileIndex: tileIndex,
    );
  }

  @override
  Stream<int> occupiedTileIdsAtZoom({required int zoom}) async* {
    ensureOpen();
    if (zoom != descriptor.dataZoom) {
      return;
    }
    for (final tileId in occupiedTileIds) {
      yield tileId;
    }
  }

  @override
  Future<Uint8List> readTile({required int tileId}) async {
    ensureOpen();
    final tileIndex = occupiedTileIds.indexOf(tileId);
    if (tileIndex < 0) {
      throw SeismicityPmTilesException.tileNotFound(tileId: tileId);
    }
    readCount += 1;
    _retainedPayloads += 1;
    if (_retainedPayloads > maxRetainedPayloads) {
      maxRetainedPayloads = _retainedPayloads;
    }
    final payload = tileBytesAt(tileIndex: tileIndex);
    final copy = Uint8List.fromList(payload);
    _retainedPayloads -= 1;
    return copy;
  }

  @override
  Future<void> close() {
    final existing = _close;
    if (existing != null) {
      return existing;
    }
    _closed = true;
    closeCount += 1;
    return _close = Future<void>.value();
  }

  void ensureOpen() {
    if (_closed) {
      throw SeismicityPmTilesException.closed(source: descriptor.source);
    }
  }

  int get retainedPayloads => _retainedPayloads;

  static Uint8List encodeTile({
    required List<SeismicityBenchmarkFeature> features,
    required int tileIndex,
  }) {
    const keys =
        'hypocenter_id origin_time_unix_ms magnitude depth_km max_intensity '
        'determination_flag earthquake_event_id geometry_clamped';
    final values = <VectorTile_Value>[];
    final encodedFeatures = <VectorTile_Feature>[];
    for (final feature in features) {
      final tags = <int>[];
      void addTag({required int keyIndex, required VectorTile_Value value}) {
        tags
          ..add(keyIndex)
          ..add(values.length);
        values.add(value);
      }

      addTag(
        keyIndex: 0,
        value: createVectorTileValue(stringValue: feature.hypocenterIdText),
      );
      addTag(
        keyIndex: 1,
        value: VectorTile_Value.fromJson(
          '{"4":"${feature.originTimeUnixMilliseconds}"}',
        ),
      );
      final magnitude = feature.magnitude;
      if (magnitude != null) {
        addTag(
          keyIndex: 2,
          value: createVectorTileValue(floatValue: magnitude),
        );
      }
      final depthKm = feature.depthKm;
      if (depthKm != null) {
        addTag(
          keyIndex: 3,
          value: createVectorTileValue(doubleValue: depthKm),
        );
      }
      final maxIntensityUtf8 = feature.maxIntensityUtf8;
      if (maxIntensityUtf8 != null) {
        addTag(
          keyIndex: 4,
          value: createVectorTileValue(
            stringValue: utf8.decode(maxIntensityUtf8),
          ),
        );
      }
      final determinationFlagUtf8 = feature.determinationFlagUtf8;
      if (determinationFlagUtf8 != null) {
        addTag(
          keyIndex: 5,
          value: createVectorTileValue(
            stringValue: utf8.decode(determinationFlagUtf8),
          ),
        );
      }
      addTag(
        keyIndex: 6,
        value: createVectorTileValue(
          stringValue: utf8.decode(feature.earthquakeEventIdUtf8),
        ),
      );
      final geometryClamped = feature.geometryClamped;
      if (geometryClamped != null) {
        addTag(
          keyIndex: 7,
          value: createVectorTileValue(boolValue: geometryClamped),
        );
      }
      final extent = SeismicityBenchmarkFeatureSource.extent;
      final localX = feature.globalX - tileIndex * extent;
      final localY = feature.globalY;
      encodedFeatures.add(
        createVectorTileFeature(
          type: VectorTile_GeomType.POINT,
          tags: tags,
          geometry: [
            9,
            (localX << 1) ^ (localX >> 63),
            (localY << 1) ^ (localY >> 63),
          ],
        )..mergeFromJson('{"1":"${feature.index}"}'),
      );
    }
    return Uint8List.fromList(
      createVectorTile(
        layers: [
          createVectorTileLayer(
            name: 'hypocenters',
            version: 2,
            extent: SeismicityBenchmarkFeatureSource.extent,
            keys: keys.split(' '),
            values: values,
            features: encodedFeatures,
          ),
        ],
      ).writeToBuffer(),
    );
  }
}
