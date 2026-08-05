import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eqmonitor_map_debug_source_provider.g.dart';

/// このデバッグページ専用の手動配置override。実機・simulatorでAsset Pack
/// が未ダウンロードの端末でも、このpathへ手動でPMTilesファイルを置けば
/// `BaseMapView`の描画確認ができる。本番の`AssetPackRepository.resolveAsset`
/// を書き換えたり迂回したりはしない([_resolveDebugOverride]参照)。
const _debugOverrideRelativePath = 'eqmonitor_map_debug/base_map_debug.pmtiles';

/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([_resolveDebugOverride])を試し、それも無ければ例外をそのまま
/// 再送出する(brief要求「AssetPackNotReadyExceptionはエラー表示へ流し、
/// 地図を空で描かない」)。
@riverpod
Future<VerifiedPmTilesSource> eqmonitorMapDebugSource(Ref ref) async {
  final repository = ref.watch(assetPackRepositoryProvider);
  try {
    final file = await repository.resolveAsset(AssetPackAssetId.baseMapPmtiles);
    final manifest = await repository.readManifest();
    final item = manifest.findAsset(AssetPackAssetId.baseMapPmtiles);
    if (item == null) {
      // resolveAssetが例外を投げなかった以上、manifestは本来このIDを
      // 含んでいるはずである。防御的にAssetPackNotReadyExceptionへ寄せる。
      throw AssetPackNotReadyException(
        'Asset Pack manifest does not contain required asset: '
        '${AssetPackAssetId.baseMapPmtiles}',
      );
    }
    return VerifiedPmTilesSource(
      sourceInstanceId: item.sha256,
      absolutePath: file.path,
      sizeBytes: item.sizeBytes,
      sha256: item.sha256,
    );
  } on AssetPackNotReadyException {
    final override = await _resolveDebugOverride();
    if (override != null) {
      return override;
    }
    rethrow;
  }
}

/// [_debugOverrideRelativePath]に手動配置されたファイルがあれば、それを
/// 検証済み[VerifiedPmTilesSource]として返す。sha256/sizeBytesは実ファイル
/// から都度計算する(manifestを経由しないため、Asset Packの検証契約とは
/// 独立)。ファイルが無ければ`null`を返すだけで、それ自体はエラーにしない
/// (呼び出し側が元の[AssetPackNotReadyException]を再送出する)。
Future<VerifiedPmTilesSource?> _resolveDebugOverride() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final file = File('${documentsDirectory.path}/$_debugOverrideRelativePath');
  if (!file.existsSync()) {
    return null;
  }
  final sizeBytes = await file.length();
  if (sizeBytes == 0) {
    return null;
  }
  final digest = await sha256.bind(file.openRead()).first;
  return VerifiedPmTilesSource(
    sourceInstanceId: 'eqmonitor_map_debug_override:$digest',
    absolutePath: file.path,
    sizeBytes: sizeBytes,
    sha256: digest.toString(),
  );
}
