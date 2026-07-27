import 'dart:convert';
import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:crypto/crypto.dart';
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

  /// Ids whose SHA-256 has already been verified against the manifest during
  /// this repository instance's lifetime, keyed by
  /// `'<packVersion>:<assetId>'`.
  ///
  /// SHA-256 hashing streams the entire file (33-100MB for the base map
  /// pmtiles), so it runs at most **once per (packVersion, asset) per
  /// repository instance** — this is a deliberate once-per-session semantic.
  /// The cheap length check still runs on *every* [resolveAsset] call.
  final Set<String> _verifiedSha256Keys = <String>{};

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
    // Always verify the (cheap) length against the manifest.
    if (size != item.sizeBytes) {
      throw AssetPackNotReadyException(
        'Asset size mismatch for $id (${file.path}): '
        'expected ${item.sizeBytes} bytes, got $size bytes',
      );
    }
    // Verify the (expensive) SHA-256 at most once per session per asset.
    final sha256Key = '${manifest.packVersion}:${id.name}';
    if (!_verifiedSha256Keys.contains(sha256Key)) {
      final digest = await sha256.bind(file.openRead()).first;
      final actual = digest.toString();
      if (actual != item.sha256) {
        throw AssetPackNotReadyException(
          'Asset sha256 mismatch for $id (${file.path}): '
          'expected ${item.sha256}, got $actual',
        );
      }
      _verifiedSha256Keys.add(sha256Key);
    }
    return file;
  }
}
