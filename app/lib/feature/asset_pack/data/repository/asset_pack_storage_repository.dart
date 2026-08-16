import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_content_validator.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:version/version.dart';

part 'asset_pack_storage_repository.g.dart';

typedef ResolveBundledAssetPackRoot = Future<String> Function();
typedef ResolveAssetPackStorageRoot = Future<Directory> Function();

enum AssetPackSourceKind { bundled, downloaded }

class AssetPackSource {
  const new({
    required this.kind,
    required this.rootDirectory,
    required this.version,
  });

  final AssetPackSourceKind kind;
  final Directory rootDirectory;
  final String? version;
}

class AssetPackStorageException implements Exception {
  const new(this.message);

  final String message;

  @override
  String toString() => 'AssetPackStorageException: $message';
}

class AssetPackStorageRepository {
  new({
    required SharedPreferencesDataSource preferences,
    required ResolveBundledAssetPackRoot resolveBundledRoot,
    required ResolveAssetPackStorageRoot resolveStorageRoot,
    AssetPackContentValidator contentValidator =
        const AssetPackContentValidator(),
  }) : _preferences = preferences,
       _resolveBundledRoot = resolveBundledRoot,
       _resolveStorageRoot = resolveStorageRoot,
       _contentValidator = contentValidator;

  final SharedPreferencesDataSource _preferences;
  final ResolveBundledAssetPackRoot _resolveBundledRoot;
  final ResolveAssetPackStorageRoot _resolveStorageRoot;
  final AssetPackContentValidator _contentValidator;
  String? _verifiedDownloadedVersion;

  Future<AssetPackSource> resolveActiveSource() async {
    final bundledSource = await resolveBundledAssetPackSource(
      resolveBundledRoot: _resolveBundledRoot,
    );
    final activeVersion = await _preferences.getString(
      key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
    );
    if (activeVersion != null && isAssetPackVersion(activeVersion)) {
      final storageRoot = await _resolveStorageRoot();
      final activeDirectory = Directory(
        p.join(storageRoot.path, 'packs', activeVersion),
      );
      try {
        if (_verifiedDownloadedVersion != activeVersion) {
          final downloadedManifest = await _contentValidator.validate(
            rootDirectory: activeDirectory,
            expectedVersion: activeVersion,
          );
          final bundledManifestJson = await readAssetPackManifestJson(
            rootDirectory: bundledSource.rootDirectory,
          );
          final bundledVersion = bundledManifestJson['pack_version'];
          if (bundledVersion is! String ||
              !isAssetPackVersion(bundledVersion)) {
            throw const AssetPackStorageException('同梱 Asset Pack のバージョンが不正です。');
          }
          if (Version.parse(bundledVersion) >
              Version.parse(downloadedManifest.packVersion)) {
            await deactivateDownloadedVersion(version: activeVersion);
            return bundledSource;
          }
          _verifiedDownloadedVersion = activeVersion;
        }
        return AssetPackSource(
          kind: AssetPackSourceKind.downloaded,
          rootDirectory: activeDirectory,
          version: activeVersion,
        );
      } on Object {
        await deactivateDownloadedVersion(version: activeVersion);
        _verifiedDownloadedVersion = null;
      }
    }
    return bundledSource;
  }

  Future<Directory> createStagingDirectory({required String version}) async {
    if (!isAssetPackVersion(version)) {
      throw const AssetPackStorageException('Asset Pack のバージョンが不正です。');
    }
    final storageRoot = await _resolveStorageRoot();
    final stagingRoot = Directory(p.join(storageRoot.path, 'staging'));
    await stagingRoot.create(recursive: true);
    return stagingRoot.createTemp('$version-');
  }

  Future<void> deactivateDownloadedVersion({required String version}) async {
    if (!isAssetPackVersion(version)) {
      return;
    }
    final activeVersion = await _preferences.getString(
      key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
    );
    if (activeVersion != version) {
      return;
    }
    final storageRoot = await _resolveStorageRoot();
    await deactivateCorruptAssetPack(
      preferences: _preferences,
      directory: Directory(p.join(storageRoot.path, 'packs', version)),
    );
    _verifiedDownloadedVersion = null;
  }

  Future<void> activate({
    required Directory stagingDirectory,
    required String version,
  }) async {
    try {
      final storageRoot = await _resolveStorageRoot();
      final normalizedStorageRoot = p.normalize(p.absolute(storageRoot.path));
      final normalizedStaging = p.normalize(p.absolute(stagingDirectory.path));
      if (!isAssetPackVersion(version) ||
          !p.isWithin(normalizedStorageRoot, normalizedStaging)) {
        throw const AssetPackStorageException(
          'Asset Pack の一時保存先またはバージョンが不正です。',
        );
      }
      await _contentValidator.validate(
        rootDirectory: stagingDirectory,
        expectedVersion: version,
      );

      final packsRoot = Directory(p.join(storageRoot.path, 'packs'));
      await packsRoot.create(recursive: true);
      final destination = Directory(p.join(packsRoot.path, version));
      await installVerifiedStagingDirectory(
        stagingDirectory: stagingDirectory,
        destinationDirectory: destination,
        version: version,
        contentValidator: _contentValidator,
      );
      await _preferences.setString(
        key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
        value: version,
      );
      _verifiedDownloadedVersion = version;
      await cleanupInactiveAssetPackVersions(
        packsRoot: packsRoot,
        activeVersion: version,
      );
    } on AssetPackStorageException {
      rethrow;
    } on Object catch (error) {
      throw AssetPackStorageException('Asset Pack を安全に切り替えられませんでした: $error');
    }
  }
}

@Riverpod(keepAlive: true)
Future<AssetPackStorageRepository> assetPackStorageRepository(Ref ref) async {
  final preferences = await ref.watch(
    sharedPreferencesDataSourceProvider.future,
  );
  return AssetPackStorageRepository(
    preferences: preferences,
    resolveBundledRoot: AssetsUtil.resolvePackRoot,
    resolveStorageRoot: () async {
      final supportDirectory = await getApplicationSupportDirectory();
      return Directory(p.join(supportDirectory.path, 'eqmonitor_asset_packs'));
    },
  );
}

bool isAssetPackVersion(String value) =>
    RegExp(r'^\d+\.\d+\.\d+$').hasMatch(value);

Future<AssetPackSource> resolveBundledAssetPackSource({
  required ResolveBundledAssetPackRoot resolveBundledRoot,
}) async {
  final directory = Directory(await resolveBundledRoot());
  final manifest = File(p.join(directory.path, 'manifest.json'));
  if (!directory.existsSync() || !manifest.existsSync()) {
    throw const AssetPackStorageException('アプリに同梱された Asset Pack を読み込めません。');
  }
  return AssetPackSource(
    kind: AssetPackSourceKind.bundled,
    rootDirectory: directory,
    version: null,
  );
}

Future<void> installVerifiedStagingDirectory({
  required Directory stagingDirectory,
  required Directory destinationDirectory,
  required String version,
  required AssetPackContentValidator contentValidator,
}) async {
  if (destinationDirectory.existsSync()) {
    try {
      await contentValidator.validate(
        rootDirectory: destinationDirectory,
        expectedVersion: version,
      );
      await stagingDirectory.delete(recursive: true);
      return;
    } on Object {
      await destinationDirectory.delete(recursive: true);
    }
  }
  await stagingDirectory.rename(destinationDirectory.path);
}

Future<void> cleanupInactiveAssetPackVersions({
  required Directory packsRoot,
  required String activeVersion,
}) async {
  if (!packsRoot.existsSync()) {
    return;
  }
  await for (final entity in packsRoot.list()) {
    if (entity is Directory &&
        p.basename(entity.path) != activeVersion &&
        isAssetPackVersion(p.basename(entity.path))) {
      await entity.delete(recursive: true);
    }
  }
}

Future<void> deactivateCorruptAssetPack({
  required SharedPreferencesDataSource preferences,
  required Directory directory,
}) async {
  await preferences.remove(
    key: SharedPreferencesKey.assetPackActiveDownloadedVersion,
  );
  try {
    if (directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  } on FileSystemException {
    // The preference is already cleared, so the bundled pack is used even if
    // the OS temporarily prevents cleanup. A later successful activation
    // retries removal as part of old-version cleanup.
  }
}
