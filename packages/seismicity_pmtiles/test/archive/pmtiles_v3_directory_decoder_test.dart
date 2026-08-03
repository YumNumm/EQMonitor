import 'dart:io';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_directory_decoder.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  const decoder = PmTilesV3DirectoryDecoder();

  test('decodes spec delta IDs, runs, lengths, and offset sentinel', () {
    final bytes = Uint8List.fromList([
      3,
      5,
      37,
      27,
      1,
      2,
      0,
      42,
      5,
      8,
      0xBA,
      0x0A,
      0,
      11,
    ]);

    final entries = decoder.decode(
      bytes: bytes,
      compression: PmTilesV3CompressionDecoder.none,
    );

    expect(entries.map((entry) => entry.tileId), [5, 42, 69]);
    expect(entries.map((entry) => entry.runLength), [1, 2, 0]);
    expect(entries.map((entry) => entry.length), [42, 5, 8]);
    expect(entries.map((entry) => entry.offset), [1337, 1379, 10]);
  });

  test('decodes a gzip-compressed directory', () {
    final compressed = Uint8List.fromList(gzip.encode([1, 5, 3, 4, 8]));

    final entries = decoder.decode(
      bytes: compressed,
      compression: PmTilesV3CompressionDecoder.gzipCompression,
    );

    expect(entries.single.tileId, 5);
    expect(entries.single.runLength, 3);
    expect(entries.single.length, 4);
    expect(entries.single.offset, 7);
  });

  test('rejects empty, truncated, overflowing, and non-canonical varints', () {
    final cases = <List<int>>[
      [0],
      [0x80],
      [0x80, 0],
      [
        0x81,
        0x81,
        0x81,
        0x81,
        0x81,
        0x81,
        0x81,
        0x81,
        0x81,
      ],
    ];

    for (final bytes in cases) {
      expect(
        () => decoder.decode(
          bytes: Uint8List.fromList(bytes),
          compression: PmTilesV3CompressionDecoder.none,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
    }
  });

  test(
    'rejects duplicate IDs, zero lengths, first offset sentinel, and tail',
    () {
      final cases = <List<int>>[
        [2, 5, 0, 1, 1, 1, 1, 1, 0],
        [1, 5, 1, 0, 1],
        [1, 5, 1, 1, 0],
        [1, 5, 1, 1, 1, 99],
      ];

      for (final bytes in cases) {
        expect(
          () => decoder.decode(
            bytes: Uint8List.fromList(bytes),
            compression: PmTilesV3CompressionDecoder.none,
          ),
          throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
        );
      }
    },
  );

  test('rejects overlapping tile runs and every unsupported compression', () {
    final overlapping = Uint8List.fromList([
      2,
      5,
      2,
      3,
      1,
      1,
      1,
      1,
      2,
      0,
    ]);

    expect(
      () => decoder.decode(
        bytes: overlapping,
        compression: PmTilesV3CompressionDecoder.none,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
    for (final compression in [0, 3, 4, 255]) {
      expect(
        () => decoder.decode(
          bytes: Uint8List(1),
          compression: compression,
        ),
        throwsA(isA<SeismicityPmTilesUnsupportedCompressionException>()),
      );
    }
  });

  test('reports malformed gzip data as a corrupt archive', () {
    expect(
      () => decoder.decode(
        bytes: Uint8List.fromList([1, 2, 3]),
        compression: PmTilesV3CompressionDecoder.gzipCompression,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
  });
}
