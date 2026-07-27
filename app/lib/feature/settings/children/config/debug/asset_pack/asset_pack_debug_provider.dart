import 'dart:io';

import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_provider.g.dart';

/// On-device status of a single Asset Pack asset, comparing the manifest entry
/// against the actual file on disk.
class AssetPackAssetFileStatus {
  const AssetPackAssetFileStatus({
    required this.item,
    required this.absolutePath,
    required this.exists,
    required this.actualSizeBytes,
  });

  final AssetPackManifestItem item;
  final String absolutePath;
  final bool exists;

  /// Actual byte length on disk, or `null` when the file is missing.
  final int? actualSizeBytes;

  /// Whether the on-device file matches the manifest's `size_bytes`.
  bool get sizeMatches => exists && actualSizeBytes == item.sizeBytes;
}

/// Aggregated Asset Pack state for the debug page: the resolved pack root, the
/// parsed manifest, and per-asset on-device file status.
class AssetPackDebugInfo {
  const AssetPackDebugInfo({
    required this.packRoot,
    required this.manifest,
    required this.assets,
  });

  final String packRoot;
  final AssetPackManifest manifest;
  final List<AssetPackAssetFileStatus> assets;
}

/// Builds [AssetPackDebugInfo] for the Asset Pack debug page.
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when the
/// pack is unavailable; the debug page renders the exception message in that
/// case rather than treating it as a fatal error.
@riverpod
Future<AssetPackDebugInfo> assetPackDebugInfo(Ref ref) async {
  final packRoot = await AssetsUtil.resolvePackRoot();
  final repository = ref.watch(assetPackRepositoryProvider);
  final manifest = await repository.readManifest();

  final assets = <AssetPackAssetFileStatus>[];
  for (final item in manifest.assets) {
    final file = File('$packRoot/${item.path}');
    final exists = file.existsSync();
    assets.add(
      AssetPackAssetFileStatus(
        item: item,
        absolutePath: file.path,
        exists: exists,
        actualSizeBytes: exists ? await file.length() : null,
      ),
    );
  }

  return AssetPackDebugInfo(
    packRoot: packRoot,
    manifest: manifest,
    assets: assets,
  );
}
