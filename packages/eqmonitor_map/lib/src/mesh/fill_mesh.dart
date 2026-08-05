import 'dart:typed_data';

/// Fillレイヤー1 segment分の描画用メッシュ。
///
/// index bufferが[Uint16List]であるため、1つの[FillMesh]に含められる頂点は
/// 高々65536個(index値0〜65535)に制限される。1回のbuild呼び出しがこの上限を
/// 超えるfeature群を渡された場合、`FillMeshBuilder`は複数の[FillMesh]
/// (segment)へ分割して返す
/// (docs/knowledge/20260805_maplibre_native_renderer_reference.md
/// 「Fill頂点生成」節)。
final class FillMesh {
  const FillMesh({
    required this.positions,
    required this.indices,
    required this.vertexCount,
  });

  /// tile-local座標のx, yを交互に詰めたfloat32頂点列。法線・UVは持たない。
  /// fillの描画は`gl_Position = u_matrix * vec4(a_pos, 0, 1)`という行列積
  /// だけで完結し、複雑さはすべてこのbuffer生成側に押し込む設計であるため、
  /// これ以上の属性を頂点へ足さない。
  ///
  /// MVT extent外(負値やbuffer領域で宣言されたextentを超える座標)の頂点も
  /// 落とさずそのまま含む。tile境界のclipは描画側のscissorが担当する。
  final Float32List positions;

  /// 3個1組でtriangleを表すindex buffer。[positions]内の頂点index
  /// (0-based)を指す。
  final Uint16List indices;

  /// [positions]に含まれる頂点数(`positions.length ~/ 2`と一致する)。
  final int vertexCount;
}
