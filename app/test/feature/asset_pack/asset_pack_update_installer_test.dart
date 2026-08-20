import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_update_installer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/asset_pack_distribution.dart';

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
      'asset_pack_update_installer_test_',
    );
    bundledDirectory = Directory('${temporaryDirectory.path}/bundled');
    storageDirectory = Directory('${temporaryDirectory.path}/storage');
    await writePack(root: bundledDirectory, version: '1.0.0');
  });

  tearDown(() async {
    await temporaryDirectory.delete(recursive: true);
  });

  test('downloads, verifies, extracts and activates with progress', () async {
    final archiveFile = await writePackZip(
      root: temporaryDirectory,
      version: '1.1.0',
    );
    final entry = await distributionEntryFor(archiveFile, version: '1.1.0');
    final progress = <AssetPackInstallProgress>[];
    final installer = createInstaller(
      bundledDirectory: bundledDirectory,
      storageDirectory: storageDirectory,
      preferences: preferences,
      archiveFile: archiveFile,
    );

    await installer.install(entry: entry, onProgress: progress.add);

    final source = await installer.storageRepository.resolveActiveSource();
    expect(source.kind, AssetPackSourceKind.downloaded);
    expect(source.version, '1.1.0');
    expect(
      progress.map((value) => value.phase),
      containsAllInOrder([
        AssetPackInstallPhase.downloading,
        AssetPackInstallPhase.verifying,
        AssetPackInstallPhase.extracting,
        AssetPackInstallPhase.activating,
        AssetPackInstallPhase.completed,
      ]),
    );
    expect(archiveFile.existsSync(), isFalse);
  });

  test(
    'rejects a download whose hash differs from the signed manifest',
    () async {
      final archiveFile = await writePackZip(
        root: temporaryDirectory,
        version: '1.1.0',
      );
      final validEntry = await distributionEntryFor(
        archiveFile,
        version: '1.1.0',
      );
      final corruptEntry = validEntry.copyWith(
        archiveSha256: List.filled(64, '0').join(),
      );
      final installer = createInstaller(
        bundledDirectory: bundledDirectory,
        storageDirectory: storageDirectory,
        preferences: preferences,
        archiveFile: archiveFile,
      );

      await expectLater(
        installer.install(entry: corruptEntry, onProgress: (_) {}),
        throwsA(isA<AssetPackInstallException>()),
      );

      expect(
        (await installer.storageRepository.resolveActiveSource()).kind,
        AssetPackSourceKind.bundled,
      );
      expect(archiveFile.existsSync(), isFalse);
    },
  );

  test('rejects an unsafe ZIP without changing the active source', () async {
    final archive = Archive()..add(ArchiveFile.string('../outside.txt', 'bad'));
    final archiveFile = File('${temporaryDirectory.path}/unsafe.zip');
    await archiveFile.writeAsBytes(ZipEncoder().encodeBytes(archive));
    final entry = await distributionEntryFor(archiveFile, version: '1.1.0');
    final installer = createInstaller(
      bundledDirectory: bundledDirectory,
      storageDirectory: storageDirectory,
      preferences: preferences,
      archiveFile: archiveFile,
    );

    await expectLater(
      installer.install(entry: entry, onProgress: (_) {}),
      throwsA(isA<AssetPackInstallException>()),
    );

    expect(
      (await installer.storageRepository.resolveActiveSource()).kind,
      AssetPackSourceKind.bundled,
    );
    expect(
      File('${temporaryDirectory.path}/outside.txt').existsSync(),
      isFalse,
    );
  });
}

AssetPackUpdateInstaller createInstaller({
  required Directory bundledDirectory,
  required Directory storageDirectory,
  required SharedPreferencesDataSource preferences,
  required File archiveFile,
}) {
  final storageRepository = AssetPackStorageRepository(
    preferences: preferences,
    resolveBundledRoot: () async => bundledDirectory.path,
    resolveStorageRoot: () async => storageDirectory,
  );
  return AssetPackUpdateInstaller(
    storageRepository: storageRepository,
    downloadArchive: ({required entry, required onProgress}) async {
      onProgress(0.25);
      onProgress(1);
      return archiveFile;
    },
  );
}

Future<File> writePackZip({
  required Directory root,
  required String version,
}) async {
  final source = Directory('${root.path}/zip-source');
  await writePack(root: source, version: version);
  final archive = Archive()
    ..add(
      ArchiveFile.string(
        'manifest.json',
        await File('${source.path}/manifest.json').readAsString(),
      ),
    )
    ..add(
      ArchiveFile.bytes(
        'map/all.pmtiles',
        await File('${source.path}/map/all.pmtiles').readAsBytes(),
      ),
    );
  final archiveFile = File('${root.path}/asset-pack-v$version.zip');
  await archiveFile.writeAsBytes(ZipEncoder().encodeBytes(archive));
  return archiveFile;
}

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

Future<AssetPackDistributionEntry> distributionEntryFor(
  File archiveFile, {
  required String version,
}) async => AssetPackDistributionEntry(
  version: version,
  publishedAt: '2026-08-16',
  minimumAppVersion: '3.0.0',
  archivePath: 'packs/$version/asset-pack-v$version.zip',
  archiveSizeBytes: await archiveFile.length(),
  archiveSha256: (await sha256.bind(archiveFile.openRead()).first).toString(),
  localizations: assetPackChangelogLocalizationsFixture,
);
