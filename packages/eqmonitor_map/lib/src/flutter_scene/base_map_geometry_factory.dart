import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_scene/scene.dart' as scene;

/// [FillMesh]/[LineMesh](tile-local、2成分positions)からFlutter Sceneの
/// `scene.Geometry`を作る。
///
/// `MeshGeometry.fromArrays`へ渡す引数の組み立て([_expandTo3D]によるz
/// パディング、index bufferの受け渡し)は、実際にGPUへアップロードする
/// [fillGeometry]/[lineGeometry]から独立した[buildFillGeometryArgs]/
/// [buildLineGeometryArgs]というpure関数に切り出している。GPU初期化を伴う
/// `MeshGeometry.fromArrays`自体はwidget test環境で呼べない
/// (`test/flutter_scene`の既存testが実際のGPU呼び出しをすべてfakeで避けて
/// いるのと同じ理由)ため、`test/flutter_scene/base_map_geometry_factory_test.dart`
/// はこのpure関数だけを検証し、GPU呼び出しそのものはテストしない。
class BaseMapGeometryFactory {
  const BaseMapGeometryFactory();

  /// [mesh]から塗りつぶし用の`scene.Geometry`を作る。
  ///
  /// 頂点bufferは1回だけアップロードする(`GeometryStorage.fixed`、
  /// `MeshGeometry.fromArrays`の既定値)。base mapのデバッグ描画は静的な
  /// tile snapshotであり、Task 8の範囲でフレーム毎の頂点更新は発生しない
  /// ため、`updatable`(CPU側コピー保持+リングバッファでの部分更新)が持つ
  /// オーバーヘッドは不要。frame毎の再構築が要る描画(例: cameraに追従する
  /// route line)が出てきた時に初めて`updatable`への切り替えを検討する。
  scene.MeshGeometry fillGeometry(FillMesh mesh) {
    final args = buildFillGeometryArgs(mesh);
    return scene.MeshGeometry.fromArrays(
      positions: args.positions,
      indices: args.indices,
    );
  }

  /// [mesh]から線描画用の`scene.Geometry`を作る。
  ///
  /// [LineMesh.extrudes]は`setCustomAttribute`で`extrude`という名前の頂点
  /// 属性として渡す。この名前は`base_map_line.fmat`の
  /// `attributes: [ { type: vec2, name: extrude } ]`宣言と対応しており、
  /// 名前が一致しない限りshaderの`in vec2 extrude`は値を受け取れない。
  /// storageの選び方は[fillGeometry]と同じ理由で`fixed`。
  scene.MeshGeometry lineGeometry(LineMesh mesh) {
    final args = buildLineGeometryArgs(mesh);
    return scene.MeshGeometry.fromArrays(
      positions: args.positions,
      indices: args.indices,
    )..setCustomAttribute(
      'extrude',
      args.extrudes,
      components: 2,
    );
  }
}

/// [BaseMapGeometryFactory.fillGeometry]が`MeshGeometry.fromArrays`へ渡す
/// 引数そのもの。GPU呼び出しを含まないため、GPU初期化なしのunit testで
/// 直接検証できる。
@immutable
class FillGeometryArgs {
  const FillGeometryArgs({required this.positions, required this.indices});

  /// tile-local座標を3成分(x, y, 0)へ展開したfloat32頂点列
  /// ([_expandTo3D]のdoc comment参照)。
  final Float32List positions;

  /// [FillMesh.indices]をそのまま渡す。`FillMesh`の設計上65536頂点を
  /// 超えないため([FillMesh]のdoc comment参照)、常に[Uint16List]で足りる。
  final Uint16List indices;
}

/// [BaseMapGeometryFactory.lineGeometry]が`MeshGeometry.fromArrays`と
/// `setCustomAttribute`へ渡す引数そのもの。[FillGeometryArgs]と同じ理由で
/// pure関数として切り出している。
@immutable
class LineGeometryArgs {
  const LineGeometryArgs({
    required this.positions,
    required this.indices,
    required this.extrudes,
  });

  /// tile-local座標を3成分(x, y, 0)へ展開したfloat32頂点列。
  final Float32List positions;

  /// [LineMesh.indices]をそのまま渡す。
  final Uint16List indices;

  /// [LineMesh.extrudes]をそのまま渡す(2成分、z拡張は不要。`extrude`は
  /// 座標ではなく`vec2`の押し出し方向属性であり、`MeshGeometry.fromArrays`
  /// の`positions`のような3成分要求を持たない)。
  final Float32List extrudes;
}

/// [mesh]から[BaseMapGeometryFactory.fillGeometry]の引数を組み立てる。
FillGeometryArgs buildFillGeometryArgs(FillMesh mesh) {
  return FillGeometryArgs(
    positions: _expandTo3D(mesh.positions),
    indices: mesh.indices,
  );
}

/// [mesh]から[BaseMapGeometryFactory.lineGeometry]の引数を組み立てる。
LineGeometryArgs buildLineGeometryArgs(LineMesh mesh) {
  return LineGeometryArgs(
    positions: _expandTo3D(mesh.positions),
    indices: mesh.indices,
    extrudes: mesh.extrudes,
  );
}

/// tile-local座標のx, yを交互に詰めた2成分頂点列を、`MeshGeometry.fromArrays`
/// が要求する3成分(x, y, z)頂点列へ展開する。zは常に0で埋める。
///
/// `FillMesh`/`LineMesh`はtile-local座標を2成分でしか持たない
/// (`positions`のdoc comment参照。fillもlineも2Dのtile平面上でしか頂点を
/// 生成しないため、3成分目を持つ理由がない)。この事実を
/// `FillMeshBuilder`/`LineMeshBuilder`側へ漏らさず、Flutter Sceneの
/// `Geometry`が3成分positionを要求するという制約に合わせてzを埋める処理は
/// このFlutter Scene adapter層だけに閉じる(brief要求)。
Float32List _expandTo3D(Float32List positions2D) {
  final vertexCount = positions2D.length ~/ 2;
  final positions3D = Float32List(vertexCount * 3);
  for (var i = 0; i < vertexCount; i++) {
    positions3D[i * 3] = positions2D[i * 2];
    positions3D[i * 3 + 1] = positions2D[i * 2 + 1];
    // positions3D[i * 3 + 2]はFloat32Listの既定値0のまま。
  }
  return positions3D;
}
