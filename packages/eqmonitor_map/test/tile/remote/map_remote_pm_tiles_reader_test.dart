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

  test('classifies a 412 as snapshot mismatch even with a gzip page', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 8); // pins "v1"
    server
      ..etag =
          '"v2"' // archive replaced → If-Match "v1" now yields 412
      ..contentEncodingOverride = 'gzip'; // 412 error page is gzip-encoded

    // The 412 must win over the non-identity encoding check and go terminal.
    await expectLater(
      reader.readAt(offset: 32, length: 8),
      throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
    );
    await expectLater(
      reader.readAt(offset: 64, length: 8),
      throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
    );
  });

  test('terminalizes a post-pin range-contract break', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 8); // pins "v1", caches [0, 8)
    server.oversizeBodyBy = 4; // later If-Match 206 breaks the body length

    await expectLater(
      reader.readAt(offset: 32, length: 8),
      throwsA(isA<MapRemoteTileBodyLengthMismatchException>()),
    );
    // terminal: even the previously cached range now fails closed.
    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileBodyLengthMismatchException>()),
    );
  });

  test('no post-poison bytes escape once a peer read terminalizes', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    await reader.readAt(offset: 0, length: 8); // pins "v1"
    server.etag = '"v2"'; // archive replaced under the same URL

    // Two concurrent post-pin (If-Match "v1") reads: the server answers each
    // with 412. Whichever detects it first terminalizes; neither may return
    // bytes or leave a repinned/cached range behind.
    Future<Object> outcomeOf(int offset) => reader
        .readAt(offset: offset, length: 8)
        .then<Object>((bytes) => bytes, onError: (Object e) => e);
    final outcomes = await Future.wait([outcomeOf(16), outcomeOf(24)]);
    for (final outcome in outcomes) {
      expect(outcome, isA<MapRemoteTileException>());
    }
    // The originally cached range must not survive the poison either.
    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileException>()),
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

  test('serializes concurrent first reads (one omits If-Match)', () async {
    final reader = await readerOf();
    addTearDown(reader.close);

    final results = await Future.wait([
      reader.readAt(offset: 0, length: 8),
      reader.readAt(offset: 8, length: 8),
    ]);
    expect(results[0], archive.sublist(0, 8));
    expect(results[1], archive.sublist(8, 16));
    // 最初の read だけ If-Match 無しで走り、2 本目は pin 済み ETag で追従する。
    expect(server.ifMatchRequests, [null, '"v1"']);
  });

  test('rejects an oversized body without buffering it unbounded', () async {
    server.oversizeBodyBy = 4;
    final reader = await readerOf();
    addTearDown(reader.close);

    await expectLater(
      reader.readAt(offset: 0, length: 8),
      throwsA(isA<MapRemoteTileBodyLengthMismatchException>()),
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

  // 既知の境界をピン留めする。RED になったら digest 束縛が入った合図なので、
  // expectation を緩めずに reader の doc と todo 815 を併せて更新すること。
  test(
    'does not bind response bytes to source.sha256 (known gap #1592)',
    () async {
      final reader = await readerOf();
      addTearDown(reader.close);

      // ETag は据え置いたまま archive の中身だけ差し替える。
      server.archiveBytes.setAll(0, List.filled(16, 0xEE));

      expect(
        await reader.readAt(offset: 0, length: 16),
        everyElement(0xEE),
        reason: 'sha256 束縛が入るまでは差し替えられた byte も受理される',
      );
    },
  );
}
