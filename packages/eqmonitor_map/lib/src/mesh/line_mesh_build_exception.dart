import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_mesh_build_exception.freezed.dart';

/// `LineMeshBuilder`がline頂点生成に失敗した場合の例外。
///
/// `MvtFeature.rings`はPMTiles archiveから取得したuntrusted dataをdecodeした
/// 結果であり、壊れた・仕様違反の入力を空meshへ丸めず必ずこの型で失敗させる
/// (`FillMeshBuildException`と同じ運用方針。
/// `lib/src/mesh/fill_mesh_build_exception.dart`参照)。fail-openのfallbackは
/// 置かない。
///
/// ring自体が短すぎる場合(dedup後に頂点2未満)は例外ではなく、そのringを
/// meshへ出さずskipする仕様(brief記載)であるため、`FillMeshBuildException`の
/// `degenerateRing`に相当するvariantはここには存在しない。
@freezed
sealed class LineMeshBuildException
    with _$LineMeshBuildException
    implements Exception {
  /// 呼び出し側が渡した`LineMeshBuilderLimits`を超過した場合(1つのfeatureが
  /// 単独でsegment容量に収まらない場合)。
  const factory limitExceeded({
    required String reason,
  }) = LineMeshLimitExceededException;
}
