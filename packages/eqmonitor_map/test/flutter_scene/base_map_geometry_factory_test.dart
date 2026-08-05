import 'dart:typed_data';

import 'package:eqmonitor_map/src/flutter_scene/base_map_geometry_factory.dart';
import 'package:eqmonitor_map/src/flutter_scene/base_map_material_library.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:flutter_test/flutter_test.dart';

// このtestはGPU初期化を必要としない範囲だけを検証する。
// `BaseMapGeometryFactory.fillGeometry`/`lineGeometry`自体は
// `scene.MeshGeometry.fromArrays`/`setCustomAttribute`というGPUへの
// buffer作成・アップロードを呼ぶため、`test/flutter_scene`の既存test
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

    test('extrudesは2成分のまま変更せず渡す', () {
      final extrudes = Float32List.fromList(const [0.6, 0.8, -0.6, -0.8]);
      final mesh = LineMesh(
        positions: Float32List.fromList(const [0, 0, 1, 1]),
        extrudes: extrudes,
        indices: Uint16List.fromList(const [0, 1, 0]),
        vertexCount: 2,
      );

      final args = buildLineGeometryArgs(mesh);

      expect(args.extrudes, Float32List.fromList(const [0.6, 0.8, -0.6, -0.8]));
      // zパディングは`positions`だけの事情(`MeshGeometry.fromArrays`が
      // 3成分を要求する)であり、`extrude`は`setCustomAttribute`へ
      // `components: 2`で渡すvec2属性なので触ってはいけない。触っていない
      // ことを同一インスタンスであることで確認する。
      expect(identical(args.extrudes, extrudes), isTrue);
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
  });

  group('halfLineWidthWorldFor', () {
    // 換算式のtestは実装を呼んで得た値ではなく、doc commentに書いた導出
    // (1 world単位 == 1 logical pixel、zoom非依存)から手計算で独立に
    // 求めた固定値で検証する。
    test('logical pixelの半線幅をそのままworld単位として返す', () {
      // 手計算: 換算係数は1なので、half_width_world == halfWidthLogicalPixels。
      // 2.5という半端な値を選び、「2倍にする」「四捨五入する」といった
      // バグを検出できるようにしている。
      expect(
        halfLineWidthWorldFor(halfWidthLogicalPixels: 2.5),
        2.5,
      );
    });

    test('0を渡すと0を返す', () {
      expect(halfLineWidthWorldFor(halfWidthLogicalPixels: 0), 0);
    });

    test('負値はArgumentErrorを投げる', () {
      expect(
        () => halfLineWidthWorldFor(halfWidthLogicalPixels: -0.1),
        throwsArgumentError,
      );
    });

    test('非finite値はArgumentErrorを投げる', () {
      expect(
        () => halfLineWidthWorldFor(halfWidthLogicalPixels: double.nan),
        throwsArgumentError,
      );
      expect(
        () => halfLineWidthWorldFor(
          halfWidthLogicalPixels: double.infinity,
        ),
        throwsArgumentError,
      );
    });
  });
}
