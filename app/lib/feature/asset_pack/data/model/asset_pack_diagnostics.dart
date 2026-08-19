import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_storage_repository.dart';

/// デバッグ画面向けに、いま実際に読まれている Asset Pack の実測値を束ねたもの。
///
/// すべて `AssetPackStorageRepository` / `AssetPackRepository` が本番と同じ
/// 経路で解決した結果であり、表示のために別経路で推測した値は含まない。
class AssetPackDiagnostics {
  const new({
    required this.sourceKind,
    required this.rootPath,
    required this.bundledRootPath,
    required this.manifest,
  });

  /// いま有効な Pack が同梱版か、R2 からのダウンロード版か。
  final AssetPackSourceKind sourceKind;

  /// 有効な Pack ルートの絶対パス。
  final String rootPath;

  /// 同梱 Pack の展開先。[sourceKind] がダウンロード版のときの復帰先でもある。
  final String bundledRootPath;

  /// 有効な Pack の `manifest.json`。
  final AssetPackManifest manifest;
}
