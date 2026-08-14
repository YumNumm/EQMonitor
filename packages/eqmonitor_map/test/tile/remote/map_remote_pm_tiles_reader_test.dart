import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/remote/map_remote_pm_tiles_reader.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/controlled_remote_pmtiles_server.dart';

void main() {
  final archive = Uint8List.fromList(List.generate(256, (i) => i % 256));

  late ControlledRemotePmTilesServer server;

  Future<MapRemotePmTilesRandomAccessReader> readerOf() async {
    final source = createVerifiedRemotePmTilesSource(
      sourceInstanceId: 'remote-1',
      sourceRevision: 1,
      url: server.url,
      sizeBytes: archive.length,
      sha256: 'a' * 64,
    );
    return MapRemotePmTilesRandomAccessReader(
      source: source,
      maxCacheBytes: 4096,
    );
  }

  setUp(() async {
    server = await ControlledRemotePmTilesServer.start(archiveBytes: archive);
  });
  tearDown(() => server.stop());

  test('reads the requested byte range over a real 206 response', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    final bytes = await reader.readAt(offset: 10, length: 8);
    expect(bytes, archive.sublist(10, 18));
    expect(reader.sizeBytes, archive.length);
  });

  test('serves a repeated range from cache without a second request', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 16);
    await reader.readAt(offset: 0, length: 16);
    expect(server.rangeRequests.length, 1);
  });

  test('rejects a 200 full-body response for a Range request', () async {
    server.statusOverride = 200;
    final reader = await readerOf();
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileUnexpectedStatusException>()),
    );
  });

  test('rejects a non-identity Content-Encoding', () async {
    server.contentEncodingOverride = 'gzip';
    final reader = await readerOf();
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileNonIdentityEncodingException>()),
    );
  });

  test('refuses to follow a redirect outside the verified URL', () async {
    server.redirectTo = Uri.parse('https://evil.example.com/base.pmtiles');
    final reader = await readerOf();
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileRedirectRejectedException>()),
    );
  });

  test('fails closed and stays terminal when the snapshot drifts', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 8);
    server.etag = '"v2"'; // archive replaced under the same URL

    await expectLater(
      reader.readAt(offset: 32, length: 8),
      throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
    );
    // subsequent reads remain terminally failed, even for a cached range.
    await expectLater(
      reader.readAt(offset: 64, length: 8),
      throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
    );
  });

  test('rejects reads after close', () async {
    final reader = await readerOf();
    await reader.close();

    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileClosedException>()),
    );
  });

  test('rejects a range beyond the verified archive size', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: archive.length - 4, length: 8),
      throwsArgumentError,
    );
  });
}
