import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/flutter_scene/base_map_geometry_factory.dart';
import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart' show Vector2;

final class LineExtrudeProjectionCase {
  const LineExtrudeProjectionCase({
    required this.name,
    required this.dx,
    required this.dy,
  });

  final String name;
  final int dx;
  final int dy;

  MvtFeature feature() {
    return MvtFeature(
      type: MvtGeometryType.lineString,
      rings: [
        Int32List.fromList([0, 0, dx, dy]),
      ],
    );
  }

  Vector2 screenDirection() {
    final length = math.sqrt(dx * dx + dy * dy);
    return Vector2(dx / length, dy / length);
  }
}

final class LineExtrudeProjectionHarness {
  const LineExtrudeProjectionHarness({
    required this.viewport,
    required this.halfWidthLogicalPixels,
  });

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

    final args = buildLineGeometryArgs(meshes.single);
    final halfWidthNdc = halfLineWidthNdcFor(
      halfWidthLogicalPixels: halfWidthLogicalPixels,
      viewport: viewport,
    );
    final shaderNdcOffset = Vector2(
      args.extrudes[0] * halfWidthNdc.x,
      args.extrudes[1] * halfWidthNdc.y,
    );

    return Vector2(
      shaderNdcOffset.x * viewport.logicalSize.width / 2,
      -shaderNdcOffset.y * viewport.logicalSize.height / 2,
    );
  }
}

// このtestはGPU初期化を必要としない範囲だけを検証する。
// `BaseMapGeometryFactory.fillGeometry`/`lineGeometry`自体は
// `scene.MeshGeometry.fromArrays`というGPUへのbuffer作成・アップロードを
// 呼ぶため、`test/flutter_scene`の既存test
// (`flutter_scene_spike_controller_test.dart`)が実際のGPU呼び出しをすべて
// fakeで避けているのと同じ理由で、ここでは呼ばない。代わりに、それら2
// methodがGPU呼び出しの直前に組み立てる引数(`buildFillGeometryArgs`/
// `buildLineGeometryArgs`)というpure関数だけを検証する。
void main() {
  group('buildFillGeometryArgs', () {
    test('positionsを3成分(x, y, 0)へ展開する', () {
      // 3頂点、値をすべて異なるものにして
      // 「zを0で埋めず前の頂点のyを引きずる」「strideを2のまま3成分側へ
      // 書き込みインデックスがずれる」といったoff-by-oneバグを検出できる
      // ようにしている。
      final mesh = FillMesh(
        positions: Float32List.fromList(const [1, 2, 3, 4, 5, 6]),
        indices: Uint16List.fromList(const [0, 1, 2]),
        vertexCount: 3,
      );

      final args = buildFillGeometryArgs(mesh);

      expect(
        args.positions,
        Float32List.fromList(const [1, 2, 0, 3, 4, 0, 5, 6, 0]),
      );
    });

    test('頂点数がpositions.length ~/ 3と一致する(成分数の検証)', () {
      final mesh = FillMesh(
        positions: Float32List.fromList(
          List<double>.generate(10 * 2, (i) => i.toDouble()),
        ),
        indices: Uint16List.fromList(const [0, 1, 2]),
        vertexCount: 10,
      );

      final args = buildFillGeometryArgs(mesh);

      expect(args.positions.length, mesh.vertexCount * 3);
    });

    test('indicesをUint16Listのまま(コピーせず)渡す', () {
      final indices = Uint16List.fromList(const [0, 1, 2, 0, 2, 3]);
      final mesh = FillMesh(
        positions: Float32List.fromList(const [0, 0, 1, 0, 1, 1, 0, 1]),
        indices: indices,
        vertexCount: 4,
      );

      final args = buildFillGeometryArgs(mesh);

      expect(args.indices, isA<Uint16List>());
      // FillMeshBuilderが渡すindexは既に65536頂点以内に収まる
      // (FillMeshのdoc comment参照)ため、ここで型変換や再構築を行うと
      // 無駄なコピーが発生する。同一インスタンスであることを確認して
      // 「コピーしていない」ことを検出力のあるassertにする。
      expect(identical(args.indices, indices), isTrue);
    });
  });

  group('buildLineGeometryArgs', () {
    test('positionsを3成分(x, y, 0)へ展開する', () {
      final mesh = LineMesh(
        positions: Float32List.fromList(const [10, 20, 30, 40]),
        extrudes: Float32List.fromList(const [1, 0, -1, 0]),
        indices: Uint16List.fromList(const [0, 1, 0]),
        vertexCount: 2,
      );

      final args = buildLineGeometryArgs(mesh);

      expect(
        args.positions,
        Float32List.fromList(const [10, 20, 0, 30, 40, 0]),
      );
    });

    test('extrudesは2成分のままYをclip/NDC向けに反転して渡す', () {
      final extrudes = Float32List.fromList(const [0.6, 0.8, -0.6, -0.8]);
      final mesh = LineMesh(
        positions: Float32List.fromList(const [0, 0, 1, 1]),
        extrudes: extrudes,
        indices: Uint16List.fromList(const [0, 1, 0]),
        vertexCount: 2,
      );

      final args = buildLineGeometryArgs(mesh);

      expect(args.extrudes, Float32List.fromList(const [0.6, -0.8, -0.6, 0.8]));
      // zパディングは`positions`だけの事情(`MeshGeometry.fromArrays`が
      // 3成分を要求する)であり、`extrudes`は`MeshGeometry.fromArrays`の
      // `texCoords:`引数へ渡すvec2属性なので2成分のままにする。一方、
      // `LineMeshBuilder`のtile-local Y-down法線をshaderが加算する
      // clip/NDC Y-up空間へ合わせるため、Y成分だけは反転する。
      expect(identical(args.extrudes, extrudes), isFalse);
    });

    test('indicesをUint16Listのまま(コピーせず)渡す', () {
      final indices = Uint16List.fromList(const [0, 1, 2, 3]);
      final mesh = LineMesh(
        positions: Float32List.fromList(const [0, 0, 1, 0, 1, 1, 0, 1]),
        extrudes: Float32List.fromList(const [1, 0, 1, 0, -1, 0, -1, 0]),
        indices: indices,
        vertexCount: 4,
      );

      final args = buildLineGeometryArgs(mesh);

      expect(args.indices, isA<Uint16List>());
      expect(identical(args.indices, indices), isTrue);
    });

    test('line extrudeがscreen logical pxで線分に直交し半幅を保つ', () {
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

  group('halfLineWidthNdcFor', () {
    // 換算式のtestは実装を呼んで得た値ではなく、doc commentに書いた導出
    // (NDCはviewportのwidth/heightに対して[-1,1]を張るので1 logical px
    // == (2/width, 2/height))から手計算で独立に求めた固定値で検証する。
    test('logical pixelの半線幅をNDC単位のvec2へ換算する', () {
      // 手計算: halfPx=1, width=400, height=800 のとき
      // (2*1/400, 2*1/800) = (0.005, 0.0025)。
      // width/heightをわざと非正方形にして、x/yで異なる係数が掛かる
      // (成分ごとの独立換算)ことを検出できるようにしている。
      final viewport = MapViewport(
        logicalSize: const Size(400, 800),
        devicePixelRatio: 1,
      );

      final result = halfLineWidthNdcFor(
        halfWidthLogicalPixels: 1,
        viewport: viewport,
      );

      expect(result, Vector2(0.005, 0.0025));
    });

    test('0を渡すと(0, 0)を返す', () {
      final viewport = MapViewport(
        logicalSize: const Size(400, 800),
        devicePixelRatio: 1,
      );

      expect(
        halfLineWidthNdcFor(halfWidthLogicalPixels: 0, viewport: viewport),
        Vector2.zero(),
      );
    });

    test('負値はArgumentErrorを投げる', () {
      final viewport = MapViewport(
        logicalSize: const Size(400, 800),
        devicePixelRatio: 1,
      );

      expect(
        () => halfLineWidthNdcFor(
          halfWidthLogicalPixels: -0.1,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
    });

    test('非finite値はArgumentErrorを投げる', () {
      final viewport = MapViewport(
        logicalSize: const Size(400, 800),
        devicePixelRatio: 1,
      );

      expect(
        () => halfLineWidthNdcFor(
          halfWidthLogicalPixels: double.nan,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
      expect(
        () => halfLineWidthNdcFor(
          halfWidthLogicalPixels: double.infinity,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
    });
  });
}
