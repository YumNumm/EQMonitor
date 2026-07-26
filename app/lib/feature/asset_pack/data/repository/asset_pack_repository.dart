import 'dart:convert';
import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'package:assets_util/assets_util.dart' show AssetPackNotReadyException;

part 'asset_pack_repository.g.dart';

@Riverpod(keepAlive: true)
AssetPackRepository assetPackRepository(Ref ref) => AssetPackRepository();

/// Reads `manifest.json` and individual assets from the platform-managed
/// Asset Pack root (see [AssetsUtil.resolvePackRoot]).
///
/// This is the **sole** source of parameter/map data: there is no
/// fake-data or bundled-asset fallback. If the pack isn't downloaded yet,
/// is missing `manifest.json`, or the manifest/asset files are
/// missing/corrupt, every method here throws [AssetPackNotReadyException]
/// so callers surface it (typically as `AsyncError`) instead of silently
/// substituting stale/fake content.
class AssetPackRepository {
  AssetPackRepository({Future<String> Function()? resolvePackRoot})
    : _resolvePackRoot = resolvePackRoot ?? AssetsUtil.resolvePackRoot;

  /// DI seam so tests can simulate pack-ready (return a temp dir path) or
  /// pack-not-ready (throw [AssetPackNotReadyException]) without touching
  /// platform channels.
  final Future<String> Function() _resolvePackRoot;

  Future<Directory> _packRootDirectory() async {
    final root = await _resolvePackRoot();
    return Directory(root);
  }

  File _manifestFile(Directory root) => File('${root.path}/manifest.json');

  Future<AssetPackManifest> _readManifestFrom(Directory root) async {
    final file = _manifestFile(root);
    if (!file.existsSync()) {
      throw AssetPackNotReadyException(
        'Asset Pack manifest.json not found at ${file.path}',
      );
    }
    final String raw;
    try {
      raw = await file.readAsString();
    } on Object catch (e) {
      throw AssetPackNotReadyException(
        'Failed to read Asset Pack manifest.json (${file.path}): $e',
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
    } on Object catch (e) {
      throw AssetPackNotReadyException(
        'Invalid Asset Pack manifest.json (${file.path}): $e',
      );
    }
  }

  /// Reads and parses `manifest.json` from the Asset Pack root.
  Future<AssetPackManifest> readManifest() async {
    final root = await _packRootDirectory();
    return _readManifestFrom(root);
  }

  /// Resolves the absolute [File] for [id], as listed in `manifest.json`.
  ///
  /// Throws [AssetPackNotReadyException] if the manifest doesn't list
  /// [id], or the resolved file is missing or empty on disk.
  Future<File> resolveAsset(AssetPackAssetId id) async {
    final root = await _packRootDirectory();
    final manifest = await _readManifestFrom(root);
    final item = manifest.findAsset(id);
    if (item == null) {
      throw AssetPackNotReadyException(
        'Asset Pack manifest does not contain required asset: $id',
      );
    }
    final file = File('${root.path}/${item.path}');
    if (!file.existsSync()) {
      throw AssetPackNotReadyException('Asset file not found: ${file.path}');
    }
    final size = await file.length();
    if (size == 0) {
      throw AssetPackNotReadyException('Asset file is empty: ${file.path}');
    }
    return file;
  }
}
