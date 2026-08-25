import 'package:eqmonitor_map/src/geo/tile_id.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_repository.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

import '../support/controlled_remote_pmtiles_server.dart';
import '../support/minimal_pmtiles_archive_builder.dart';

const _archiveLimits = PmTilesV3Limits(
  maxDirectoryDepth: 3,
  rootDirectoryWindowLength: 16384,
  maxDirectoryEncodedBytes: 1 << 20,
  maxDirectoryDecodedBytes: 8 << 20,
  maxTileEncodedBytes: 4 << 20,
  maxTileDecodedBytes: 16 << 20,
);

void main() {
  final archiveBytes = const MinimalPmTilesArchiveBuilder().buildSingleTile(
    tileId: 1,
    tileBytes: const [1, 2, 3],
    minZoom: 1,
    maxZoom: 1,
  );

  late ControlledRemotePmTilesServer server;
  setUp(() async {
    server = await ControlledRemotePmTilesServer.start(
      archiveBytes: archiveBytes,
    );
  });
  tearDown(() => server.stop());

  test('opens a remote verified source and reads tiles end to end', () async {
    final repository = await BaseMapTileRepository.open(
      source: createVerifiedRemotePmTilesSource(
        sourceInstanceId: 'remote-1',
        sourceRevision: 1,
        url: server.url,
        sizeBytes: archiveBytes.length,
        sha256: 'a' * 64,
      ),
      limits: _archiveLimits,
      remoteMaxCacheBytes: 1 << 16,
    );
    addTearDown(repository.close);

    expect(
      await repository.readTile(const CanonicalTileId(z: 1, x: 0, y: 0)),
      orderedEquals([1, 2, 3]),
    );
    expect(
      await repository.readTile(const CanonicalTileId(z: 1, x: 1, y: 1)),
      isNull,
    );
  });

  test('requires an explicit cache budget for a remote source', () async {
    await expectLater(
      BaseMapTileRepository.open(
        source: createVerifiedRemotePmTilesSource(
          sourceInstanceId: 'remote-1',
          sourceRevision: 1,
          url: server.url,
          sizeBytes: archiveBytes.length,
          sha256: 'a' * 64,
        ),
        limits: _archiveLimits,
      ),
      throwsArgumentError,
    );
  });
}
