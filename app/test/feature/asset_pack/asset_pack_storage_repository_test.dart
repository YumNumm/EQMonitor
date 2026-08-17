import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late Directory temporaryDirectory;
  late Directory bundledDirectory;
  late Directory storageDirectory;
  late SharedPreferencesDataSource preferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    preferences = SharedPreferencesDataSource(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'asset_pack_storage_repository_test_',
    );
    bundledDirectory = Directory('${temporaryDirectory.path}/bundled');
    storageDirectory = Directory('${temporaryDirectory.path}/storage');
    await writePack(root: bundledDirectory, version: '1.0.0');
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('uses the bundled pack when no downloaded pack is active', () async {
    final repository = createRepository(
      bundledDirectory: bundledDirectory,
      storageDirectory: storageDirectory,
      preferences: preferences,
    );

    final source = await repository.resolveActiveSource();

    expect(source.kind, AssetPackSourceKind.bundled);
    expect(source.rootDirectory.path, bundledDirectory.path);
  });

  test(
    'activates a verified pack and deletes older downloaded versions',
    () async {
      final repository = createRepository(
        bundledDirectory: bundledDirectory,
        storageDirectory: storageDirectory,
        preferences: preferences,
      );
      final oldStaging = await repository.createStagingDirectory(
        version: '1.1.0',
      );
      await writePack(root: oldStaging, version: '1.1.0');
      await repository.activate(stagingDirectory: oldStaging, version: '1.1.0');
      final newStaging = await repository.createStagingDirectory(
        version: '1.2.0',
      );
      await writePack(root: newStaging, version: '1.2.0');

      await repository.activate(stagingDirectory: newStaging, version: '1.2.0');
      final source = await repository.resolveActiveSource();

      expect(source.kind, AssetPackSourceKind.downloaded);
      expect(source.version, '1.2.0');
      expect(
        Directory('${storageDirectory.path}/packs/1.1.0').existsSync(),
        isFalse,
      );
      expect(
        Directory('${storageDirectory.path}/packs/1.2.0').existsSync(),
        isTrue,
      );
    },
  );

  test('falls back to bundled and removes a corrupt active download', () async {
    final repository = createRepository(
      bundledDirectory: bundledDirectory,
      storageDirectory: storageDirectory,
      preferences: preferences,
    );
    final staging = await repository.createStagingDirectory(version: '1.1.0');
    await writePack(root: staging, version: '1.1.0');
    await repository.activate(stagingDirectory: staging, version: '1.1.0');
    final activeFile = File(
      '${storageDirectory.path}/packs/1.1.0/map/all.pmtiles',
    );
    await activeFile.writeAsString('corrupt');

    final restartedRepository = createRepository(
      bundledDirectory: bundledDirectory,
      storageDirectory: storageDirectory,
      preferences: preferences,
    );
    final source = await restartedRepository.resolveActiveSource();

    expect(source.kind, AssetPackSourceKind.bundled);
    expect(
      Directory('${storageDirectory.path}/packs/1.1.0').existsSync(),
      isFalse,
    );
    expect(
      await preferences.getString(
        key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
      ),
      isNull,
    );
  });

  test(
    'uses a newer bundled pack and removes the older active download',
    () async {
      final repository = createRepository(
        bundledDirectory: bundledDirectory,
        storageDirectory: storageDirectory,
        preferences: preferences,
      );
      final staging = await repository.createStagingDirectory(version: '1.1.0');
      await writePack(root: staging, version: '1.1.0');
      await repository.activate(stagingDirectory: staging, version: '1.1.0');
      await writePack(root: bundledDirectory, version: '1.2.0');

      final restartedRepository = createRepository(
        bundledDirectory: bundledDirectory,
        storageDirectory: storageDirectory,
        preferences: preferences,
      );
      final source = await restartedRepository.resolveActiveSource();

      expect(source.kind, AssetPackSourceKind.bundled);
      expect(
        Directory('${storageDirectory.path}/packs/1.1.0').existsSync(),
        isFalse,
      );
      expect(
        await preferences.getString(
          key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
        ),
        isNull,
      );
    },
  );

  test(
    'keeps the current pack active when a new staging pack is invalid',
    () async {
      final repository = createRepository(
        bundledDirectory: bundledDirectory,
        storageDirectory: storageDirectory,
        preferences: preferences,
      );
      final currentStaging = await repository.createStagingDirectory(
        version: '1.1.0',
      );
      await writePack(root: currentStaging, version: '1.1.0');
      await repository.activate(
        stagingDirectory: currentStaging,
        version: '1.1.0',
      );
      final invalidStaging = await repository.createStagingDirectory(
        version: '1.2.0',
      );
      await writePack(root: invalidStaging, version: '1.2.0');
      await File('${invalidStaging.path}/map/all.pmtiles').writeAsString('bad');

      await expectLater(
        repository.activate(stagingDirectory: invalidStaging, version: '1.2.0'),
        throwsA(isA<AssetPackStorageException>()),
      );

      final source = await repository.resolveActiveSource();
      expect(source.kind, AssetPackSourceKind.downloaded);
      expect(source.version, '1.1.0');
    },
  );
}

AssetPackStorageRepository createRepository({
  required Directory bundledDirectory,
  required Directory storageDirectory,
  required SharedPreferencesDataSource preferences,
}) => AssetPackStorageRepository(
  preferences: preferences,
  resolveBundledRoot: () async => bundledDirectory.path,
  resolveStorageRoot: () async => storageDirectory,
);

Future<void> writePack({
  required Directory root,
  required String version,
}) async {
  final content = utf8.encode('map-$version');
  final asset = File('${root.path}/map/all.pmtiles');
  await asset.parent.create(recursive: true);
  await asset.writeAsBytes(content);
  await File('${root.path}/manifest.json').writeAsString(
    jsonEncode({
      'pack_version': version,
      'schema_version': 1,
      'generated_at': '2026-08-16T00:00:00.000Z',
      'assets': [
        {
          'id': 'BASE_MAP_PMTILES',
          'kind': 'pmtiles',
          'path': 'map/all.pmtiles',
          'schema_version': 1,
          'source_version': 'test',
          'source_updated_at': null,
          'source_urls': <String>[],
          'sha256': sha256.convert(content).toString(),
          'size_bytes': content.length,
        },
      ],
    }),
  );
}
