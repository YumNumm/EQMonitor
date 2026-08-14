import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:flutter_test/flutter_test.dart';

final String _sha256 = 'a' * 64;

void main() {
  group('VerifiedPmTilesSource', () {
    test('is a VerifiedTileSource and has value equality', () {
      final source = VerifiedPmTilesSource(
        sourceInstanceId: 'local-1',
        absolutePath: '/tmp/base.pmtiles',
        sizeBytes: 128,
        sha256: _sha256,
      );
      expect(source, isA<VerifiedTileSource>());
      expect(source.sourceInstanceId, 'local-1');
      expect(
        source,
        VerifiedPmTilesSource(
          sourceInstanceId: 'local-1',
          absolutePath: '/tmp/base.pmtiles',
          sizeBytes: 128,
          sha256: _sha256,
        ),
      );
    });
  });

  group('createVerifiedRemotePmTilesSource', () {
    VerifiedRemotePmTilesSource build({
      String url = 'https://cdn.example.com/base.pmtiles',
      int revision = 3,
      int sizeBytes = 4096,
      String? sha256,
    }) => createVerifiedRemotePmTilesSource(
      sourceInstanceId: 'remote-1',
      sourceRevision: revision,
      url: Uri.parse(url),
      sizeBytes: sizeBytes,
      sha256: sha256 ?? _sha256,
    );

    test('builds an https descriptor with value equality', () {
      final source = build();
      expect(source, isA<VerifiedTileSource>());
      expect(source.sourceInstanceId, 'remote-1');
      expect(source.sourceRevision, 3);
      expect(source, build());
    });

    test('rejects non-https URLs', () {
      expect(
        () => build(url: 'http://cdn.example.com/base.pmtiles'),
        throwsArgumentError,
      );
    });

    test('rejects negative revision and non-positive size', () {
      expect(() => build(revision: -1), throwsArgumentError);
      expect(() => build(sizeBytes: 0), throwsArgumentError);
    });

    test('rejects a sha256 that is not 64 hex chars', () {
      expect(() => build(sha256: 'abc'), throwsArgumentError);
    });

    test('sealed dispatch distinguishes local from remote sources', () {
      final VerifiedTileSource remote = build();
      final VerifiedTileSource local = VerifiedPmTilesSource(
        sourceInstanceId: 'local-1',
        absolutePath: '/tmp/base.pmtiles',
        sizeBytes: 128,
        sha256: _sha256,
      );
      String kind(VerifiedTileSource source) => switch (source) {
        VerifiedPmTilesSource() => 'local',
        VerifiedRemotePmTilesSource() => 'remote',
      };
      expect(kind(remote), 'remote');
      expect(kind(local), 'local');
    });
  });
}
