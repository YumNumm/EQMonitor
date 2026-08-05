import 'package:freezed_annotation/freezed_annotation.dart';

part 'verified_pm_tiles_source.freezed.dart';

/// appが検証済みのPMTiles archiveをpackageへ渡すための契約。
///
/// `eqmonitor_map`は`app`に依存せず、Asset Pack APIやmanifestも知らない
/// (Global Constraints参照)。そのため、絶対path・サイズ・digestの正しさは
/// **呼び出し側(app)が既に検証済みである**ことを前提とし、この値をpackage側
/// では再検証しない。`BaseMapTileRepository`は[absolutePath]をそのまま
/// ファイルとして開くだけで、[sizeBytes]/[sha256]を実ファイルと突き合わせる
/// チェックは行わない。
///
/// [sourceInstanceId]はarchiveの実体(同一pathでも中身が更新された別の
/// downloadなど)を区別するための識別子。`BaseMapTileCache`のcache keyの
/// 一部として使い、archiveが差し替わった際に古いtileのcacheを暗黙に無効化
/// する目的だけに使う(値そのものの生成規則はappが決める)。
@freezed
abstract class VerifiedPmTilesSource with _$VerifiedPmTilesSource {
  const factory VerifiedPmTilesSource({
    required String sourceInstanceId,
    required String absolutePath,
    required int sizeBytes,
    required String sha256,
  }) = _VerifiedPmTilesSource;
}
