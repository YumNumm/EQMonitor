import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';

import 'seismicity_pmtiles_directory_writer.dart';

final class SeismicityPmTilesArchiveTilePayload {
  const new({
    required this.tileId,
    required this.bytes,
    this.runLength = 1,
  });

  final int tileId;
  final Uint8List bytes;
  final int runLength;
}

/// Test-only exact PMTiles v3 archive byte assembler (no open/descriptor).
final class SeismicityPmTilesArchiveWriter {
  const new({
    this.directoryWriter = const SeismicityPmTilesDirectoryWriter(),
  });

  final SeismicityPmTilesDirectoryWriter directoryWriter;

  static const metadataJson = '{}';
  static const int mvtTileType = PmTilesV3HeaderDecoder.mvtTileType;

  Uint8List write({
    required List<SeismicityPmTilesArchiveTilePayload> payloads,
    required int internalCompression,
    required int tileCompression,
    required int minZoom,
    required int maxZoom,
    required bool clustered,
  }) {
    if (payloads.isEmpty) {
      throw ArgumentError('Archive payloads must be non-empty.');
    }
    validateCompression(code: internalCompression);
    validateCompression(code: tileCompression);

    final tileBytes = BytesBuilder(copy: false);
    final tileIds = <int>[];
    final runLengths = <int>[];
    final lengths = <int>[];
    final offsets = <int>[];
    var addressedTilesCount = 0;
    for (final payload in payloads) {
      final content = maybeGzip(
        bytes: payload.bytes,
        compression: tileCompression,
      );
      final offset = tileBytes.length;
      tileBytes.add(content);
      tileIds.add(payload.tileId);
      runLengths.add(payload.runLength);
      lengths.add(content.length);
      offsets.add(offset);
      addressedTilesCount += payload.runLength;
    }

    final rootDirectory = maybeGzip(
      bytes: directoryWriter.write(
        tileIds: tileIds,
        runLengths: runLengths,
        lengths: lengths,
        offsets: offsets,
      ),
      compression: internalCompression,
    );
    final metadata = maybeGzip(
      bytes: Uint8List.fromList(utf8.encode(metadataJson)),
      compression: internalCompression,
    );

    const rootOffset = PmTilesV3HeaderDecoder.headerLength;
    final metadataOffset = rootOffset + rootDirectory.length;
    final leafOffset = metadataOffset + metadata.length;
    final tileOffset = leafOffset; // no leaf directories
    final tileData = tileBytes.toBytes();
    final archiveLength = tileOffset + tileData.length;
    final header = buildHeader(
      rootOffset: rootOffset,
      rootLength: rootDirectory.length,
      metadataOffset: metadataOffset,
      metadataLength: metadata.length,
      leafOffset: leafOffset,
      leafLength: 0,
      tileOffset: tileOffset,
      tileLength: tileData.length,
      addressedTilesCount: addressedTilesCount,
      tileEntriesCount: payloads.length,
      tileContentsCount: payloads.length,
      clustered: clustered,
      internalCompression: internalCompression,
      tileCompression: tileCompression,
      minZoom: minZoom,
      maxZoom: maxZoom,
      archiveLength: archiveLength,
    );

    return (BytesBuilder(copy: false)
          ..add(header)
          ..add(rootDirectory)
          ..add(metadata)
          ..add(tileData))
        .toBytes();
  }

  Uint8List buildHeader({
    required int rootOffset,
    required int rootLength,
    required int metadataOffset,
    required int metadataLength,
    required int leafOffset,
    required int leafLength,
    required int tileOffset,
    required int tileLength,
    required int addressedTilesCount,
    required int tileEntriesCount,
    required int tileContentsCount,
    required bool clustered,
    required int internalCompression,
    required int tileCompression,
    required int minZoom,
    required int maxZoom,
    required int archiveLength,
  }) {
    final header = Uint8List(PmTilesV3HeaderDecoder.headerLength);
    header.setRange(
      0,
      PmTilesV3HeaderDecoder.magic.length,
      PmTilesV3HeaderDecoder.magic,
    );
    header[7] = 3;
    ByteData.sublistView(header)
      ..setUint64(8, rootOffset, Endian.little)
      ..setUint64(16, rootLength, Endian.little)
      ..setUint64(24, metadataOffset, Endian.little)
      ..setUint64(32, metadataLength, Endian.little)
      ..setUint64(40, leafOffset, Endian.little)
      ..setUint64(48, leafLength, Endian.little)
      ..setUint64(56, tileOffset, Endian.little)
      ..setUint64(64, tileLength, Endian.little)
      ..setUint64(72, addressedTilesCount, Endian.little)
      ..setUint64(80, tileEntriesCount, Endian.little)
      ..setUint64(88, tileContentsCount, Endian.little)
      ..setUint8(96, clustered ? 1 : 0)
      ..setUint8(97, internalCompression)
      ..setUint8(98, tileCompression)
      ..setUint8(99, mvtTileType)
      ..setUint8(100, minZoom)
      ..setUint8(101, maxZoom)
      ..setInt32(102, 1220000000, Endian.little)
      ..setInt32(106, 200000000, Endian.little)
      ..setInt32(110, 1540000000, Endian.little)
      ..setInt32(114, 460000000, Endian.little)
      ..setUint8(118, minZoom)
      ..setInt32(119, 1380000000, Endian.little)
      ..setInt32(123, 350000000, Endian.little);
    final expected =
        PmTilesV3HeaderDecoder.headerLength +
        rootLength +
        metadataLength +
        leafLength +
        tileLength;
    if (archiveLength != expected) {
      throw StateError('Archive section lengths do not match archive length.');
    }
    return header;
  }

  Uint8List maybeGzip({
    required Uint8List bytes,
    required int compression,
  }) {
    if (compression == PmTilesV3CompressionDecoder.none) {
      return bytes;
    }
    return Uint8List.fromList(gzip.encode(bytes));
  }

  void validateCompression({required int code}) {
    if (code != PmTilesV3CompressionDecoder.none &&
        code != PmTilesV3CompressionDecoder.gzipCompression) {
      throw ArgumentError('Unsupported compression code: $code');
    }
  }
}
