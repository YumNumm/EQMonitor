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
  /// [LineMesh.extrudes]は`MeshGeometry.fromArrays`の組み込み`texCoords`
  /// 引数(`vec2`)へ渡す。以前は`setCustomAttribute('extrude', ...)`で
  /// custom vertex attributeとして渡していたが、この環境ではGPUへ値が
  /// 届かず、代わりに同じ頂点の`position`(origin rebasing後の座標)が
  /// shaderで読まれてしまうバグがあることをGPUレベルの実験で確認した
  /// (`.superpowers/sdd/2026-08-05-eqmonitor-map-base-layer-pmtiles/
  /// extrude-gpu-probe-report.md`参照)。custom attributeを経由しない
  /// `texCoords`は型が`vec2`で押し出し法線と完全に一致し、production実績の
  /// ある経路のためこのバグを回避できる。`base_map_line.fmat`側はこの値を
  /// `vertex.uv`として読む(同ファイル冒頭のdoc comment参照。UVではなく
  /// 押し出し法線を運んでいるという意味論の逸脱がある)。storageの選び方は
  /// [fillGeometry]と同じ理由で`fixed`。
  scene.MeshGeometry lineGeometry(LineMesh mesh) {
    final args = buildLineGeometryArgs(mesh);
    return scene.MeshGeometry.fromArrays(
      positions: args.positions,
      texCoords: args.extrudes,
      indices: args.indices,
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

/// [BaseMapGeometryFactory.lineGeometry]が`MeshGeometry.fromArrays`へ渡す
/// 引数そのもの。[FillGeometryArgs]と同じ理由でpure関数として切り出して
/// いる。
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

  /// [LineMesh.extrudes]をそのまま渡す(2成分、z拡張は不要。押し出し方向は
  /// 座標ではなく`vec2`の方向ベクトルであり、`MeshGeometry.fromArrays`の
  /// `positions`のような3成分要求を持たない)。`lineGeometry`が
  /// `MeshGeometry.fromArrays`の`texCoords:`引数へそのまま渡す
  /// (`lineGeometry`のdoc comment参照。custom attributeの不具合を避ける
  /// ため、組み込みのtexCoordsへ押し出し法線を積んでいる)。
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
