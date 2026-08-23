import 'dart:typed_data';

import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/renderer/base_map_render_submission_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/scene.dart' as scene;
import 'package:vector_math/vector_math.dart' as scene_math;

/// [MapPackedMesh]から`MeshGeometry.fromArrays`へ渡す引数。
///
/// GPU呼び出しを含まないため、GPU初期化なしのunit testで検証できる
/// (GPU初期化を要する呼び出しの直前までをpure関数にする、というこのpackage
/// 既存の方針に従う)。
@immutable
final class BaseMapSceneGeometryArgs {
  const new({
    required this.positions,
    required this.indices,
    required this.extrudes,
  });

  /// tile-local座標を3成分(x, y, 0)へ展開したfloat32頂点列。
  ///
  /// packed meshは2成分しか持たない([baseMapFillPackedMeshLayout]のdoc
  /// comment参照)。3成分positionはFlutter Sceneの`MeshGeometry.fromArrays`
  /// 側の制約なので、z=0の埋めはこのadapter層だけで行う。
  final Float32List positions;

  final Uint16List indices;

  /// clip/NDC Y-up済みの押し出し法線。Fillはnull。
  ///
  /// `MeshGeometry.fromArrays`の組み込み`texCoords`(`vec2`)へ渡す。UVではなく
  /// 押し出し法線を運ぶという意味論の逸脱があるが、`setCustomAttribute`経由の
  /// custom vertex attributeは値がshaderへ届かず同じ頂点の`position`が読まれる
  /// 不具合を実機で確認したため使わない(経緯は
  /// `docs/todo/800_eqmonitor_map_deferred_verification.md`)。
  final Float32List? extrudes;
}

/// [mesh]のpacked byteを`MeshGeometry.fromArrays`の引数へ解く。
///
/// pack→unpackの往復は無駄に見えるが、これはpacked meshを
/// 「Scene非依存のGPU転送contract」に保つための代償である。`fromArrays`が
/// structure-of-arraysしか受け取らないため、interleaved bufferをそのまま
/// 渡せない(flutter_sceneがraw vertex bufferを受け取るAPIを持ったら、この
/// 関数ごと不要になる)。解く回数はmesh 1つにつき1回だけであり、結果の
/// `MeshGeometry`はsingle Scene adapterがpacked mesh identityで保持する。
BaseMapSceneGeometryArgs unpackBaseMapSceneGeometryArgs(MapPackedMesh mesh) {
  final layout = mesh.layout;
  final isFill = haveCompatibleMapPackedMeshLayouts(
    layout,
    baseMapFillPackedMeshLayout,
  );
  final isLine = haveCompatibleMapPackedMeshLayouts(
    layout,
    baseMapLinePackedMeshLayout,
  );
  if (!isFill && !isLine) {
    throw ArgumentError.value(
      layout.vertexStride,
      'mesh',
      'is neither a base map fill nor a base map line layout',
    );
  }
  final indexBytes = mesh.indexBytes;
  final indexCount = mesh.indexCount;
  if (indexBytes == null || indexCount == null) {
    // layout互換性がuint16 indexを含み、`createMapPackedMesh`が
    // 「indexFormatがあるならindexBytes/indexCountも必須」を検証済みなので、
    // ここへは到達しない。将来index無しのlayoutを足したときに気付けるよう
    // 空描画へ丸めずStateErrorにする。
    throw StateError('A base map packed mesh must carry an index buffer.');
  }

  final vertices = ByteData.sublistView(mesh.vertexBytes);
  final positions = Float32List(mesh.vertexCount * 3);
  final extrudes = isLine ? Float32List(mesh.vertexCount * 2) : null;
  for (var vertex = 0; vertex < mesh.vertexCount; vertex++) {
    final offset = vertex * layout.vertexStride;
    positions[vertex * 3] = vertices.getFloat32(offset, Endian.little);
    positions[vertex * 3 + 1] = vertices.getFloat32(offset + 4, Endian.little);
    // positions[vertex * 3 + 2]はFloat32Listの既定値0のまま。
    if (extrudes != null) {
      extrudes[vertex * 2] = vertices.getFloat32(offset + 8, Endian.little);
      extrudes[vertex * 2 + 1] = vertices.getFloat32(
        offset + 12,
        Endian.little,
      );
    }
  }

  final indices = Uint16List(indexCount);
  final indexData = ByteData.sublistView(indexBytes);
  for (var index = 0; index < indexCount; index++) {
    indices[index] = indexData.getUint16(index * 2, Endian.little);
  }

  return BaseMapSceneGeometryArgs(
    positions: positions,
    indices: indices,
    extrudes: extrudes,
  );
}

/// uniform blockのbyte列を[material]のparameterへ適用する。
///
/// pipeline keyでfill/lineを判別し、それぞれの`.fmat`が宣言している
/// parameter名へ書く。byte長が合わなければ
/// [decodeBaseMapFillMaterialBytes]/[decodeBaseMapLineMaterialBytes]が
/// `ArgumentError`を投げるため、pipelineとuniformの対応が崩れたまま
/// 静かに誤った値をshaderへ渡すことはない。
void applyBaseMapMaterialParameters({
  required scene.PreprocessedMaterial material,
  required String pipelineKey,
  required Uint8List bytes,
}) {
  if (pipelineKey == baseMapFillPipelineKey.key) {
    final values = decodeBaseMapFillMaterialBytes(bytes);
    material.parameters.setColor('fill_color', values.color);
    return;
  }
  if (pipelineKey == baseMapLinePipelineKey.key) {
    final values = decodeBaseMapLineMaterialBytes(bytes);
    material.parameters
      ..setColor('line_color', values.color)
      ..setVec2(
        'half_width_ndc',
        scene_math.Vector2(values.halfWidthNdcX, values.halfWidthNdcY),
      );
    return;
  }
  throw ArgumentError.value(
    pipelineKey,
    'pipelineKey',
    'is not a base map pipeline',
  );
}
