import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_compression_decoder.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_header_decoder.dart';
import 'package:test/test.dart';

import '../support/pmtiles_v3_fixture_builder.dart';

// このファイルの大半のテストは、archive全体をeagerに走査したときの
// directory木・clustered orderingの検証を確かめるものなので、
// `openFixture`はeager検証を明示的に有効化する。既定(無効)側の挙動は
// 別途「既定ではarchive全体を検証しない」テストで固定する。
const _limits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  maxDirectoryEncodedBytes: 1 << 20,
  maxDirectoryDecodedBytes: 8 << 20,
  maxTileEncodedBytes: 4 << 20,
  maxTileDecodedBytes: 16 << 20,
  validateEntireArchiveEagerly: true,
);

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
      final archive = await openFixture(reader: reader);

      expect(await archive.occupiedTileIdsAtZoom(zoom: 0).toList(), [0]);
      expect(await archive.occupiedTileIdsAtZoom(zoom: 1).toList(), [
        1,
        2,
        3,
        4,
      ]);
      expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5]);
      expect(
        await archive.readTileById(tileId: 4),
        orderedEquals([10, 20]),
      );

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
    final archive = await openFixture(reader: reader);
    final header = archive.header;

    expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5, 9]);
    expect(await archive.readTileById(tileId: 9), orderedEquals([9, 9, 9]));
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
    final archive = await openFixture(reader: reader);

    expect(await archive.occupiedTileIdsAtZoom(zoom: 2).toList(), [5]);
    expect(
      await archive.readTileById(tileId: 5),
      orderedEquals([1, 3, 3, 7]),
    );

    await archive.close();
  });

  test('classifies root directory encoded and decoded limits', () async {
    for (final limits in [
      _limits.copyWith(maxDirectoryEncodedBytes: 0),
      _limits.copyWith(maxDirectoryDecodedBytes: 4),
    ]) {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 0, bytes: [1]),
        ],
        internalCompression: PmTilesV3CompressionDecoder.gzipCompression,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);

      await expectLater(
        PmTilesV3Archive.open(reader: reader, limits: limits),
        throwsA(isA<PmTilesV3ResourceLimitExceededException>()),
      );
      expect(reader._closeCalls, 1);
    }
  });

  test('applies the decoded directory limit when reading a leaf', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureLeaf(
          tileId: 5,
          entries: [
            PmTilesV3FixtureTile(tileId: 5, bytes: [5]),
            PmTilesV3FixtureTile(tileId: 6, bytes: [6]),
          ],
        ),
      ],
      minZoom: 2,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);

    await expectLater(
      PmTilesV3Archive.open(
        reader: reader,
        limits: _limits.copyWith(maxDirectoryDecodedBytes: 5),
      ),
      throwsA(
        isA<PmTilesV3ResourceLimitExceededException>().having(
          (exception) => exception.resource,
          'resource',
          PmTilesV3Resource.directoryDecoded,
        ),
      ),
    );
    expect(reader._closeCalls, 1);
  });

  test(
    'applies encoded and decoded limits to none/gzip tile payloads',
    () async {
      for (final compression in [
        PmTilesV3CompressionDecoder.none,
        PmTilesV3CompressionDecoder.gzipCompression,
      ]) {
        final payload = List<int>.filled(32, 7);
        final fixture = builder.build(
          rootEntries: [PmTilesV3FixtureTile(tileId: 0, bytes: payload)],
          tileCompression: compression,
        );
        final archive = await PmTilesV3Archive.open(
          reader: TrackingRandomAccessReader(bytes: fixture.bytes),
          limits: _limits.copyWith(
            maxTileEncodedBytes: compression == PmTilesV3CompressionDecoder.none
                ? payload.length - 1
                : 4 << 20,
            maxTileDecodedBytes: compression == PmTilesV3CompressionDecoder.none
                ? 16 << 20
                : payload.length - 1,
          ),
        );

        await expectLater(
          archive.readTileById(tileId: 0),
          throwsA(isA<PmTilesV3ResourceLimitExceededException>()),
        );
        await archive.close();
      }
    },
  );

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
    final validArchive = await openFixture(reader: validReader);

    expect(await validArchive.readTileById(tileId: 5), orderedEquals([3]));
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
      openFixture(reader: invalidReader),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );
    expect(invalidReader._closeCalls, 1);
  });

  test(
    'honors a caller-supplied directory depth limit when eagerly '
    'validated',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureLeaf(
            tileId: 5,
            entries: [
              PmTilesV3FixtureTile(tileId: 5, bytes: [3]),
            ],
          ),
        ],
        minZoom: 2,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);

      await expectLater(
        PmTilesV3Archive.open(
          reader: reader,
          limits: const PmTilesV3Limits(
            maxDirectoryDepth: 1,
            rootDirectoryWindowLength: 16384,
            maxDirectoryEncodedBytes: 1 << 20,
            maxDirectoryDecodedBytes: 8 << 20,
            maxTileEncodedBytes: 4 << 20,
            maxTileDecodedBytes: 16 << 20,
            validateEntireArchiveEagerly: true,
          ),
        ),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
      );
    },
  );

  test(
    'honors a caller-supplied directory depth limit when a leaf is '
    'actually read, even without eager validation',
    () async {
      // 既定(validateEntireArchiveEagerly: false)ではarchive全体を
      // eagerに走査しないため、depth超過はopen時ではなく、実際にその
      // leafへ到達するtile読み取り時に検出される(per-tile bounded検証)。
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureLeaf(
            tileId: 5,
            entries: [
              PmTilesV3FixtureTile(tileId: 5, bytes: [3]),
            ],
          ),
        ],
        minZoom: 2,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await PmTilesV3Archive.open(
        reader: reader,
        limits: const PmTilesV3Limits(
          maxDirectoryDepth: 1,
          rootDirectoryWindowLength: 16384,
          maxDirectoryEncodedBytes: 1 << 20,
          maxDirectoryDecodedBytes: 8 << 20,
          maxTileEncodedBytes: 4 << 20,
          maxTileDecodedBytes: 16 << 20,
        ),
      );

      await expectLater(
        archive.readTileById(tileId: 5),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
      );

      await archive.close();
    },
  );

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
        openFixture(reader: reader),
        throwsA(isA<PmTilesV3UnsupportedCompressionException>()),
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
        openFixture(reader: boundsReader),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        openFixture(reader: emptyLeafReader),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        openFixture(reader: reader),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
      openFixture(reader: belowReader),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
    );

    final exactBoundary = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [2], runLength: 16),
      ],
      minZoom: 2,
    );
    final exactReader = TrackingRandomAccessReader(bytes: exactBoundary.bytes);
    final exactArchive = await openFixture(reader: exactReader);
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
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
    final archive = await openFixture(reader: reader);

    expect(
      await archive.readTileById(tileId: PmTilesV3TileId.maxValue),
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
      );
      await contiguousArchive.close();

      final firstGap = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1], contentOffset: 2),
        ],
        minZoom: 2,
      );
      await expectLater(
        openFixture(reader: TrackingRandomAccessReader(bytes: firstGap.bytes)),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        ),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        ),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        ),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
        ),
        throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
      final sharedArchive = await openFixture(reader: sharedReader);
      expect(
        await sharedArchive.readTileById(tileId: 5),
        orderedEquals([7, 8]),
      );
      expect(await sharedArchive.readTileById(tileId: 6), orderedEquals([6]));
      expect(
        await sharedArchive.readTileById(tileId: 7),
        orderedEquals([7, 8]),
      );
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
      );
      expect(
        await unclusteredArchive.readTileById(tileId: 5),
        orderedEquals([5]),
      );
      expect(
        await unclusteredArchive.readTileById(tileId: 6),
        orderedEquals([6]),
      );
      await unclusteredArchive.close();
    },
  );

  test(
    'does not scan the archive for clustered ordering violations by '
    'default (validateEntireArchiveEagerly: false)',
    () async {
      // 本番相当のbase mapアーカイブのように、直前と同一offsetへの重複排除
      // 参照や前方ジャンプを含むclustered archiveでも、既定の限定
      // (eager検証なし)ではopenが成功し、実際に読んだtileも正しく
      // 復号できることを固定する。
      final forwardGap = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
          PmTilesV3FixtureTile(tileId: 6, bytes: [2], contentOffset: 3),
        ],
        minZoom: 2,
      );
      final reader = TrackingRandomAccessReader(bytes: forwardGap.bytes);
      final archive = await PmTilesV3Archive.open(
        reader: reader,
        limits: const PmTilesV3Limits(
          maxDirectoryDepth: 3,
          rootDirectoryWindowLength: 16384,
          maxDirectoryEncodedBytes: 1 << 20,
          maxDirectoryDecodedBytes: 8 << 20,
          maxTileEncodedBytes: 4 << 20,
          maxTileDecodedBytes: 16 << 20,
        ),
      );

      expect(await archive.readTileById(tileId: 5), orderedEquals([1]));
      expect(await archive.readTileById(tileId: 6), orderedEquals([2]));

      await archive.close();
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
      openFixture(reader: TrackingRandomAccessReader(bytes: equalOffset.bytes)),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
      ),
      throwsA(isA<PmTilesV3CorruptArchiveException>()),
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
      await PmTilesV3Archive.open(reader: reader, limits: _limits);
      fail('open must fail');
      // The ownership contract must preserve an arbitrary reader error and its
      // original stack.
      // ignore: avoid_catches_without_on_clauses
    } catch (error, stackTrace) {
      expect(error, same(readFailure));
      expect(stackTrace.toString(), contains('original-read-stack'));
    }
    expect(reader.closeCalls, 1);
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
      final archive = await openFixture(reader: reader);

      for (final tileId in [-1, PmTilesV3TileId.maxValue + 1]) {
        await expectLater(
          archive.readTileById(tileId: tileId),
          throwsA(
            isA<PmTilesV3InvalidTileIdException>().having(
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

  test('returns null for a sparse-archive tile that is not present', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 5, bytes: [1]),
      ],
      minZoom: 2,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader);

    expect(await archive.readTileById(tileId: 6), isNull);
    await Future.wait([archive.close(), archive.close()]);
    expect(reader._closeCalls, 1);
    expect(
      () => archive.occupiedTileIdsAtZoom(zoom: 2),
      throwsA(isA<PmTilesV3SourceReadFailedException>()),
    );
  });

  test('readTile resolves z/x/y through the same tile ID space', () async {
    final fixture = builder.build(
      rootEntries: const [
        PmTilesV3FixtureTile(tileId: 1, bytes: [1, 2]),
      ],
      minZoom: 1,
      maxZoom: 1,
    );
    final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
    final archive = await openFixture(reader: reader);

    expect(
      await archive.readTile(z: 1, x: 0, y: 0),
      orderedEquals([1, 2]),
    );
    expect(await archive.readTile(z: 1, x: 1, y: 1), isNull);

    await archive.close();
  });

  test(
    'rejects readTile z/x/y outside the archive own zoom range',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 1, bytes: [1, 2]),
        ],
        minZoom: 1,
        maxZoom: 1,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await openFixture(reader: reader);

      // z=0はPMTiles v3のformat上は有効だが、このarchiveのheaderが
      // 持つzoom範囲(1..1)の外なので、sparse欠損のnullではなく
      // typed exceptionにする。
      await expectLater(
        archive.readTile(z: 0, x: 0, y: 0),
        throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
      );
      await expectLater(
        archive.readTile(z: 2, x: 0, y: 0),
        throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
      );

      await archive.close();
    },
  );

  test(
    'distinguishes a sparse-archive gap from an invalid tile coordinate',
    () async {
      final fixture = builder.build(
        rootEntries: const [
          PmTilesV3FixtureTile(tileId: 1, bytes: [1, 2]),
        ],
        minZoom: 1,
        maxZoom: 1,
      );
      final reader = TrackingRandomAccessReader(bytes: fixture.bytes);
      final archive = await openFixture(reader: reader);

      // (1, 1)はz=1のtile grid(0<=x,y<2)内の有効な座標だが、archiveに
      // entryが無いsparseな欠損なのでnullを返す。
      expect(await archive.readTile(z: 1, x: 1, y: 1), isNull);

      // x=2はz=1のtile grid(0<=x,y<2)の外なので、欠損ではなく
      // 不正な座標としてtyped exceptionにする。nullへ丸めない。
      await expectLater(
        archive.readTile(z: 1, x: 2, y: 0),
        throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
      );
      await expectLater(
        archive.readTile(z: 1, x: 0, y: -1),
        throwsA(isA<PmTilesV3InvalidTileCoordinateException>()),
      );

      await archive.close();
    },
  );
}

Future<PmTilesV3Archive> openFixture({
  required TrackingRandomAccessReader reader,
}) {
  return PmTilesV3Archive.open(reader: reader, limits: _limits);
}

final class TrackingRandomAccessReader implements PmTilesRandomAccessReader {
  new({required this.bytes});

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
      throw PmTilesV3Exception.invalidRange(
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

final class FailingOpenReader implements PmTilesRandomAccessReader {
  new({
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
