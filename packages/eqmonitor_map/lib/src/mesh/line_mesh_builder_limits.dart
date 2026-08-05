import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_mesh_builder_limits.freezed.dart';

/// `LineMeshBuilder`がmesh生成時に適用する上限値。呼び出し側が明示し、
/// builder内部に固定fallbackは置かない(`FillMeshBuilderLimits`と同じ運用方針。
/// `lib/src/mesh/fill_mesh_builder_limits.dart`参照)。
@freezed
abstract class LineMeshBuilderLimits with _$LineMeshBuilderLimits {
  const factory LineMeshBuilderLimits({
    /// 1つの`LineMesh` segmentに積める頂点数の上限。index bufferが
    /// `Uint16List`であるため、呼び出し側がこの値を65536以下に設定しない
    /// 場合`LineMeshBuilder`はArgumentErrorを投げる(index値がuint16の範囲を
    /// 静かに超えて壊れたmeshを生成することを避けるための防御)。
    required int maxVerticesPerSegment,
  }) = _LineMeshBuilderLimits;
}
