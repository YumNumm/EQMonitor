import 'dart:typed_data';

import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_exception.dart';
import 'package:pmtiles_v3/src/model/pmtiles_v3_limits.dart';
import 'package:test/test.dart';

import '../support/pmtiles_v3_fixture_builder.dart';

const _limits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  maxDirectoryEncodedBytes: 1 << 20,
  maxDirectoryDecodedBytes: 8 << 20,
  maxDirectoryEntries: 65536,
  maxCachedLeafDirectories: 4,
  maxTileEncodedBytes: 4 << 20,
  maxTileDecodedBytes: 16 << 20,
);

void main() {
  const builder = PmTilesV3FixtureBuilder();
  const decoder = PmTilesV3HeaderDecoder();

  test('decodes the official 127-byte little-endian v3 header layout', () {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2, 3]),
      ],
      minZoom: 2,
    );

    final header = decoder.decode(
      bytes: Uint8List.sublistView(
        fixture.bytes,
        0,
        PmTilesV3HeaderDecoder.headerLength,
      ),
      archiveSizeBytes: fixture.bytes.length,
      limits: _limits,
    );

    expect(header.rootDirectoryOffset, PmTilesV3HeaderDecoder.headerLength);
    expect(header.rootDirectoryLength, greaterThan(0));
    expect(header.metadataLength, 2);
    expect(header.tileDataLength, 3);
    expect(header.addressedTilesCount, 1);
    expect(header.tileEntriesCount, 1);
    expect(header.tileContentsCount, 1);
    expect(header.clustered, isTrue);
    expect(header.tileType, PmTilesV3HeaderDecoder.mvtTileType);
    expect((header.minZoom, header.maxZoom), (2, 2));
    expect((header.minLongitude, header.minLatitude), (122.0, 20.0));
    expect((header.maxLongitude, header.maxLatitude), (154.0, 46.0));
    expect((header.centerLongitude, header.centerLatitude), (138.0, 35.0));
  });

  test(
    'rejects invalid magic, version, clustered flag, tile type, and zoom',
    () {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
        ],
      );
      final cases = <({int offset, int value})>[
        (offset: 0, value: 0),
        (offset: 7, value: 2),
        (offset: 96, value: 2),
        (offset: 99, value: 2),
        (offset: 100, value: 3),
        (offset: 101, value: 32),
      ];

      for (final invalidCase in cases) {
        final bytes = Uint8List.fromList(
          fixture.bytes.take(PmTilesV3HeaderDecoder.headerLength).toList(),
        )..[invalidCase.offset] = invalidCase.value;
        expect(
          () => decoder.decode(
            bytes: bytes,
            archiveSizeBytes: fixture.bytes.length,
            limits: _limits,
          ),
          throwsA(isA<PmTilesV3CorruptArchiveException>()),
        );
      }
    },
  );

  test('rejects truncated header and uint64 values above signed range', () {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
      ],
    );
    final truncated = Uint8List.sublistView(fixture.bytes, 0, 126);
    final oversized = Uint8List.fromList(
      fixture.bytes.take(PmTilesV3HeaderDecoder.headerLength).toList(),
    )..[15] = 0x80;

    expect(
      () => decoder.decode(
        bytes: truncated,
        archiveSizeBytes: fixture.bytes.length,
        limits: _limits,
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
    expect(
      () => decoder.decode(
        bytes: oversized,
        archiveSizeBytes: fixture.bytes.length,
        limits: _limits,
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
  });

  test('rejects sections outside the archive or overlapping each other', () {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1, 2, 3]),
      ],
    );
    final outside = fixtureHeader(fixture)
      ..buffer.asByteData().setUint64(
        64,
        fixture.bytes.length,
        Endian.little,
      );
    final overlap = fixtureHeader(fixture);
    final overlapData = overlap.buffer.asByteData();
    overlapData.setUint64(
      24,
      overlapData.getUint64(8, Endian.little),
      Endian.little,
    );

    expect(
      () => decoder.decode(
        bytes: outside,
        archiveSizeBytes: fixture.bytes.length,
        limits: _limits,
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
    expect(
      () => decoder.decode(
        bytes: overlap,
        archiveSizeBytes: fixture.bytes.length,
        limits: _limits,
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
  });

  test('rejects a root directory extending beyond the configured window', () {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
      ],
    );
    final header = fixtureHeader(fixture);
    final data = header.buffer.asByteData()
      ..setUint64(8, 16380, Endian.little)
      ..setUint64(16, 5, Endian.little);
    expect(data.getUint64(8, Endian.little), 16380);

    expect(
      () => decoder.decode(
        bytes: header,
        archiveSizeBytes: 20000,
        limits: _limits,
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
  });

  test('honors a caller-supplied root directory window limit', () {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
      ],
    );
    final header = fixtureHeader(fixture);

    expect(
      () => decoder.decode(
        bytes: header,
        archiveSizeBytes: fixture.bytes.length,
        limits: const PmTilesV3Limits(
          maxDirectoryDepth: 3,
          rootDirectoryWindowLength: PmTilesV3HeaderDecoder.headerLength,
          maxDirectoryEncodedBytes: 1 << 20,
          maxDirectoryDecodedBytes: 8 << 20,
          maxDirectoryEntries: 65536,
          maxCachedLeafDirectories: 4,
          maxTileEncodedBytes: 4 << 20,
          maxTileDecodedBytes: 16 << 20,
        ),
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
  });
}

Uint8List fixtureHeader(PmTilesV3Fixture fixture) {
  return Uint8List.fromList(
    fixture.bytes.take(PmTilesV3HeaderDecoder.headerLength).toList(),
  );
}
