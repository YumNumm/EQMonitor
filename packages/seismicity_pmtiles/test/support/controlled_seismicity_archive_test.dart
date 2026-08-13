import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:test/test.dart';

import 'controlled_seismicity_archive.dart';

void main() {
  final fixtures = _Task45Fixtures();

  test('exposes the identical accepted descriptor', () {
    final descriptor = fixtures.descriptor();
    final archive = ControlledSeismicityArchive(
      descriptor: descriptor,
      occupiedTileIds: const [1, 2],
      tileBytes: {
        1: Uint8List.fromList([10]),
        2: Uint8List.fromList([20]),
      },
    );
    expect(identical(archive.descriptor, descriptor), isTrue);
  });

  test('records zoom and returns exact tile bytes after release', () async {
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(),
      occupiedTileIds: const [7, 8],
      tileBytes: {
        7: Uint8List.fromList([1, 2, 3]),
        8: Uint8List.fromList([4]),
      },
    )..pauseBeforeNextEnumeration()
      ..pauseBeforeNextRead();

    final idsFuture = archive.occupiedTileIdsAtZoom(zoom: 3).toList();
    await fixtures.waitUntil(() => archive.zoomRequests.isNotEmpty);
    expect(archive.zoomRequests, [3]);
    archive.releaseEnumeration();
    expect(await idsFuture, [7, 8]);

    final bytesFuture = archive.readTile(tileId: 7);
    await fixtures.waitUntil(() => archive.readRequests.isNotEmpty);
    expect(archive.readRequests, [7]);
    archive.releaseRead();
    expect(await bytesFuture, Uint8List.fromList([1, 2, 3]));
  });

  test('close releases blocked ops once with configured failure', () async {
    final failure = SeismicityPmTilesException.corruptArchive(
      reason: 'closed-while-paused',
    );
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(),
      occupiedTileIds: const [1],
      tileBytes: {1: Uint8List.fromList([9])},
      closeReleaseFailure: failure,
    )..pauseBeforeNextEnumeration()
      ..pauseBeforeNextRead();

    final ids = expectLater(
      archive.occupiedTileIdsAtZoom(zoom: 0).toList(),
      throwsA(same(failure)),
    );
    final tile = expectLater(
      archive.readTile(tileId: 1),
      throwsA(same(failure)),
    );
    await fixtures.waitUntil(
      () => archive.zoomRequests.isNotEmpty && archive.readRequests.isNotEmpty,
    );
    final firstClose = archive.close();
    final secondClose = archive.close();
    await Future.wait<void>([ids, tile, firstClose, secondClose]);
    expect(identical(firstClose, secondClose), isTrue);
    expect(archive.closeCount, 1);
    expect(archive.isClosed, isTrue);
  });

  test('queues typed failures for enumeration and read', () async {
    final enumFailure = SeismicityPmTilesException.corruptArchive(
      reason: 'enum-fail',
    );
    final readFailure = SeismicityPmTilesException.tileNotFound(tileId: 99);
    final archive = ControlledSeismicityArchive(
      descriptor: fixtures.descriptor(),
      occupiedTileIds: const [1],
      tileBytes: {1: Uint8List.fromList([1])},
    )
      ..queueEnumerationFailure(error: enumFailure)
      ..queueReadFailure(error: readFailure);

    await expectLater(
      archive.occupiedTileIdsAtZoom(zoom: 1).toList(),
      throwsA(same(enumFailure)),
    );
    await expectLater(
      archive.readTile(tileId: 1),
      throwsA(same(readFailure)),
    );
    expect(await archive.readTile(tileId: 1), Uint8List.fromList([1]));
  });
}

final class _Task45Fixtures {
  SeismicityPmTilesArchiveDescriptor descriptor() =>
      SeismicityPmTilesArchiveDescriptor(
        source: SeismicityPmTilesSource.network(
          archiveUri: Uri.parse('https://example.test/archive.pmtiles'),
        ),
        schemaVersion: 1,
        dataZoom: 0,
        expectedSizeBytes: 64,
        expectedFeatureCount: 2,
        archiveRevision: 'rev-task-45',
        periodFrom: DateTime.utc(2024),
        periodTo: DateTime.utc(2025),
      );

  Future<void> waitUntil(bool Function() predicate) async {
    final deadline = DateTime.now().add(const Duration(seconds: 3));
    while (!predicate()) {
      if (DateTime.now().isAfter(deadline)) {
        throw StateError('Timed out waiting for controlled archive signal.');
      }
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
  }
}
