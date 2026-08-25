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

/// [eqmonitorMapDebugSourceProvider]の結果。[minZoom]/[maxZoom]は
/// [source]が指すarchiveの`PmTilesV3Header`をそのまま読んだ実測値であり、
/// 生成scriptの既定値などを転記した固定値ではない([_readHeader]参照)。
/// `BaseMapView`の公開引数(`source`/`initialCamera`/`limits`のみ)は
/// 変更しないため、`MapBaseLayerLimits`はデバッグページ側でこの結果から
/// 組み立てる。
typedef EqmonitorMapDebugSource = ({
  VerifiedPmTilesSource source,
  int minZoom,
  int maxZoom,
});

/// デバッグページが`BaseMapView`へ渡す[VerifiedPmTilesSource]と、その
/// archiveの実際のzoom範囲を組み立てる。
///
/// 通常は`AssetPackRepository.resolveAsset(AssetPackAssetId.baseMapPmtiles)`
/// が返す検証済み`File`をそのまま使う。Asset Packが未準備
/// ([AssetPackNotReadyException])の場合だけ、このデバッグページに限定した
/// override([EqmonitorMapDebugSourceResolver.resolveDebugOverride])を試し、
/// それも無ければ例外をそのまま再送出する(brief要求
/// 「AssetPackNotReadyExceptionはエラー表示へ流し、地図を空で描かない」)。
@riverpod
Future<EqmonitorMapDebugSource> eqmonitorMapDebugSource(Ref ref) async {
  final repository = ref.watch(assetPackRepositoryProvider);
  const resolver = EqmonitorMapDebugSourceResolver();
  final source = await resolver.resolveSource(repository);
  final header = await resolver.readHeader(source);
  return (source: source, minZoom: header.minZoom, maxZoom: header.maxZoom);
}

/// [eqmonitorMapDebugSourceProvider]が使う解決ロジック本体。
class EqmonitorMapDebugSourceResolver {
  const new();

  Future<VerifiedPmTilesSource> resolveSource(
    AssetPackRepository repository,
  ) async {
    try {
      final file = await repository.resolveAsset(
        AssetPackAssetId.baseMapPmtiles,
      );
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
      final override = await resolveDebugOverride();
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
  Future<VerifiedPmTilesSource?> resolveDebugOverride() async {
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

  /// [source]が指すarchiveを開いて`PmTilesV3Header`を読み、すぐ閉じる。
  ///
  /// `BaseMapView`は内部で`BaseMapTileRepository`が同じarchiveを別途開くため、
  /// このpeekと合わせて同じファイルを2回開くことになるが、読み取り専用の
  /// random accessであり競合しない。zoom範囲をtippecanoeの生成条件など
  /// 別ファイルの既定値から転記して実際のarchiveと食い違わせるより、実測の
  /// header値を都度読む方を優先する。
  Future<PmTilesV3Header> readHeader(VerifiedPmTilesSource source) async {
    final reader = await PmTilesV3FileRandomAccessReader.open(
      path: source.absolutePath,
    );
    final archive = await PmTilesV3Archive.open(
      reader: reader,
      limits: const PmTilesV3Limits(
        maxDirectoryDepth: 3,
        rootDirectoryWindowLength: 16384,
        // 実archiveの分布値ではなく、未知の既存base mapとの互換性を保つ
        // 暫定worst-case allocation policy。event sourceは別の厳格値を持つ。
        maxDirectoryEncodedBytes: 1 << 20,
        maxDirectoryDecodedBytes: 8 << 20,
        maxTileEncodedBytes: 4 << 20,
        maxTileDecodedBytes: 16 << 20,
      ),
    );
    try {
      return archive.header;
    } finally {
      await archive.close();
    }
  }
}
