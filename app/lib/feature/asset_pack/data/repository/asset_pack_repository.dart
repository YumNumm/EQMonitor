import 'dart:convert';
import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:assets_util/assets_util.dart' show AssetPackNotReadyException;

part 'asset_pack_repository.g.dart';

@Riverpod(keepAlive: true)
AssetPackRepository assetPackRepository(Ref ref) => AssetPackRepository(
  resolvePackSource: () async {
    final storage = await ref.read(assetPackStorageRepositoryProvider.future);
    return storage.resolveActiveSource();
  },
  deactivateDownloadedSource: (source) async {
    final version = source.version;
    if (version == null) {
      return;
    }
    final storage = await ref.read(assetPackStorageRepositoryProvider.future);
    await storage.deactivateDownloadedVersion(version: version);
  },
);

typedef ResolveAssetPackSource = Future<AssetPackSource> Function();
typedef DeactivateDownloadedAssetPackSource =
    Future<void> Function(AssetPackSource source);

/// Reads `manifest.json` and individual assets from the active local pack.
///
/// A verified R2 download is preferred. If it is missing or corrupt,
/// [AssetPackStorageRepository] deactivates it and returns the immutable pack
/// bundled with the installed app. There is no fake-data fallback.
class AssetPackRepository {
  AssetPackRepository({
    ResolveAssetPackFile? resolvePackFile,
    Future<String> Function()? resolvePackRoot,
    ResolveAssetPackSource? resolvePackSource,
    DeactivateDownloadedAssetPackSource? deactivateDownloadedSource,
  }) : assert(
         resolvePackSource == null ||
             (resolvePackFile == null && resolvePackRoot == null),
       ),
       _resolvePackSource = resolvePackSource,
       _deactivateDownloadedSource = deactivateDownloadedSource,
       _resolvePackFile =
           resolvePackFile ??
           (resolvePackRoot == null
               ? resolveAssetPackFile
               : (relativePath) async =>
                     '${await resolvePackRoot()}/$relativePath');

  final ResolveAssetPackFile _resolvePackFile;
  final ResolveAssetPackSource? _resolvePackSource;
  final DeactivateDownloadedAssetPackSource? _deactivateDownloadedSource;

  /// Ids whose SHA-256 has already been verified against the manifest during
  /// this repository instance's lifetime, keyed by
  /// `'<packVersion>:<assetId>'`.
  ///
  /// SHA-256 hashing streams the entire file (33-100MB for the base map
  /// pmtiles), so it runs at most **once per (packVersion, asset) per
  /// repository instance** — this is a deliberate once-per-session semantic.
  /// The cheap length check still runs on *every* [resolveAsset] call.
  final Set<String> _verifiedSha256Keys = <String>{};

  /// Reads and parses `manifest.json` from the Asset Pack root.
  Future<AssetPackManifest> readManifest() async {
    if (_resolvePackSource case final resolveSource?) {
      return withDownloadedAssetPackFallback(
        resolveSource: resolveSource,
        deactivateDownloadedSource: _deactivateDownloadedSource,
        verifiedSha256Keys: _verifiedSha256Keys,
        operation: (source) => readAssetPackManifestFile(
          File(p.join(source.rootDirectory.path, 'manifest.json')),
        ),
      );
    }
    final path = await _resolvePackFile('manifest.json');
    return readAssetPackManifestFile(File(path));
  }

  /// Resolves the absolute [File] for [id], as listed in `manifest.json`,
  /// verifying its integrity against the manifest before returning.
  ///
  /// Throws [AssetPackNotReadyException] if the manifest doesn't list [id],
  /// the resolved file is missing/empty on disk, its byte length doesn't
  /// match the manifest's `size_bytes`, or its SHA-256 doesn't match the
  /// manifest's `sha256`. For life-critical station data a partially
  /// corrupted (nonempty) file must fail loudly rather than pass through.
  ///
  /// Integrity checks are performance-tiered: the `size_bytes` length check
  /// (a cheap `stat`) runs on every call, while the SHA-256 check streams
  /// the whole file and therefore runs at most once per
  /// (`packVersion`, `id`) per repository instance (see
  /// [_verifiedSha256Keys]).
  Future<File> resolveAsset(AssetPackAssetId id) async {
    if (_resolvePackSource case final resolveSource?) {
      return withDownloadedAssetPackFallback(
        resolveSource: resolveSource,
        deactivateDownloadedSource: _deactivateDownloadedSource,
        verifiedSha256Keys: _verifiedSha256Keys,
        operation: (source) => resolveAssetPackAssetFromRoot(
          id: id,
          rootDirectory: source.rootDirectory,
          verifiedSha256Keys: _verifiedSha256Keys,
        ),
      );
    }
    final manifest = await readManifest();
    final item = manifest.findAsset(id);
    if (item == null) {
      throw AssetPackNotReadyException(
        'Asset Pack manifest does not contain required asset: $id',
      );
    }
    final file = File(await _resolvePackFile(item.path));
    return verifyResolvedAssetPackAsset(
      file: file,
      item: item,
      manifest: manifest,
      verifiedSha256Keys: _verifiedSha256Keys,
    );
  }
}

Future<AssetPackManifest> readAssetPackManifestFile(File file) async {
  if (!file.existsSync()) {
    throw AssetPackNotReadyException(
      'Asset Pack manifest.json not found at ${file.path}',
    );
  }
  final String raw;
  try {
    raw = await file.readAsString();
  } on Object catch (error) {
    throw AssetPackNotReadyException(
      'Failed to read Asset Pack manifest.json (${file.path}): $error',
    );
  }
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
        'Asset Pack manifest.json root must be an object',
      );
    }
    return AssetPackManifest.fromJson(decoded);
  } on Object catch (error) {
    throw AssetPackNotReadyException(
      'Invalid Asset Pack manifest.json (${file.path}): $error',
    );
  }
}

Future<File> resolveAssetPackAssetFromRoot({
  required AssetPackAssetId id,
  required Directory rootDirectory,
  required Set<String> verifiedSha256Keys,
}) async {
  final manifest = await readAssetPackManifestFile(
    File(p.join(rootDirectory.path, 'manifest.json')),
  );
  final item = manifest.findAsset(id);
  if (item == null) {
    throw AssetPackNotReadyException(
      'Asset Pack manifest does not contain required asset: $id',
    );
  }
  return verifyResolvedAssetPackAsset(
    file: File(p.join(rootDirectory.path, item.path)),
    item: item,
    manifest: manifest,
    verifiedSha256Keys: verifiedSha256Keys,
  );
}

Future<T> withDownloadedAssetPackFallback<T>({
  required ResolveAssetPackSource resolveSource,
  required DeactivateDownloadedAssetPackSource? deactivateDownloadedSource,
  required Set<String> verifiedSha256Keys,
  required Future<T> Function(AssetPackSource source) operation,
}) async {
  final source = await resolveSource();
  try {
    return await operation(source);
  } on AssetPackNotReadyException {
    if (source.kind != AssetPackSourceKind.downloaded ||
        deactivateDownloadedSource == null) {
      rethrow;
    }
    await deactivateDownloadedSource(source);
    final version = source.version;
    if (version != null) {
      verifiedSha256Keys.removeWhere((key) => key.startsWith('$version:'));
    }
    final fallback = await resolveSource();
    if (fallback.kind == AssetPackSourceKind.downloaded) {
      rethrow;
    }
    return operation(fallback);
  }
}

Future<File> verifyResolvedAssetPackAsset({
  required File file,
  required AssetPackManifestItem item,
  required AssetPackManifest manifest,
  required Set<String> verifiedSha256Keys,
}) async {
  final id = item.id;
  if (!file.existsSync()) {
    throw AssetPackNotReadyException('Asset file not found: ${file.path}');
  }
  final size = await file.length();
  if (size == 0) {
    throw AssetPackNotReadyException('Asset file is empty: ${file.path}');
  }
  if (size != item.sizeBytes) {
    throw AssetPackNotReadyException(
      'Asset size mismatch for $id (${file.path}): '
      'expected ${item.sizeBytes} bytes, got $size bytes',
    );
  }
  final sha256Key = '${manifest.packVersion}:${id.name}';
  if (!verifiedSha256Keys.contains(sha256Key)) {
    final digest = await sha256.bind(file.openRead()).first;
    final actual = digest.toString();
    if (actual != item.sha256) {
      throw AssetPackNotReadyException(
        'Asset sha256 mismatch for $id (${file.path}): '
        'expected ${item.sha256}, got $actual',
      );
    }
    verifiedSha256Keys.add(sha256Key);
  }
  return file;
}

Future<String> resolveAssetPackFile(String relativePath) =>
    AssetsUtil.resolvePackFile(relativePath: relativePath);
