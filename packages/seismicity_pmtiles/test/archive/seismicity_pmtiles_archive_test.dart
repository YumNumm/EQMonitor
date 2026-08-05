import 'dart:convert';
import 'dart:typed_data';

import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/seismicity_pmtiles.dart';
import 'package:test/test.dart';

// PMTiles v3仕様の検証・directory走査そのものはpmtiles_v3側で網羅済みのため、
// ここでは descriptor 固有の検証（サイズ/dataZoom一致、tileNotFound、
// invalidTileId、open失敗時のreader close）だけを対象にする。単一tile entry
// の最小構成archiveだけを組み立てれば十分。

void main() {
  test('rejects descriptor size and data zoom and closes reader', () async {
    final bytes = _buildFixtureBytes(tileId: 5, tileBytes: [1]);
    final sizeReader = TrackingRandomAccessReader(bytes: bytes);

    await expectLater(
      SeismicityPmTilesArchive.open(
        reader: sizeReader,
        descriptor: _fixtureDescriptor(
          sizeBytes: bytes.length + 1,
          dataZoom: 2,
        ),
      ),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(sizeReader._closeCalls, 1);

    final zoomReader = TrackingRandomAccessReader(bytes: bytes);
    await expectLater(
      _openFixture(reader: zoomReader, dataZoom: 1),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(zoomReader._closeCalls, 1);
  });

  test('closes once and preserves any original open error and stack', () async {
    final bytes = _buildFixtureBytes(tileId: 0, tileBytes: [1], minZoom: 0);
    final readFailure = StateError('read failed');
    final reader = FailingOpenReader(
      bytes: bytes,
      readFailure: readFailure,
      readFailureStack: StackTrace.fromString('original-read-stack'),
    );

    try {
      await SeismicityPmTilesArchive.open(
        reader: reader,
        descriptor: _fixtureDescriptor(sizeBytes: bytes.length, dataZoom: 0),
      );
      fail('open must fail');
      // The ownership contract must preserve an arbitrary reader error and its
      // original stack.
      // ignore: avoid_catches_without_on_clauses
    } catch (error, stackTrace) {
      expect(error, same(readFailure));
      expect(stackTrace.toString(), contains('original-read-stack'));
    }
    expect(reader._closeCalls, 1);

    final closeReader = FailingOpenReader(
      bytes: bytes,
      closeFailure: StateError('close failed'),
    );
    await expectLater(
      SeismicityPmTilesArchive.open(
        reader: closeReader,
        descriptor: _fixtureDescriptor(
          sizeBytes: bytes.length + 1,
          dataZoom: 0,
        ),
      ),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect(closeReader._closeCalls, 1);
  });

  test(
    'classifies invalid public tile IDs separately from archive data',
    () async {
      final bytes = _buildFixtureBytes(
        tileId: 0,
        tileBytes: [1],
        minZoom: 0,
        maxZoom: 0,
      );
      final reader = TrackingRandomAccessReader(bytes: bytes);
      final archive = await _openFixture(reader: reader, dataZoom: 0);

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
    final bytes = _buildFixtureBytes(tileId: 5, tileBytes: [1]);
    final reader = TrackingRandomAccessReader(bytes: bytes);
    final archive = await _openFixture(reader: reader, dataZoom: 2);

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

  test(
    'rejects an archive that violates producer clustered ordering '
    '(regression guard for validateEntireArchiveEagerly: true)',
    () async {
      // seismicity_pmtiles はproducer契約としてclustered orderingとtile
      // 件数の一致を保証しており、SeismicityPmTilesArchiveOpenerは
      // pmtiles_v3へ `validateEntireArchiveEagerly: true` を明示的に渡す
      // ことでそれをruntimeでも検証している
      // (seismicity_pmtiles_archive.dart)。この1行が失われたり
      // `false` に変わったりすると、pmtiles_v3は既定でarchive全体を
      // eagerに走査しなくなるため、このテストは落ちなくなる。
      final bytes = _buildClusteredOrderingViolationFixtureBytes();
      final reader = TrackingRandomAccessReader(bytes: bytes);

      await expectLater(
        _openFixture(reader: reader, dataZoom: 2),
        throwsA(
          isA<SeismicityPmTilesCorruptArchiveException>().having(
            (exception) => exception.reason,
            'reason',
            'Clustered content must follow the previous entry or reference '
                'known content at a strictly smaller offset.',
          ),
        ),
      );
    },
  );
}

Future<SeismicityPmTilesArchive> _openFixture({
  required TrackingRandomAccessReader reader,
  required int dataZoom,
}) {
  return SeismicityPmTilesArchive.open(
    reader: reader,
    descriptor: _fixtureDescriptor(
      sizeBytes: reader.sizeBytes,
      dataZoom: dataZoom,
    ),
  );
}

SeismicityPmTilesArchiveDescriptor _fixtureDescriptor({
  required int sizeBytes,
  required int dataZoom,
}) {
  return SeismicityPmTilesArchiveDescriptor(
    source: const SeismicityPmTilesSource.asset(assetKey: 'fixture.pmtiles'),
    schemaVersion: 1,
    dataZoom: dataZoom,
    expectedSizeBytes: sizeBytes,
    expectedFeatureCount: 1,
    archiveRevision: 'fixture-v1',
    periodFrom: DateTime.utc(2025),
    periodTo: DateTime.utc(2026),
  );
}

/// leaf directoryもgzipも使わない、単一tile entryだけのPMTiles v3 archive
/// byte列を組み立てる。PMTiles v3仕様の検証やdirectory走査自体は
/// pmtiles_v3側で網羅済みのため、この packageのtestに必要な最小限で足りる。
Uint8List _buildFixtureBytes({
  required int tileId,
  required List<int> tileBytes,
  int minZoom = 2,
  int maxZoom = 2,
}) {
  const headerLength = 127;
  final directory = _encodeDirectory(tileId: tileId, length: tileBytes.length);
  final metadata = Uint8List.fromList(utf8.encode('{}'));
  const rootOffset = headerLength;
  final metadataOffset = rootOffset + directory.length;
  final leafOffset = metadataOffset + metadata.length;
  final tileDataOffset = leafOffset;

  final header = Uint8List(headerLength);
  header.setRange(0, 7, [0x50, 0x4D, 0x54, 0x69, 0x6C, 0x65, 0x73]);
  header[7] = 3;
  ByteData.sublistView(header)
    ..setUint64(8, rootOffset, Endian.little)
    ..setUint64(16, directory.length, Endian.little)
    ..setUint64(24, metadataOffset, Endian.little)
    ..setUint64(32, metadata.length, Endian.little)
    ..setUint64(40, leafOffset, Endian.little)
    ..setUint64(48, 0, Endian.little)
    ..setUint64(56, tileDataOffset, Endian.little)
    ..setUint64(64, tileBytes.length, Endian.little)
    ..setUint64(72, 1, Endian.little)
    ..setUint64(80, 1, Endian.little)
    ..setUint64(88, 1, Endian.little)
    ..setUint8(96, 1)
    ..setUint8(97, 1)
    ..setUint8(98, 1)
    ..setUint8(99, 1)
    ..setUint8(100, minZoom)
    ..setUint8(101, maxZoom)
    ..setInt32(102, 1220000000, Endian.little)
    ..setInt32(106, 200000000, Endian.little)
    ..setInt32(110, 1540000000, Endian.little)
    ..setInt32(114, 460000000, Endian.little)
    ..setUint8(118, minZoom)
    ..setInt32(119, 1380000000, Endian.little)
    ..setInt32(123, 350000000, Endian.little);

  return Uint8List.fromList([
    ...header,
    ...directory,
    ...metadata,
    ...tileBytes,
  ]);
}

/// clustered orderingに違反する最小archiveのbyte列を組み立てる。leafも
/// gzipも使わない2つのroot tile entryだけで構成する: tile 5はoffset 0・
/// length 1、tile 6は直後(offset 1)ではなくoffset 3を主張するため、
/// offset [1, 3) が未参照のまま残る前方ギャップになる。
///
/// pmtiles_v3側にも同種のclustered ordering違反fixtureを組み立てる仕組み
/// (`packages/pmtiles_v3/test/support/pmtiles_v3_fixture_builder.dart`)が
/// あるが、その`test/`配下のファイルはpackageの`lib/`外にあるため
/// `package:pmtiles_v3/...`importで参照できず、パッケージを跨いだ相対
/// importはこのリポジトリの規約(CLAUDE.md: cross-package importは
/// package importを使う)に反する。そのため、この packageのtestが必要と
/// する最小限のarchiveだけをここで自前に組み立てている。
Uint8List _buildClusteredOrderingViolationFixtureBytes() {
  const headerLength = 127;
  const minZoom = 2;
  const maxZoom = 2;

  final directory = Uint8List.fromList([
    ..._varint(2), // entry count
    ..._varint(5), // tileId delta: tile 5 (5 - 0)
    ..._varint(1), // tileId delta: tile 6 (6 - 5)
    ..._varint(1), // runLength: tile 5
    ..._varint(1), // runLength: tile 6
    ..._varint(1), // content length: tile 5 ([1])
    ..._varint(1), // content length: tile 6 ([2])
    ..._varint(1), // offset: tile 5 -> 0 + 1 (first entry is never "0")
    ..._varint(4), // offset: tile 6 -> 3 + 1 (not contiguous with tile 5)
  ]);
  final metadata = Uint8List.fromList(utf8.encode('{}'));
  const rootOffset = headerLength;
  final metadataOffset = rootOffset + directory.length;
  final leafOffset = metadataOffset + metadata.length;
  // tile 5 occupies offset 0..1, then a 2-byte unreferenced gap, then tile 6
  // at offset 3..4.
  final tileBytes = Uint8List.fromList([1, 0, 0, 2]);

  final header = Uint8List(headerLength);
  header.setRange(0, 7, [0x50, 0x4D, 0x54, 0x69, 0x6C, 0x65, 0x73]);
  header[7] = 3;
  ByteData.sublistView(header)
    ..setUint64(8, rootOffset, Endian.little)
    ..setUint64(16, directory.length, Endian.little)
    ..setUint64(24, metadataOffset, Endian.little)
    ..setUint64(32, metadata.length, Endian.little)
    ..setUint64(40, leafOffset, Endian.little)
    ..setUint64(48, 0, Endian.little)
    ..setUint64(56, leafOffset, Endian.little)
    ..setUint64(64, tileBytes.length, Endian.little)
    ..setUint64(72, 2, Endian.little) // addressedTilesCount
    ..setUint64(80, 2, Endian.little) // tileEntriesCount
    ..setUint64(88, 2, Endian.little) // tileContentsCount
    ..setUint8(96, 1) // clustered
    ..setUint8(97, 1)
    ..setUint8(98, 1)
    ..setUint8(99, 1)
    ..setUint8(100, minZoom)
    ..setUint8(101, maxZoom)
    ..setInt32(102, 1220000000, Endian.little)
    ..setInt32(106, 200000000, Endian.little)
    ..setInt32(110, 1540000000, Endian.little)
    ..setInt32(114, 460000000, Endian.little)
    ..setUint8(118, minZoom)
    ..setInt32(119, 1380000000, Endian.little)
    ..setInt32(123, 350000000, Endian.little);

  return Uint8List.fromList([
    ...header,
    ...directory,
    ...metadata,
    ...tileBytes,
  ]);
}

Uint8List _encodeDirectory({required int tileId, required int length}) {
  return Uint8List.fromList([
    ..._varint(1),
    ..._varint(tileId),
    ..._varint(1),
    ..._varint(length),
    ..._varint(1),
  ]);
}

List<int> _varint(int value) {
  final output = <int>[];
  var remaining = value;
  do {
    var byte = remaining & 0x7F;
    remaining >>= 7;
    if (remaining > 0) {
      byte |= 0x80;
    }
    output.add(byte);
  } while (remaining > 0);
  return output;
}

final class TrackingRandomAccessReader implements PmTilesRandomAccessReader {
  TrackingRandomAccessReader({required this.bytes});

  final Uint8List bytes;
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
