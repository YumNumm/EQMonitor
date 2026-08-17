import 'package:freezed_annotation/freezed_annotation.dart';

part 'fill_mesh_build_exception.freezed.dart';

/// `FillMeshBuilder`がfill頂点生成に失敗した場合の例外。
///
/// `MvtFeature.rings`はPMTiles archiveから取得したuntrusted dataをdecodeした
/// 結果であり、壊れた・仕様違反の入力を空meshへ丸めず必ずこの型で失敗させる
/// (`lib/src/tile/mvt/mvt_decode_exception.dart`と同じ運用方針)。
/// fail-openのfallbackは置かない。
@freezed
sealed class FillMeshBuildException
    with _$FillMeshBuildException
    implements Exception {
  /// ringの頂点数が3未満、またはshoelace公式による符号付き面積が0の場合。
  /// MVT仕様上、面のないringは外形にも穴にもなり得ない。
  const factory degenerateRing({
    required String reason,
  }) = FillMeshDegenerateRingException;

  /// 穴(shoelace符号が負のring)が、それを内包する外形より前に現れた場合。
  /// MVT仕様は「最初のringは必ず外形」と定めており、これに反する並びは
  /// classifyRingsが復元不能なため受理しない。
  const factory holeBeforeExterior({
    required String reason,
  }) = FillMeshHoleBeforeExteriorException;

  /// 呼び出し側が渡した`FillMeshBuilderLimits`を超過した場合
  /// (穴数超過、feature内頂点数超過、1つのfeatureがsegment容量に収まらない
  /// など)。
  const factory limitExceeded({
    required String reason,
  }) = FillMeshLimitExceededException;
}
