import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_diagnostics.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/bundled_asset_pack_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_provider.g.dart';

/// 本番と同じ解決経路で、いま有効な Asset Pack の状態を読み出す。
@riverpod
Future<AssetPackDiagnostics> assetPackDiagnostics(Ref ref) async {
  final storage = await ref.watch(assetPackStorageRepositoryProvider.future);
  final source = await storage.resolveActiveSource();
  final manifest = await ref.watch(assetPackRepositoryProvider).readManifest();
  final bundledRootPath = await ref
      .watch(bundledAssetPackRepositoryProvider)
      .resolveRoot();
  return AssetPackDiagnostics(
    sourceKind: source.kind,
    rootPath: source.rootDirectory.path,
    bundledRootPath: bundledRootPath,
    manifest: manifest,
  );
}
