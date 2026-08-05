import 'dart:typed_data';

/// Lineレイヤー1 segment分の描画用メッシュ。中心線の各頂点へ押し出し法線を
/// 持たせるだけで、実際の線幅ぶんの押し出しはshader側の頂点シェーダーが担う
/// (docs/knowledge/20260805_maplibre_native_renderer_reference.md
/// 「Line頂点生成」「Line shader」節。MapLibreの
/// `gl_Position = u_matrix * vec4(pos, 0, 1) + u_matrix * vec4(extrude, 0, 0)`
/// と同じ、変換後に押し出しを加算する構成を想定する)。
///
/// index bufferが[Uint16List]であるため、1つの[LineMesh]に含められる頂点は
/// `FillMesh`と同じく高々65536個(index値0〜65535)に制限される。1回のbuild
/// 呼び出しがこの上限を超えるfeature群を渡された場合、`LineMeshBuilder`は
/// 複数の[LineMesh](segment)へ分割して返す。
final class LineMesh {
  const LineMesh({
    required this.positions,
    required this.extrudes,
    required this.indices,
    required this.vertexCount,
  });

  /// tile-local座標のx, yを交互に詰めたfloat32頂点列。中心線上の座標であり、
  /// 押し出し済みの座標ではない。[extrudes]と同じ頂点index同士が対応する。
  final Float32List positions;

  /// [positions]と同じ頂点indexに対応する押し出し法線のx, yを交互に詰めた
  /// float32列。
  ///
  /// 直線部分とcap(線の端点)では単位法線(長さ1、線に直交)である。miter
  /// join部分では`joinNormal * miterLength`(miter limitでclampされた値)を
  /// 格納するため、その頂点では長さ1でもどちらの隣接segmentにも直交しない
  /// (`LineMeshBuilder`のdoc comment参照)。shaderはこの値をそのまま線幅の
  /// 半分に掛けて`position + extrude * halfWidth`のように中心線から押し出す
  /// 想定であり、miter joinの伸長分もこの1本の値で表現される。
  ///
  /// GPUへは`BaseMapGeometryFactory.lineGeometry`が`MeshGeometry.fromArrays`
  /// の`texCoords`引数として渡す(custom attributeの不具合回避。詳細は
  /// `base_map_geometry_factory.dart`のdoc comment参照)。
  final Float32List extrudes;

  /// 3個1組でtriangleを表すindex buffer。[positions]内の頂点index
  /// (0-based)を指す。triangle stripではなく明示的なtriangle listである。
  final Uint16List indices;

  /// [positions]に含まれる頂点数(`positions.length ~/ 2`と一致する)。
  final int vertexCount;
}
