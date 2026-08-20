import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';

/// [packBaseMapFillMesh]/[packBaseMapLineMesh]が出力する[MapPackedMesh]の
/// payload version。
///
/// layoutのversionと分けているのは、layout(頂点の並び)を変えずに詰め方の
/// 規約だけを変える改訂(例: index bufferのbit幅拡張、押し出し法線の座標系
/// 変更)を区別できるようにするため。`MapRenderBatch`のbatch互換判定は
/// layoutとpayload versionの両方を見る
/// (`map_render_batch.dart`の`_haveCompatibleMapRenderBatchProperties`)。
const baseMapPackedMeshPayloadVersion = 1;

/// Fill layerのpacked mesh layout。
///
/// 頂点はtile-local座標2成分だけを持つ。設計正本
/// (`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md`
/// 「Fill/Lineの頂点仕様」)が「Fillはtile-local座標だけを持つ頂点と、穴込み
/// earcutの三角形indexで構成する。法線とUVを持たせない」と定めているため、
/// これ以上の属性を持たせない。
///
/// z成分を持たないのは[FillMesh]が2成分しか持たないためである。Flutter Scene
/// の`MeshGeometry.fromArrays`は3成分positionを要求するが、それはadapter側の
/// 制約であり、packed mesh(Scene非依存のGPU転送contract)へは漏らさない
/// (`flutter_scene/`のadapterがz=0を埋める)。
final MapPackedMeshLayout baseMapFillPackedMeshLayout =
    createMapPackedMeshLayout(
  version: 1,
  topology: MapPrimitiveTopology.triangleList,
  byteOrder: MapPackedByteOrder.little,
  vertexStride: 8,
  attributes: [
    MapVertexAttributeLayout(
      semantic: MapVertexAttributeSemantic.position2D,
      format: MapVertexAttributeFormat.float32x2,
      offset: 0,
    ),
  ],
  indexFormat: MapIndexFormat.uint16,
);

/// Line layerのpacked mesh layout。
///
/// 中心線のtile-local座標に押し出し法線を並べたinterleaved layout。
/// `float32`で持つのは設計正本「初期実装の頂点属性はfloat32とする」に従う
/// (MapLibreの6 byte packingは`gpu.VertexFormat`のint16/uint8正規化対応を
/// 実機検証できるまで採用しない)。
///
/// [MapVertexAttributeSemantic.lineExtrude2D]の値は**clip/NDC Y-up座標系**の
/// 押し出し法線と定義する。[LineMesh.extrudes]はtile-local Y-down座標系なので、
/// [packBaseMapLineMesh]がY成分を反転してからここへ詰める。座標系の変換を
/// adapterではなくpackerへ置いたのは、adapterを「packed byteをそのままGPUへ
/// 載せるだけ」の境界に保つため(#1593以前はこのY反転をFlutter Scene側の
/// geometry factoryが行っていた)。
final MapPackedMeshLayout baseMapLinePackedMeshLayout =
    createMapPackedMeshLayout(
  version: 1,
  topology: MapPrimitiveTopology.triangleList,
  byteOrder: MapPackedByteOrder.little,
  vertexStride: 16,
  attributes: [
    MapVertexAttributeLayout(
      semantic: MapVertexAttributeSemantic.position2D,
      format: MapVertexAttributeFormat.float32x2,
      offset: 0,
    ),
    MapVertexAttributeLayout(
      semantic: MapVertexAttributeSemantic.lineExtrude2D,
      format: MapVertexAttributeFormat.float32x2,
      offset: 8,
    ),
  ],
  indexFormat: MapIndexFormat.uint16,
);

/// [FillMesh]を[baseMapFillPackedMeshLayout]のbyte列へ詰める。
///
/// tileごとに1回だけ呼び、結果は`BaseMapPackedMeshCache`が保持する
/// (毎frame詰め直さない)。UI isolateで実行するが、`BaseMapTileDecoder`の
/// 実測(realistic tileで出力payload約112KB)に照らして`Isolate`越しの
/// packed payload化は不要と判断済みである
/// (`docs/todo/840_eqmonitor_map_packed_worker_payload.md`)。
MapPackedMesh packBaseMapFillMesh(FillMesh mesh) {
  _validateMeshShape(
    positions: mesh.positions,
    indices: mesh.indices,
    vertexCount: mesh.vertexCount,
  );

  final vertexBytes = Uint8List(mesh.vertexCount * 8);
  final vertices = _littleEndianFloat32View(vertexBytes);
  vertices.setAll(0, mesh.positions);

  return createMapPackedMesh(
    payloadVersion: baseMapPackedMeshPayloadVersion,
    layout: baseMapFillPackedMeshLayout,
    vertexBytes: vertexBytes,
    vertexCount: mesh.vertexCount,
    indexBytes: _packUint16Indices(mesh.indices),
    indexCount: mesh.indices.length,
  );
}

/// [LineMesh]を[baseMapLinePackedMeshLayout]のbyte列へ詰める。
///
/// [LineMesh.extrudes]のY成分を反転し、tile-local Y-downからclip/NDC Y-upへ
/// 揃える([baseMapLinePackedMeshLayout]のdoc comment参照)。miter joinの頂点は
/// 単位法線ではなく`joinNormal * miterLength`を保持するため、符号だけを変えて
/// 長さは正規化しない。
MapPackedMesh packBaseMapLineMesh(LineMesh mesh) {
  _validateMeshShape(
    positions: mesh.positions,
    indices: mesh.indices,
    vertexCount: mesh.vertexCount,
  );
  if (mesh.extrudes.length != mesh.positions.length) {
    throw ArgumentError.value(
      mesh.extrudes.length,
      'extrudes',
      'must have one 2D normal per position',
    );
  }

  final vertexBytes = Uint8List(mesh.vertexCount * 16);
  final vertices = _littleEndianFloat32View(vertexBytes);
  for (var vertex = 0; vertex < mesh.vertexCount; vertex++) {
    final source = vertex * 2;
    final target = vertex * 4;
    vertices[target] = mesh.positions[source];
    vertices[target + 1] = mesh.positions[source + 1];
    vertices[target + 2] = mesh.extrudes[source];
    vertices[target + 3] = -mesh.extrudes[source + 1];
  }

  return createMapPackedMesh(
    payloadVersion: baseMapPackedMeshPayloadVersion,
    layout: baseMapLinePackedMeshLayout,
    vertexBytes: vertexBytes,
    vertexCount: mesh.vertexCount,
    indexBytes: _packUint16Indices(mesh.indices),
    indexCount: mesh.indices.length,
  );
}

/// 空mesh・件数不整合・範囲外indexを`ArgumentError`で拒否する。
///
/// 空meshを0頂点のpayloadへ丸めないのは、呼び出し側(render plan builder)が
/// 「meshが空のlayerはそもそもplanへ入れない」契約を持っており
/// (`base_map_render_plan_builder.dart`の`meshes.isEmpty`の早期continue)、
/// ここへ空meshが来ることは配線バグを意味するため。
void _validateMeshShape({
  required Float32List positions,
  required Uint16List indices,
  required int vertexCount,
}) {
  if (vertexCount <= 0) {
    throw ArgumentError.value(vertexCount, 'vertexCount', 'must be positive');
  }
  if (positions.length != vertexCount * 2) {
    throw ArgumentError.value(
      positions.length,
      'positions',
      'must hold exactly two components per vertex',
    );
  }
  if (indices.isEmpty || indices.length % 3 != 0) {
    throw ArgumentError.value(
      indices.length,
      'indices',
      'must be a non-empty multiple of three (triangle list)',
    );
  }
  for (final index in indices) {
    if (index >= vertexCount) {
      throw ArgumentError.value(
        index,
        'indices',
        'must point inside the vertex range',
      );
    }
  }
}

Uint8List _packUint16Indices(Uint16List indices) {
  final indexBytes = Uint8List(indices.length * 2);
  Uint16List.view(indexBytes.buffer).setAll(0, indices);
  return indexBytes;
}

/// [bytes]をfloat32列として書き込むためのview。
///
/// `Float32List.view`はhost byte orderで解釈するため、layoutが宣言する
/// [MapPackedByteOrder.little]と一致するのはlittle-endian hostに限られる。
/// iOS/AndroidのARM/x86はすべてlittle-endianだが、宣言と実際のbyte列が
/// 食い違うくらいならfail closedにする(`ByteData.setFloat32`で明示的に
/// little-endian書き込みするより桁違いに速く、tileあたり数万頂点の
/// 詰め替えが1回のメモリコピーで済む)。
Float32List _littleEndianFloat32View(Uint8List bytes) {
  if (Endian.host != Endian.little) {
    throw UnsupportedError(
      'Base map packed meshes declare little-endian byte order, but this host '
      'is big-endian.',
    );
  }
  return Float32List.view(bytes.buffer);
}
