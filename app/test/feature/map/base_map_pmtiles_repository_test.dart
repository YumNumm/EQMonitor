import 'dart:convert';
import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/map/data/repository/base_map_pmtiles_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, Object?> _manifestJson() => {
  'pack_version': '1.0.0',
  'schema_version': 1,
  'generated_at': '2026-07-18T09:00:00+09:00',
  'assets': [
    {
      'id': 'BASE_MAP_PMTILES',
      'kind': 'pmtiles',
      'path': 'map/all.pmtiles',
      'schema_version': 1,
      'source_version': '20260718',
      'source_updated_at': '2026-07-18T00:00:00+09:00',
      'source_urls': ['https://www.data.jma.go.jp/developer/gis.html'],
      'sha256': 'a' * 64,
      'size_bytes': 12,
    },
  ],
};

void main() {
  group('BaseMapPmtilesRepository', () {
    test(
      'Web throws an explicit UnsupportedError (map is unsupported on '
      'Web) without touching the Asset Pack',
      () async {
        final repository = BaseMapPmtilesRepository(
          assetPackRepository: AssetPackRepository(
            resolvePackRoot: () async =>
                throw StateError('should not be called on Web'),
          ),
          isWeb: () => true,
        );

        await expectLater(
          repository.resolveSourceUri(),
          throwsA(
            isA<UnsupportedError>().having(
              (e) => e.message,
              'message',
              contains('Web'),
            ),
          ),
        );
      },
    );

    test(
      'resolves a pmtiles:// file URI from the Asset Pack when not on Web',
      () async {
        final tempDir = await Directory.systemTemp.createTemp(
          'base_map_pmtiles_test',
        );
        addTearDown(() => tempDir.delete(recursive: true));
        await File(
          '${tempDir.path}/manifest.json',
        ).writeAsString(jsonEncode(_manifestJson()));
        final mapDir = Directory('${tempDir.path}/map')
          ..createSync(recursive: true);
        final pmtilesFile = File('${mapDir.path}/all.pmtiles')
          ..writeAsStringSync('pmtiles-bytes');

        final repository = BaseMapPmtilesRepository(
          assetPackRepository: AssetPackRepository(
            resolvePackRoot: () async => tempDir.path,
          ),
          isWeb: () => false,
          isSupportedPlatform: () => true,
        );

        final uri = await repository.resolveSourceUri();

        expect(uri, 'pmtiles://${Uri.file(pmtilesFile.path)}');
      },
    );

    test(
      'pack-not-ready propagates as AssetPackNotReadyException (no '
      'fallback) when not on Web',
      () async {
        final repository = BaseMapPmtilesRepository(
          assetPackRepository: AssetPackRepository(
            resolvePackRoot: () async =>
                throw const AssetPackNotReadyException('pack not downloaded'),
          ),
          isWeb: () => false,
          isSupportedPlatform: () => true,
        );

        await expectLater(
          repository.resolveSourceUri(),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'a non-Web platform without an Asset Pack backend throws a '
      'clarified UnsupportedError without touching the Asset Pack',
      () async {
        final repository = BaseMapPmtilesRepository(
          assetPackRepository: AssetPackRepository(
            resolvePackRoot: () async =>
                throw StateError('should not be called'),
          ),
          isWeb: () => false,
          isSupportedPlatform: () => false,
        );

        await expectLater(
          repository.resolveSourceUri(),
          throwsA(
            isA<UnsupportedError>().having(
              (e) => e.message,
              'message',
              contains('Asset Pack'),
            ),
          ),
        );
      },
    );
  });
}
