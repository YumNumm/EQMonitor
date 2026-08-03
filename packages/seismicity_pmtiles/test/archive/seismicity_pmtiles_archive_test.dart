import 'dart:typed_data';

import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:seismicity_pmtiles/src/archive/pmtiles_v3_tile_id.dart';
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
      hasLength(1),
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
    await expectLater(
      openFixture(reader: invalidReader, dataZoom: 2),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
    expect(invalidReader._closeCalls, 1);
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
      await expectLater(
        openFixture(reader: emptyLeafReader, dataZoom: 2),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
      expect(emptyLeafReader._closeCalls, 1);
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
      await expectLater(
        openFixture(reader: reader, dataZoom: 2),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );
      expect(reader._closeCalls, 1);
    },
  );

  test('enforces header zoom bounds for root and leaf tile runs', () async {
    final belowMinimum = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
      ],
      minZoom: 2,
    );
    final belowReader = TrackingRandomAccessReader(bytes: belowMinimum.bytes);
    await expectLater(
      openFixture(reader: belowReader, dataZoom: 2),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );

    final exactBoundary = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [2], runLength: 16),
      ],
      minZoom: 2,
    );
    final exactReader = TrackingRandomAccessReader(bytes: exactBoundary.bytes);
    final exactArchive = await openFixture(reader: exactReader, dataZoom: 2);
    expect(await exactArchive.occupiedTileIdsAtZoom(zoom: 2).length, 16);
    await exactArchive.close();

    final rootOverflow = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [3], runLength: 17),
      ],
      minZoom: 2,
    );
    await expectLater(
      openFixture(
        reader: TrackingRandomAccessReader(bytes: rootOverflow.bytes),
        dataZoom: 2,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );

    final leafOverflow = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [4], runLength: 17),
          ],
        ),
      ],
      minZoom: 2,
    );
    await expectLater(
      openFixture(
        reader: TrackingRandomAccessReader(bytes: leafOverflow.bytes),
        dataZoom: 2,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
  });

  test('accepts the final z31 tile ID boundary', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(
          tileId: PmTilesV3TileId.maxValue,
          bytes: [31],
        ),
      ],
      minZoom: 31,
      maxZoom: 31,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader, dataZoom: 31);

    expect(
      await archive.readTile(tileId: PmTilesV3TileId.maxValue),
      orderedEquals([31]),
    );
    await archive.close();
  });

  test(
    'enforces clustered ordering and permits shared prior content',
    () async {
      final contiguous = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [5, 5]),
          PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
        ],
        minZoom: 2,
      );
      final contiguousArchive = await openFixture(
        reader: TrackingRandomAccessReader(bytes: contiguous.bytes),
        dataZoom: 2,
      );
      await contiguousArchive.close();

      final firstGap = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1], contentOffset: 2),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(
          reader: TrackingRandomAccessReader(bytes: firstGap.bytes),
          dataZoom: 2,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );

      final equalOffset = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2]),
          PmTilesV3FixtureTile(
            tileId: 6,
            bytes: [1, 2],
            contentOffset: 0,
          ),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(
          reader: TrackingRandomAccessReader(bytes: equalOffset.bytes),
          dataZoom: 2,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );

      final frontierAfterBackReference = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2]),
          PmTilesV3FixtureTile(tileId: 6, bytes: [3]),
          PmTilesV3FixtureTile(
            tileId: 7,
            bytes: [1, 2],
            contentOffset: 0,
          ),
          PmTilesV3FixtureTile(tileId: 8, bytes: [4]),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(
          reader: TrackingRandomAccessReader(
            bytes: frontierAfterBackReference.bytes,
          ),
          dataZoom: 2,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );

      final forwardGap = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
          PmTilesV3FixtureTile(tileId: 6, bytes: [2], contentOffset: 3),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(
          reader: TrackingRandomAccessReader(bytes: forwardGap.bytes),
          dataZoom: 2,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );

      final crossLeafGap = builder.build(
        rootEntries: const [
          PmTilesV3FixtureLeaf(
            tileId: 5,
            entries: [
              PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
            ],
          ),
          PmTilesV3FixtureLeaf(
            tileId: 6,
            entries: [
              PmTilesV3FixtureTile(tileId: 6, bytes: [2], contentOffset: 3),
            ],
          ),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(
          reader: TrackingRandomAccessReader(bytes: crossLeafGap.bytes),
          dataZoom: 2,
        ),
        throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
      );

      final shared = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [7, 8]),
          PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
          PmTilesV3FixtureTile(tileId: 7, bytes: [7, 8], contentOffset: 0),
        ],
        minZoom: 2,
      );
      final sharedReader = TrackingRandomAccessReader(bytes: shared.bytes);
      final sharedArchive = await openFixture(
        reader: sharedReader,
        dataZoom: 2,
      );
      expect(await sharedArchive.readTile(tileId: 5), orderedEquals([7, 8]));
      expect(await sharedArchive.readTile(tileId: 6), orderedEquals([6]));
      expect(await sharedArchive.readTile(tileId: 7), orderedEquals([7, 8]));
      await sharedArchive.close();

      final unclustered = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [5], contentOffset: 2),
          PmTilesV3FixtureTile(tileId: 6, bytes: [6], contentOffset: 5),
        ],
        minZoom: 2,
        clustered: false,
      );
      final unclusteredReader = TrackingRandomAccessReader(
        bytes: unclustered.bytes,
      );
      final unclusteredArchive = await openFixture(
        reader: unclusteredReader,
        dataZoom: 2,
      );
      expect(await unclusteredArchive.readTile(tileId: 5), orderedEquals([5]));
      expect(await unclusteredArchive.readTile(tileId: 6), orderedEquals([6]));
      await unclusteredArchive.close();
    },
  );

  test('preserves clustered previous-entry ordering across leaves', () async {
    final contiguous = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [5, 5]),
          ],
        ),
        PmTilesV3FixtureLeaf(
          tileId: 6,
          entries: [
            PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
          ],
        ),
      ],
      minZoom: 2,
    );
    final contiguousArchive = await openFixture(
      reader: TrackingRandomAccessReader(bytes: contiguous.bytes),
      dataZoom: 2,
    );
    await contiguousArchive.close();

    final lesserBackReference = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2]),
            PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
          ],
        ),
        PmTilesV3FixtureLeaf(
          tileId: 7,
          entries: [
            PmTilesV3FixtureTile(
              tileId: 7,
              bytes: [1, 2],
              contentOffset: 0,
            ),
          ],
        ),
      ],
      minZoom: 2,
    );
    final backReferenceArchive = await openFixture(
      reader: TrackingRandomAccessReader(bytes: lesserBackReference.bytes),
      dataZoom: 2,
    );
    await backReferenceArchive.close();

    final equalOffset = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2]),
          ],
        ),
        PmTilesV3FixtureLeaf(
          tileId: 6,
          entries: [
            PmTilesV3FixtureTile(
              tileId: 6,
              bytes: [1, 2],
              contentOffset: 0,
            ),
          ],
        ),
      ],
      minZoom: 2,
    );
    await expectLater(
      openFixture(
        reader: TrackingRandomAccessReader(bytes: equalOffset.bytes),
        dataZoom: 2,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );

    final frontierAfterBackReference = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [1, 2]),
            PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
            PmTilesV3FixtureTile(
              tileId: 7,
              bytes: [1, 2],
              contentOffset: 0,
            ),
          ],
        ),
        PmTilesV3FixtureLeaf(
          tileId: 8,
          entries: [
            PmTilesV3FixtureTile(tileId: 8, bytes: [8]),
          ],
        ),
      ],
      minZoom: 2,
    );
    await expectLater(
      openFixture(
        reader: TrackingRandomAccessReader(
          bytes: frontierAfterBackReference.bytes,
        ),
        dataZoom: 2,
      ),
      throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
    );
  });

  test('closes once and preserves any original open error and stack', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
      ],
    );
    final readFailure = StateError('read failed');
    final reader = FailingOpenReader(
      bytes: fixture.bytes,
      readFailure: readFailure,
      readFailureStack: StackTrace.fromString('original-read-stack'),
    );

    try {
      await SeismicityPmTilesArchive.open(
        reader: reader,
        descriptor: fixtureDescriptor(
          sizeBytes: fixture.bytes.length,
          dataZoom: 0,
        ),
      );
      fail('open must fail');
      // The ownership contract must preserve an arbitrary reader error and its
      // original stack.
      // ignore: avoid_catches_without_on_clauses
    } catch (error, stackTrace) {
      expect(error, same(readFailure));
      expect(stackTrace.toString(), contains('original-read-stack'));
    }
    expect(reader.closeCalls, 1);

    final closeReader = FailingOpenReader(
      bytes: fixture.bytes,
      closeFailure: StateError('close failed'),
    );
    await expectLater(
      SeismicityPmTilesArchive.open(
        reader: closeReader,
        descriptor: fixtureDescriptor(
          sizeBytes: fixture.bytes.length + 1,
          dataZoom: 0,
        ),
      ),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(closeReader.closeCalls, 1);
  });

  test(
    'classifies invalid public tile IDs separately from archive data',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
        ],
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await openFixture(reader: reader, dataZoom: 0);

      for (final tileId in [-1, PmTilesV3TileId.maxValue + 1]) {
        await expectLater(
          archive.readTile(tileId: tileId),
          throwsA(
            isA<SeismicityPmTilesInvalidTileIdException>().having(
              (exception) => exception.tileId,
              'tileId',
              tileId,
            ),
          ),
        );
      }
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

final class FailingOpenReader implements SeismicityRandomAccessReader {
  FailingOpenReader({
    required this.bytes,
    this.readFailure,
    this.readFailureStack,
    this.closeFailure,
  });

  final Uint8List bytes;
  final StateError? readFailure;
  final StackTrace? readFailureStack;
  final StateError? closeFailure;
  var _closeCalls = 0;

  int get closeCalls => _closeCalls;

  @override
  int get sizeBytes => bytes.length;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) async {
    final failure = readFailure;
    if (failure != null) {
      final stackTrace = readFailureStack;
      if (stackTrace != null) {
        Error.throwWithStackTrace(failure, stackTrace);
      }
      throw failure;
    }
    return Uint8List.sublistView(bytes, offset, offset + length);
  }

  @override
  Future<void> close() async {
    _closeCalls++;
    final failure = closeFailure;
    if (failure != null) {
      throw failure;
    }
  }
}
