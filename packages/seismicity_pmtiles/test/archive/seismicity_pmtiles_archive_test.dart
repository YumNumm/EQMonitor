import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:test/test.dart';

import '../support/pmtiles_v3_fixture_builder.dart';

void main() {
  const builder = PmTilesV3FixtureBuilder();

  test(
    'enumerates run intersections without enumerating unrelated zooms',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(
            tileId: 0,
            bytes: [10, 20],
            runLength: 6,
          ),
        ],
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await openFixture(reader: reader, dataZoom: 2);

      expect(await archive.occupiedTileIdsAtZoom(zoom: 0).toList(), [0]);
      expect(await archive.occupiedTileIdsAtZoom(zoom: 1).toList(), [
        1,
        2,
        3,
        4,
      ]);
      expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5]);
      expect(await archive.readTile(tileId: 4), orderedEquals([10, 20]));

      await archive.close();
    },
  );

  test('reads only exact root, leaf, and tile section ranges', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [5, 5]),
            PmTilesV3FixtureTile(tileId: 9, bytes: [9, 9, 9]),
          ],
        ),
      ],
      minZoom: 2,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader, dataZoom: 2);
    final header = archive.header;

    expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5, 9]);
    expect(await archive.readTile(tileId: 9), orderedEquals([9, 9, 9]));
    expect(
      reader.reads.first,
      (offset: 0, length: PmTilesV3HeaderDecoder.headerLength),
    );
    expect(
      reader.reads[1],
      (
        offset: header.rootDirectoryOffset,
        length: header.rootDirectoryLength,
      ),
    );
    expect(
      reader.reads.where(
        (range) =>
            range.offset >= header.leafDirectoriesOffset &&
            range.offset < header.tileDataOffset,
      ),
      hasLength(2),
    );
    expect(
      reader.reads.last,
      (offset: header.tileDataOffset + 2, length: 3),
    );

    await archive.close();
  });

  test('decodes gzip directories and tile payloads', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [1, 3, 3, 7]),
          ],
        ),
      ],
      internalCompression: 2,
      tileCompression: 2,
      minZoom: 2,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader, dataZoom: 2);

    expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5]);
    expect(await archive.readTile(tileId: 5), orderedEquals([1, 3, 3, 7]));

    await archive.close();
  });

  test('supports three directory levels and rejects a fourth', () async {
    final validFixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureLeaf(
              tileId: 5,
              entries: [
                PmTilesV3FixtureTile(tileId: 5, bytes: [3]),
              ],
            ),
          ],
        ),
      ],
      minZoom: 2,
    );
    final validReader = TrackingRandomAccessReader(bytes: validFixture.bytes);
    final validArchive = await openFixture(reader: validReader, dataZoom: 2);

    expect(await validArchive.readTile(tileId: 5), orderedEquals([3]));
    await validArchive.close();

    final invalidFixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureLeaf(
              tileId: 5,
              entries: [
                PmTilesV3FixtureLeaf(
                  tileId: 5,
                  entries: [
                    PmTilesV3FixtureTile(tileId: 5, bytes: [4]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      minZoom: 2,
    );
    final invalidReader = TrackingRandomAccessReader(
      bytes: invalidFixture.bytes,
    );
    final invalidArchive = await openFixture(
      reader: invalidReader,
      dataZoom: 2,
    );

    await expectLater(
      invalidArchive.readTile(tileId: 5),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
    await invalidArchive.close();
  });

  test('rejects descriptor size and data zoom and closes reader', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
      ],
      minZoom: 2,
    );
    final sizeReader = TrackingRandomAccessReader(bytes: fixture.bytes);

    await expectLater(
      SeismicityPmTilesArchive.open(
        reader: sizeReader,
        descriptor: fixtureDescriptor(
          sizeBytes: fixture.bytes.length + 1,
          dataZoom: 2,
        ),
      ),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(sizeReader._closeCalls, 1);

    final zoomReader = TrackingRandomAccessReader(bytes: fixture.bytes);
    await expectLater(
      openFixture(reader: zoomReader, dataZoom: 1),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(zoomReader._closeCalls, 1);
  });

  test('rejects unsupported internal and tile compression at open', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
      ],
      minZoom: 2,
    );

    for (final offset in [97, 98]) {
      final bytes = Uint8List.fromList(fixture.bytes)..[offset] = 3;
      final reader = TrackingRandomAccessReader(bytes: bytes);
      await expectLater(
        openFixture(reader: reader, dataZoom: 2),
        throwsA(isA<SeismicityPmTilesUnsupportedCompressionException>()),
      );
      expect(reader._closeCalls, 1);
    }
  });

  test(
    'rejects entry ranges outside sections and empty leaf directories',
    () async {
      final boundsFixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2, 3]),
        ],
        minZoom: 2,
      );
      final boundsBytes = Uint8List.fromList(boundsFixture.bytes);
      boundsBytes.buffer.asByteData().setUint64(64, 1, Endian.little);
      final boundsReader = TrackingRandomAccessReader(bytes: boundsBytes);

      await expectLater(
        openFixture(reader: boundsReader, dataZoom: 2),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
      expect(boundsReader._closeCalls, 1);

      final emptyLeafFixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureLeaf(tileId: 5, entries: []),
        ],
        minZoom: 2,
      );
      final emptyLeafReader = TrackingRandomAccessReader(
        bytes: emptyLeafFixture.bytes,
      );
      final archive = await openFixture(reader: emptyLeafReader, dataZoom: 2);
      await expectLater(
        archive.occupiedTileIdsAtZoom(zoom: 2).toList(),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
      await archive.close();
    },
  );

  test(
    'rejects leaf entries that do not start at the parent tile ID',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureLeaf(
            tileId: 5,
            entries: [
              PmTilesV3FixtureTile(tileId: 6, bytes: [1]),
            ],
          ),
        ],
        minZoom: 2,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await openFixture(reader: reader, dataZoom: 2);

      await expectLater(
        archive.readTile(tileId: 5),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
      await archive.close();
    },
  );

  test('reports missing tiles and closes its reader exactly once', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
      ],
      minZoom: 2,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader, dataZoom: 2);

    await expectLater(
      archive.readTile(tileId: 6),
      throwsA(isA<SeismicityPmTilesTileNotFoundException>()),
    );
    await Future.wait([archive.close(), archive.close()]);
    expect(reader._closeCalls, 1);
    expect(
      () => archive.occupiedTileIdsAtZoom(zoom: 2),
      throwsA(isA<SeismicityPmTilesSourceReadFailedException>()),
    );
  });
}

Future<SeismicityPmTilesArchive> openFixture({
  required TrackingRandomAccessReader reader,
  required int dataZoom,
}) {
  return SeismicityPmTilesArchive.open(
    reader: reader,
    descriptor: fixtureDescriptor(
      sizeBytes: reader.sizeBytes,
      dataZoom: dataZoom,
    ),
  );
}

SeismicityPmTilesArchiveDescriptor fixtureDescriptor({
  required int sizeBytes,
  required int dataZoom,
}) {
  return SeismicityPmTilesArchiveDescriptor(
    source: const SeismicityPmTilesAssetSource(assetKey: 'fixture.pmtiles'),
    schemaVersion: 1,
    dataZoom: dataZoom,
    expectedSizeBytes: sizeBytes,
    expectedFeatureCount: 1,
    archiveRevision: 'fixture-v1',
    periodFrom: DateTime.utc(2025),
    periodTo: DateTime.utc(2026),
  );
}

final class TrackingRandomAccessReader implements SeismicityRandomAccessReader {
  TrackingRandomAccessReader({required this.bytes});

  final Uint8List bytes;
  final List<({int offset, int length})> reads = [];
  var _closeCalls = 0;
  var _isClosed = false;

  @override
  int get sizeBytes => bytes.length;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) async {
    if (_isClosed ||
        offset < 0 ||
        length <= 0 ||
        offset > bytes.length ||
        length > bytes.length - offset) {
      throw SeismicityPmTilesException.invalidRange(
        offset: offset,
        length: length,
        sizeBytes: bytes.length,
      );
    }
    reads.add((offset: offset, length: length));
    return Uint8List.sublistView(bytes, offset, offset + length);
  }

  @override
  Future<void> close() async {
    if (!_isClosed) {
      _closeCalls++;
      _isClosed = true;
    }
  }
}
