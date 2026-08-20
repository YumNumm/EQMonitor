import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/flutter_scene_base_map_adapter.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh.dart';
import 'package:eqmonitor_map/src/foundation/render/map_packed_mesh_layout.dart';
import 'package:eqmonitor_map/src/foundation/render/map_vertex_attribute.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/renderer/base_map_packed_mesh.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart' show Vector2;

/// 押し出しがscreen上で線分に直交し半線幅を保つことを、
/// `LineMeshBuilder` → packer → adapter → uniform換算という**実際の経路**で
/// 通して検証するharness。
///
/// #1593以前は削除済みのgeometry factoryの`buildLineGeometryArgs`と
/// `halfLineWidthNdcFor`に対して同じ検証をしていた。その2つは
/// packer(`packBaseMapLineMesh`のY反転)、adapter
/// (`unpackBaseMapSceneGeometryArgs`)、uniform換算
/// (`baseMapLineHalfWidthNdc`)へ分割されたため、harnessも新しい経路へ
/// 付け替えている。**この検証を落とさないこと**: 押し出しの空間と半線幅の
/// 単位の不一致は、実際に画面全体を線色で塗り潰す不具合として発現した
/// (`docs/todo/800_eqmonitor_map_deferred_verification.md`)。
final class LineExtrudeProjectionCase {
  const new({required this.name, required this.dx, required this.dy});

  final String name;
  final int dx;
  final int dy;

  MvtFeature feature() => MvtFeature(
    type: MvtGeometryType.lineString,
    rings: [
      Int32List.fromList([0, 0, dx, dy]),
    ],
  );

  Vector2 screenDirection() {
    final length = math.sqrt(dx * dx + dy * dy);
    return Vector2(dx / length, dy / length);
  }
}

final class LineExtrudeProjectionHarness {
  const new({required this.viewport, required this.halfWidthLogicalPixels});

  final MapViewport viewport;
  final double halfWidthLogicalPixels;

  Vector2 projectedScreenOffsetFor({
    required LineExtrudeProjectionCase testCase,
  }) {
    final builder = LineMeshBuilder(
      limits: const LineMeshBuilderLimits(maxVerticesPerSegment: 64),
      miterLimit: 2,
    );
    final meshes = builder.build([testCase.feature()]);
    expect(meshes, hasLength(1));

    final args = unpackBaseMapSceneGeometryArgs(
      packBaseMapLineMesh(meshes.single),
    );
    final extrudes = args.extrudes!;
    final halfWidthNdc = baseMapLineHalfWidthNdc(
      halfWidthLogicalPixels: halfWidthLogicalPixels,
      viewport: viewport,
    );
    final shaderNdcOffset = Vector2(
      extrudes[0] * halfWidthNdc.x,
      extrudes[1] * halfWidthNdc.y,
    );

    return Vector2(
      shaderNdcOffset.x * viewport.logicalSize.width / 2,
      -shaderNdcOffset.y * viewport.logicalSize.height / 2,
    );
  }
}

void main() {
  // GPUを要する`MeshGeometry.fromArrays`と`PreprocessedMaterial`は
  // widget test環境で呼べないため、このtestはadapterのpure関数だけを検証する
  // (GPU呼び出しの直前までをpure関数にして検証するというこのpackageの
  // 既存方針に従う)。

  group('unpackBaseMapSceneGeometryArgs', () {
    test('expands a fill mesh to 3-component positions with z = 0', () {
      final packed = packBaseMapFillMesh(
        FillMesh(
          positions: Float32List.fromList([1, 2, 3, 4, 5, 6]),
          indices: Uint16List.fromList([0, 1, 2]),
          vertexCount: 3,
        ),
      );

      final args = unpackBaseMapSceneGeometryArgs(packed);

      expect(args.positions, [1, 2, 0, 3, 4, 0, 5, 6, 0]);
      expect(args.indices, [0, 1, 2]);
      expect(args.extrudes, isNull);
    });

    test('splits a line mesh into positions and extrusion normals', () {
      final packed = packBaseMapLineMesh(
        LineMesh(
          positions: Float32List.fromList([10, 20, 30, 40]),
          extrudes: Float32List.fromList([0, 1, -1, 0]),
          indices: Uint16List.fromList([0, 1, 0]),
          vertexCount: 2,
        ),
      );

      final args = unpackBaseMapSceneGeometryArgs(packed);

      expect(args.positions, [10, 20, 0, 30, 40, 0]);
      // packer が Y を反転済みなので、adapter は反転しない。
      expect(args.extrudes, [0, -1, -1, 0]);
      expect(args.indices, [0, 1, 0]);
    });

    test('round-trips a mesh whose vertices sit outside the MVT extent', () {
      final packed = packBaseMapFillMesh(
        FillMesh(
          positions: Float32List.fromList([-80, 4176, 4176, -80, 0, 0]),
          indices: Uint16List.fromList([0, 1, 2]),
          vertexCount: 3,
        ),
      );

      final args = unpackBaseMapSceneGeometryArgs(packed);

      expect(args.positions, [-80, 4176, 0, 4176, -80, 0, 0, 0, 0]);
    });

    test('rejects a layout that is neither base map fill nor line', () {
      final foreign = createMapPackedMesh(
        payloadVersion: 1,
        layout: createMapPackedMeshLayout(
          version: 1,
          topology: MapPrimitiveTopology.points,
          byteOrder: MapPackedByteOrder.little,
          vertexStride: 4,
          attributes: [
            MapVertexAttributeLayout(
              semantic: MapVertexAttributeSemantic.featureIdUint32,
              format: MapVertexAttributeFormat.uint32,
              offset: 0,
            ),
          ],
          indexFormat: MapIndexFormat.uint16,
        ),
        vertexBytes: Uint8List(4),
        vertexCount: 1,
        indexBytes: Uint8List(2),
        indexCount: 1,
      );

      expect(
        () => unpackBaseMapSceneGeometryArgs(foreign),
        throwsArgumentError,
      );
    });

    test('rejects a fill-like layout that declares no index format', () {
      // index無しのlayoutはbase mapのlayoutと互換ではないため、
      // 「fillでもlineでもない」として弾かれる(index欠落そのものへ到達する
      // 経路は`createMapPackedMesh`の検証で存在しない。adapter側の
      // `StateError`は将来index無しlayoutを足したときの保険)。
      final indexless = createMapPackedMesh(
        payloadVersion: baseMapPackedMeshPayloadVersion,
        layout: createMapPackedMeshLayout(
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
          indexFormat: null,
        ),
        vertexBytes: Uint8List(8),
        vertexCount: 1,
        indexBytes: null,
        indexCount: null,
      );

      expect(
        () => unpackBaseMapSceneGeometryArgs(indexless),
        throwsArgumentError,
      );
    });
  });

  group('line extrusion reaches the screen perpendicular at half width', () {
    test('holds for every line direction', () {
      const halfWidthLogicalPixels = 7.0;
      final harness = LineExtrudeProjectionHarness(
        viewport: MapViewport(
          logicalSize: const Size(400, 800),
          devicePixelRatio: 1,
        ),
        halfWidthLogicalPixels: halfWidthLogicalPixels,
      );
      const cases = [
        LineExtrudeProjectionCase(name: 'horizontal', dx: 100, dy: 0),
        LineExtrudeProjectionCase(name: 'vertical', dx: 0, dy: 100),
        LineExtrudeProjectionCase(name: '45deg', dx: 100, dy: 100),
        LineExtrudeProjectionCase(name: '30deg', dx: 100, dy: 58),
        LineExtrudeProjectionCase(name: '135deg', dx: -100, dy: 100),
      ];

      for (final testCase in cases) {
        final offset = harness.projectedScreenOffsetFor(testCase: testCase);
        final direction = testCase.screenDirection();

        expect(
          direction.dot(offset),
          closeTo(0, 1e-6),
          reason: '${testCase.name} offset must be perpendicular',
        );
        expect(
          offset.length,
          closeTo(halfWidthLogicalPixels, 1e-6),
          reason: '${testCase.name} offset must keep half width',
        );
      }
    });
  });
}
