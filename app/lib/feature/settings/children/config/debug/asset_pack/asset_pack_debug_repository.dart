import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_repository.g.dart';

typedef DiagnoseAssetPack = Future<AssetPackDiagnostics> Function();

@riverpod
AssetPackDebugRepository assetPackDebugRepository(Ref ref) =>
    AssetPackDebugRepository();

class AssetPackAssetFileStatus {
  const AssetPackAssetFileStatus({
    required this.diagnostic,
    required this.item,
  });

  final AssetPackFileDiagnostic diagnostic;
  final AssetPackManifestItem? item;
}

class AssetPackDebugInfo {
  const AssetPackDebugInfo({
    required this.diagnostics,
    required this.manifest,
    required this.manifestParseError,
    required this.assets,
  });

  final AssetPackDiagnostics diagnostics;
  final AssetPackManifest? manifest;
  final String? manifestParseError;
  final List<AssetPackAssetFileStatus> assets;
}

class AssetPackDebugRepository {
  AssetPackDebugRepository({DiagnoseAssetPack? diagnosePack})
    : diagnosePack = diagnosePack ?? AssetsUtil.diagnosePack;

  final DiagnoseAssetPack diagnosePack;

  Future<AssetPackDebugInfo> diagnose() async {
    final diagnostics = await diagnosePack();
    AssetPackManifest? manifest;
    String? manifestParseError;
    final manifestJson = diagnostics.manifestJson;
    if (manifestJson != null) {
      try {
        manifest = AssetPackManifest.fromJson(manifestJson);
      } on FormatException catch (error) {
        manifestParseError = error.message.toString();
      }
    }

    final assets = diagnostics.assets
        .map((diagnostic) {
          AssetPackManifestItem? item;
          final manifestAssets =
              manifest?.assets ?? const <AssetPackManifestItem>[];
          for (final candidate in manifestAssets) {
            if (candidate.path == diagnostic.path) {
              item = candidate;
              break;
            }
          }
          return AssetPackAssetFileStatus(diagnostic: diagnostic, item: item);
        })
        .toList(growable: false);

    return AssetPackDebugInfo(
      diagnostics: diagnostics,
      manifest: manifest,
      manifestParseError: manifestParseError,
      assets: assets,
    );
  }
}
