import 'dart:convert';
import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:flutter_test/flutter_test.dart';

final _sha256A = 'a' * 64;
final _sha256B = 'b' * 64;

Map<String, Object?> _validManifestJson() => {
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
      'sha256': _sha256A,
      'size_bytes': 12,
    },
    {
      'id': 'JMA_CODE_TABLE',
      'kind': 'json',
      'path': 'parameters/jma_code_table.json',
      'schema_version': 1,
      'source_version': '20260623',
      'source_updated_at': null,
      'source_urls': <String>[],
      'sha256': _sha256B,
      'size_bytes': 2,
    },
  ],
};

void main() {
  group('AssetPackManifest.fromJson', () {
    test('parses a valid manifest', () {
      final manifest = AssetPackManifest.fromJson(_validManifestJson());

      expect(manifest.packVersion, '1.0.0');
      expect(manifest.schemaVersion, 1);
      expect(manifest.assets, hasLength(2));
      final jmaCodeTable = manifest.findAsset(AssetPackAssetId.jmaCodeTable);
      expect(jmaCodeTable, isNotNull);
      expect(jmaCodeTable!.kind, AssetPackAssetKind.json);
      expect(jmaCodeTable.path, 'parameters/jma_code_table.json');
      expect(jmaCodeTable.sourceUpdatedAt, isNull);
      expect(
        manifest.findAsset(AssetPackAssetId.baseMapPmtiles)?.kind,
        AssetPackAssetKind.pmtiles,
      );
    });

    test('returns null for an asset id not present in the manifest', () {
      final manifest = AssetPackManifest.fromJson(_validManifestJson());
      expect(manifest.findAsset(AssetPackAssetId.tsunamiStations), isNull);
    });

    test('rejects an unsupported top-level schema_version', () {
      final json = _validManifestJson()..['schema_version'] = 2;
      expect(() => AssetPackManifest.fromJson(json), throwsFormatException);
    });

    test('rejects a malformed pack_version', () {
      final json = _validManifestJson()..['pack_version'] = 'not-a-version';
      expect(() => AssetPackManifest.fromJson(json), throwsFormatException);
    });

    test('rejects an empty assets list', () {
      final json = _validManifestJson()..['assets'] = <Object?>[];
      expect(() => AssetPackManifest.fromJson(json), throwsFormatException);
    });

    test('rejects an item with unsupported schema_version', () {
      final json = _validManifestJson();
      (json['assets']! as List)
          .cast<Map<String, Object?>>()
          .first['schema_version'] = 2;
      expect(() => AssetPackManifest.fromJson(json), throwsFormatException);
    });

    test('rejects an item with a malformed sha256', () {
      final json = _validManifestJson();
      (json['assets']! as List)
          .cast<Map<String, Object?>>()
          .first['sha256'] = 'not-a-hash';
      expect(() => AssetPackManifest.fromJson(json), throwsFormatException);
    });

    test('rejects an unknown asset id', () {
      final json = _validManifestJson();
      (json['assets']! as List)
          .cast<Map<String, Object?>>()
          .first['id'] = 'SOMETHING_ELSE';
      expect(() => AssetPackManifest.fromJson(json), throwsA(isA<Object>()));
    });
  });

  group('AssetPackRepository', () {
    late Directory tempDir;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('asset_pack_repo_test');
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    Future<void> writeManifest(Map<String, Object?> json) async {
      await File(
        '${tempDir.path}/manifest.json',
      ).writeAsString(jsonEncode(json));
    }

    Future<void> writeAsset(String relativePath, String content) async {
      final file = File('${tempDir.path}/$relativePath');
      await file.parent.create(recursive: true);
      await file.writeAsString(content);
    }

    test('readManifest parses manifest.json from the resolved pack root', () async {
      await writeManifest(_validManifestJson());
      final repository = AssetPackRepository(
        resolvePackRoot: () async => tempDir.path,
      );

      final manifest = await repository.readManifest();

      expect(manifest.packVersion, '1.0.0');
      expect(
        manifest.findAsset(AssetPackAssetId.jmaCodeTable)?.path,
        'parameters/jma_code_table.json',
      );
    });

    test('resolveAsset returns the file at the manifest-listed path', () async {
      await writeManifest(_validManifestJson());
      await writeAsset('parameters/jma_code_table.json', '{"ok":true}');
      final repository = AssetPackRepository(
        resolvePackRoot: () async => tempDir.path,
      );

      final file = await repository.resolveAsset(AssetPackAssetId.jmaCodeTable);

      expect(file.path, '${tempDir.path}/parameters/jma_code_table.json');
      expect(await file.readAsString(), '{"ok":true}');
    });

    test(
      'pack not ready: resolvePackRoot throwing AssetPackNotReadyException '
      'propagates unchanged from readManifest (no fallback)',
      () async {
        final repository = AssetPackRepository(
          resolvePackRoot: () async =>
              throw const AssetPackNotReadyException('pack not downloaded'),
        );

        await expectLater(
          repository.readManifest(),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'pack not ready: resolvePackRoot throwing AssetPackNotReadyException '
      'propagates unchanged from resolveAsset (no fallback)',
      () async {
        final repository = AssetPackRepository(
          resolvePackRoot: () async =>
              throw const AssetPackNotReadyException('pack not downloaded'),
        );

        await expectLater(
          repository.resolveAsset(AssetPackAssetId.jmaCodeTable),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'missing manifest.json throws AssetPackNotReadyException '
      '(no fallback)',
      () async {
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.readManifest(),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'corrupt manifest.json (invalid JSON) throws AssetPackNotReadyException',
      () async {
        await File('${tempDir.path}/manifest.json').writeAsString('{not json');
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.readManifest(),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'manifest failing schema validation throws AssetPackNotReadyException',
      () async {
        final json = _validManifestJson()..['schema_version'] = 99;
        await writeManifest(json);
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.readManifest(),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'resolveAsset throws AssetPackNotReadyException when the manifest '
      'does not list the requested asset',
      () async {
        await writeManifest(_validManifestJson());
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.resolveAsset(AssetPackAssetId.tsunamiStations),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'resolveAsset throws AssetPackNotReadyException when the file listed '
      'in the manifest is missing on disk',
      () async {
        await writeManifest(_validManifestJson());
        // parameters/jma_code_table.json intentionally not written.
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.resolveAsset(AssetPackAssetId.jmaCodeTable),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );

    test(
      'resolveAsset throws AssetPackNotReadyException when the resolved '
      'file is empty',
      () async {
        await writeManifest(_validManifestJson());
        await writeAsset('parameters/jma_code_table.json', '');
        final repository = AssetPackRepository(
          resolvePackRoot: () async => tempDir.path,
        );

        await expectLater(
          repository.resolveAsset(AssetPackAssetId.jmaCodeTable),
          throwsA(isA<AssetPackNotReadyException>()),
        );
      },
    );
  });
}
