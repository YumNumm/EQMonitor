import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_directory_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_limits.dart';
import 'package:test/test.dart';

import 'seismicity_pmtiles_archive_writer.dart';
import 'seismicity_pmtiles_directory_writer.dart';

void main() {
  const writer = SeismicityPmTilesArchiveWriter();
  const headerDecoder = PmTilesV3HeaderDecoder();
  const directoryDecoder = PmTilesV3DirectoryDecoder();
  const directoryWriter = SeismicityPmTilesDirectoryWriter();
  const limits = PmTilesV3Limits(
    maxDirectoryDepth: 3,
    rootDirectoryWindowLength: 16384,
    maxDirectoryEncodedBytes: 1 << 20,
    maxDirectoryDecodedBytes: 8 << 20,
    maxCachedLeafDirectories: 4,
    maxTileEncodedBytes: 4 << 20,
    maxTileDecodedBytes: 16 << 20,
  );

  final payloads = [
    SeismicityPmTilesArchiveTilePayload(
      tileId: 1,
      bytes: Uint8List.fromList([10, 11]),
    ),
    SeismicityPmTilesArchiveTilePayload(
      tileId: 4,
      bytes: Uint8List.fromList([20, 21, 22]),
    ),
  ];

  test('assembles exact none-compressed header/directory/metadata/tiles', () {
    final bytes = writer.write(
      payloads: payloads,
      internalCompression: PmTilesV3CompressionDecoder.none,
      tileCompression: PmTilesV3CompressionDecoder.none,
      minZoom: 2,
      maxZoom: 2,
      clustered: true,
    );

    expect(
      bytes.length,
      greaterThanOrEqualTo(PmTilesV3HeaderDecoder.headerLength),
    );
    expect(
      bytes.sublist(0, 7),
      PmTilesV3HeaderDecoder.magic,
    );
    expect(bytes[7], 3);

    final header = headerDecoder.decode(
      bytes: Uint8List.sublistView(
        bytes,
        0,
        PmTilesV3HeaderDecoder.headerLength,
      ),
      archiveSizeBytes: bytes.length,
      limits: limits,
    );
    expect(header.rootDirectoryOffset, PmTilesV3HeaderDecoder.headerLength);
    expect(header.metadataLength, 2);
    expect(
      utf8.decode(
        bytes.sublist(
          header.metadataOffset,
          header.metadataOffset + header.metadataLength,
        ),
      ),
      '{}',
    );
    expect(header.tileType, SeismicityPmTilesArchiveWriter.mvtTileType);
    expect(header.minZoom, 2);
    expect(header.maxZoom, 2);
    expect(header.clustered, isTrue);
    expect(header.internalCompression, PmTilesV3CompressionDecoder.none);
    expect(header.tileCompression, PmTilesV3CompressionDecoder.none);
    expect(header.addressedTilesCount, 2);
    expect(header.tileEntriesCount, 2);
    expect(header.tileContentsCount, 2);
    expect(header.leafDirectoriesLength, 0);
    expect(header.tileDataLength, 5);

    final root = bytes.sublist(
      header.rootDirectoryOffset,
      header.rootDirectoryOffset + header.rootDirectoryLength,
    );
    expect(
      root,
      directoryWriter.write(
        tileIds: const [1, 4],
        runLengths: const [1, 1],
        lengths: const [2, 3],
        offsets: const [0, 2],
      ),
    );
    final entries = directoryDecoder.decode(
      bytes: Uint8List.fromList(root),
      compression: PmTilesV3CompressionDecoder.none,
      maxEncodedBytes: limits.maxDirectoryEncodedBytes,
      maxDecodedBytes: limits.maxDirectoryDecodedBytes,
    );
    expect(entries.map((entry) => entry.tileId), [1, 4]);
    expect(
      bytes.sublist(
        header.tileDataOffset,
        header.tileDataOffset + header.tileDataLength,
      ),
      [10, 11, 20, 21, 22],
    );
  });

  test('assembles deterministic gzip directory and tile payloads', () {
    final bytes = writer.write(
      payloads: payloads,
      internalCompression: PmTilesV3CompressionDecoder.gzipCompression,
      tileCompression: PmTilesV3CompressionDecoder.gzipCompression,
      minZoom: 0,
      maxZoom: 2,
      clustered: true,
    );
    final header = headerDecoder.decode(
      bytes: Uint8List.sublistView(
        bytes,
        0,
        PmTilesV3HeaderDecoder.headerLength,
      ),
      archiveSizeBytes: bytes.length,
      limits: limits,
    );
    expect(
      header.internalCompression,
      PmTilesV3CompressionDecoder.gzipCompression,
    );
    expect(
      header.tileCompression,
      PmTilesV3CompressionDecoder.gzipCompression,
    );

    final root = bytes.sublist(
      header.rootDirectoryOffset,
      header.rootDirectoryOffset + header.rootDirectoryLength,
    );
    final expectedRoot = Uint8List.fromList(
      gzip.encode(
        directoryWriter.write(
          tileIds: const [1, 4],
          runLengths: const [1, 1],
          lengths: [
            gzip.encode([10, 11]).length,
            gzip.encode([20, 21, 22]).length,
          ],
          offsets: [
            0,
            gzip.encode([10, 11]).length,
          ],
        ),
      ),
    );
    expect(root, expectedRoot);

    final tileA = Uint8List.fromList(gzip.encode([10, 11]));
    final tileB = Uint8List.fromList(gzip.encode([20, 21, 22]));
    expect(
      bytes.sublist(
        header.tileDataOffset,
        header.tileDataOffset + header.tileDataLength,
      ),
      [...tileA, ...tileB],
    );
    expect(
      utf8.decode(
        gzip.decode(
          bytes.sublist(
            header.metadataOffset,
            header.metadataOffset + header.metadataLength,
          ),
        ),
      ),
      '{}',
    );
  });
}
