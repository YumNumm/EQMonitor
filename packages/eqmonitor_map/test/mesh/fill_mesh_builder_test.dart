import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:flutter_test/flutter_test.dart';

// このtestは`Earcut.triangulateRaw`が返すindex配列そのものと比較しない。
// 三角形分割は無数の有効解を持ち得るため、代わりに「どの正しい三角形分割
// でも必ず成り立つ不変条件」だけを検証する:
//   - 三角形の面積の総和 == 元polygonの面積(穴を除く)
//   - 三角形の総数 == 頂点数 + 2*穴数 - (polygon数 * 2)
//     (境界頂点だけで穴つきpolygonを三角形分割すると必ずこの数になる、
//     Steiner点を足さない三角形分割に共通するEuler標数由来の恒等式。
//     正方形の外形+穴1つ(頂点8, 穴1つ)を実際に手計算し、8枚の三角形に
//     分割されることを確認した上でこの式を採用している。
//     `docs/superpowers/...task-6-brief.md`に書かれた式ではなく、
//     このtestで独立に導出・検算した式を使う)
//   - 全indexがvertexCountの範囲内
//   - 穴の内部に重心が入る三角形が無い
// これによりearcutの実装詳細(内部の走査順・分岐アルゴリズム)に依存せず
// バグを検出できる。

FillMeshBuilder _builder({
  int maxHolesPerPolygon = 8,
  int maxVerticesPerFeature = 1 << 20,
  int maxVerticesPerSegment = 65536,
}) {
  return FillMeshBuilder(
    limits: FillMeshBuilderLimits(
      maxHolesPerPolygon: maxHolesPerPolygon,
      maxVerticesPerFeature: maxVerticesPerFeature,
      maxVerticesPerSegment: maxVerticesPerSegment,
    ),
  );
}

/// x, yを交互に並べたringを作る。`points`は`(x, y)`のリスト。
Int32List _ring(List<(int, int)> points) {
  final buffer = Int32List(points.length * 2);
  for (var i = 0; i < points.length; i++) {
    buffer[i * 2] = points[i].$1;
    buffer[i * 2 + 1] = points[i].$2;
  }
  return buffer;
}

MvtFeature _polygonFeature(List<Int32List> rings) {
  return MvtFeature(type: MvtGeometryType.polygon, rings: rings);
}

/// shoelace公式による符号付き面積の2倍。builder本体と同じ規約
/// (raw (x, y)をそのまま使い、軸の向きを補正しない)で計算する、
/// テスト側の独立実装。
int _signedAreaTwice(Int32List ring) {
  final vertexCount = ring.length ~/ 2;
  var sum = 0;
  for (var i = 0; i < vertexCount; i++) {
    final x0 = ring[i * 2];
    final y0 = ring[i * 2 + 1];
    final j = (i + 1) % vertexCount;
    final x1 = ring[j * 2];
    final y1 = ring[j * 2 + 1];
    sum += x0 * y1 - x1 * y0;
  }
  return sum;
}

double _triangleArea(Float32List positions, int a, int b, int c) {
  final ax = positions[a * 2];
  final ay = positions[a * 2 + 1];
  final bx = positions[b * 2];
  final by = positions[b * 2 + 1];
  final cx = positions[c * 2];
  final cy = positions[c * 2 + 1];
  return ((bx - ax) * (cy - ay) - (cx - ax) * (by - ay)).abs() / 2;
}

({double x, double y}) _triangleCentroid(
  Float32List positions,
  int a,
  int b,
  int c,
) {
  final x = (positions[a * 2] + positions[b * 2] + positions[c * 2]) / 3;
  final y =
      (positions[a * 2 + 1] + positions[b * 2 + 1] + positions[c * 2 + 1]) / 3;
  return (x: x, y: y);
}

/// meshに含まれる全triangleの面積の総和(全indexが範囲内であることも
/// 併せて検証する)。
double _totalTriangleArea(FillMesh mesh) {
  expect(mesh.indices.length % 3, 0);
  var total = 0.0;
  for (var i = 0; i < mesh.indices.length; i += 3) {
    final a = mesh.indices[i];
    final b = mesh.indices[i + 1];
    final c = mesh.indices[i + 2];
    for (final index in [a, b, c]) {
      expect(
        index,
        inInclusiveRange(0, mesh.vertexCount - 1),
        reason: 'triangle indexはvertexCountの範囲内でなければならない',
      );
    }
    total += _triangleArea(mesh.positions, a, b, c);
  }
  return total;
}

void main() {
  group('simple polygon (no holes)', () {
    test('triangulates a square and preserves vertex order', () {
      final square = _ring([(0, 0), (10, 0), (10, 10), (0, 10)]);
      final feature = _polygonFeature([square]);

      final meshes = _builder().build([feature]);

      expect(meshes, hasLength(1));
      final mesh = meshes.single;
      expect(mesh.vertexCount, 4);
      // 穴が無い場合、頂点bufferはexterior ringの座標をそのままの順序で
      // 保持する(earcutは内部でlinked listを組むだけで、呼び出し側へ
      // 返すpositions配列の並びには影響しない)。
      expect(
        mesh.positions,
        Float32List.fromList([0, 0, 10, 0, 10, 10, 0, 10]),
      );

      // 三角形の総数は頂点数-2 (穴なしpolygonの一般公式)。
      expect(mesh.indices.length ~/ 3, 4 - 2);

      final expectedArea = _signedAreaTwice(square).abs() / 2;
      expect(_totalTriangleArea(mesh), closeTo(expectedArea, 1e-9));
    });

    test('rejects a ring with fewer than 3 vertices', () {
      final degenerate = _ring([(0, 0), (10, 0)]);
      final feature = _polygonFeature([degenerate]);

      expect(
        () => _builder().build([feature]),
        throwsA(isA<FillMeshDegenerateRingException>()),
      );
    });

    test('rejects a ring with zero signed area', () {
      // 3点が一直線上にあり、面積0(shoelace == 0)。
      final collinear = _ring([(0, 0), (5, 0), (10, 0)]);
      final feature = _polygonFeature([collinear]);

      expect(
        () => _builder().build([feature]),
        throwsA(isA<FillMeshDegenerateRingException>()),
      );
    });

    test(
      'rejects a lone ring wound as a hole (negative signed area) '
      'with no preceding exterior',
      () {
        // (0,0)-(0,10)-(10,10)-(10,0)は上のexteriorと逆順、つまり
        // shoelaceの符号が反転し負になる。
        final reversed = _ring([(0, 0), (0, 10), (10, 10), (10, 0)]);
        expect(_signedAreaTwice(reversed), lessThan(0));
        final feature = _polygonFeature([reversed]);

        expect(
          () => _builder().build([feature]),
          throwsA(isA<FillMeshHoleBeforeExteriorException>()),
        );
      },
    );
  });

  group('polygon with holes', () {
    test('triangulates a square with one hole', () {
      final exterior = _ring([(0, 0), (10, 0), (10, 10), (0, 10)]);
      final hole = _ring([(2, 2), (2, 8), (8, 8), (8, 2)]);
      expect(_signedAreaTwice(exterior), greaterThan(0));
      expect(_signedAreaTwice(hole), lessThan(0));
      final feature = _polygonFeature([exterior, hole]);

      final meshes = _builder().build([feature]);

      expect(meshes, hasLength(1));
      final mesh = meshes.single;
      expect(mesh.vertexCount, 8);

      // n + 2h - 2 (n=8, h=1個の穴) == 8。
      // 手計算: 10x10の外形から中央の6x6の穴をくり抜いた「額縁」形状は、
      // 対辺ごとに台形2枚=8枚の三角形へ分割できる。
      expect(mesh.indices.length ~/ 3, 8);

      final expectedArea =
          (_signedAreaTwice(exterior) + _signedAreaTwice(hole)).abs() / 2;
      expect(expectedArea, closeTo(100 - 36, 1e-9));
      expect(_totalTriangleArea(mesh), closeTo(expectedArea, 1e-9));

      // 穴(2..8, 2..8)の内部にどの三角形の重心も入らない。
      for (var i = 0; i < mesh.indices.length; i += 3) {
        final centroid = _triangleCentroid(
          mesh.positions,
          mesh.indices[i],
          mesh.indices[i + 1],
          mesh.indices[i + 2],
        );
        final insideHole =
            centroid.x > 2 &&
            centroid.x < 8 &&
            centroid.y > 2 &&
            centroid.y < 8;
        expect(insideHole, isFalse, reason: '穴の内部に重心を持つ三角形がある');
      }
    });

    test('triangulates a square with two disjoint holes', () {
      final exterior = _ring([(0, 0), (20, 0), (20, 20), (0, 20)]);
      final holeA = _ring([(2, 2), (2, 6), (6, 6), (6, 2)]);
      final holeB = _ring([(12, 12), (12, 16), (16, 16), (16, 12)]);
      final feature = _polygonFeature([exterior, holeA, holeB]);

      final meshes = _builder().build([feature]);

      expect(meshes, hasLength(1));
      final mesh = meshes.single;
      expect(mesh.vertexCount, 12);
      // n + 2h - 2 (n=12, h=2) == 14。
      expect(mesh.indices.length ~/ 3, 14);

      final expectedArea =
          (_signedAreaTwice(exterior) +
                  _signedAreaTwice(holeA) +
                  _signedAreaTwice(holeB))
              .abs() /
          2;
      expect(expectedArea, closeTo(400 - 16 - 16, 1e-9));
      expect(_totalTriangleArea(mesh), closeTo(expectedArea, 1e-9));

      bool insideRect(({double x, double y}) p, (int, int, int, int) rect) {
        final (minX, minY, maxX, maxY) = rect;
        return p.x > minX && p.x < maxX && p.y > minY && p.y < maxY;
      }

      for (var i = 0; i < mesh.indices.length; i += 3) {
        final centroid = _triangleCentroid(
          mesh.positions,
          mesh.indices[i],
          mesh.indices[i + 1],
          mesh.indices[i + 2],
        );
        expect(insideRect(centroid, (2, 2, 6, 6)), isFalse);
        expect(insideRect(centroid, (12, 12, 16, 16)), isFalse);
      }
    });

    test('rejects a polygon whose hole count exceeds the configured limit', () {
      final exterior = _ring([(0, 0), (20, 0), (20, 20), (0, 20)]);
      final holeA = _ring([(1, 1), (1, 3), (3, 3), (3, 1)]);
      final holeB = _ring([(5, 5), (5, 7), (7, 7), (7, 5)]);
      final feature = _polygonFeature([exterior, holeA, holeB]);

      expect(
        () => _builder(maxHolesPerPolygon: 1).build([feature]),
        throwsA(isA<FillMeshLimitExceededException>()),
      );
    });
  });

  group('multiple exterior rings in one feature', () {
    test(
      'a feature with two same-winding rings is classified as two '
      'polygons, not exterior+hole (classification is sign-only, '
      'independent of geometric nesting)',
      () {
        // squareBはsquareAの内部に幾何学的にネストしているが、同じ向き
        // (どちらもshoelace > 0)で巻かれているため、MVT仕様に従い2つ目の
        // 独立したexteriorとして扱われる(穴としては扱わない)。
        final squareA = _ring([(0, 0), (20, 0), (20, 20), (0, 20)]);
        final squareB = _ring([(5, 5), (10, 5), (10, 10), (5, 10)]);
        expect(_signedAreaTwice(squareA), greaterThan(0));
        expect(_signedAreaTwice(squareB), greaterThan(0));
        final feature = _polygonFeature([squareA, squareB]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 8);
        // 穴を持たない2つの独立したpolygon: (4-2) + (4-2) == 4。
        expect(mesh.indices.length ~/ 3, 4);

        // 面積は「差し引き」ではなく「足し算」になる(独立した2 polygonの
        // 総和であり、穴なら引き算になるはずの符号がここでは両方正)。
        final expectedArea = (400 + 25).toDouble();
        expect(_totalTriangleArea(mesh), closeTo(expectedArea, 1e-9));

        // 各三角形のindexは、squareA由来の頂点範囲[0,4)かsquareB由来の
        // 頂点範囲[4,8)のどちらか一方に完全に収まる
        // (別polygonのearcut結果が混ざらないことの確認。
        // earcutの内部実装ではなく、builderの頂点割り当てロジックを
        // 検証する不変条件)。
        for (var i = 0; i < mesh.indices.length; i += 3) {
          final indicesOfTriangle = [
            mesh.indices[i],
            mesh.indices[i + 1],
            mesh.indices[i + 2],
          ];
          final allInA = indicesOfTriangle.every((index) => index < 4);
          final allInB = indicesOfTriangle.every((index) => index >= 4);
          expect(
            allInA || allInB,
            isTrue,
            reason: '三角形が複数polygonの頂点を混ぜて参照している',
          );
        }
      },
    );
  });

  group('segment splitting at the Uint16 index boundary', () {
    test(
      'keeps features together while the running vertex count stays at '
      'or under the configured segment capacity, and starts a new '
      'segment only once adding a feature would exceed it',
      () {
        // 3頂点の三角形featureを3つ用意する。segment容量を6に設定すると、
        // 1つ目+2つ目でちょうど6(容量と等しい、超過しない)、3つ目を
        // 足すと9(容量超過)になるため、3つ目の直前でsegmentが切られる。
        Int32List triangle(int offset) => _ring([
          (offset, 0),
          (offset + 1, 0),
          (offset, 1),
        ]);

        final features = [
          _polygonFeature([triangle(0)]),
          _polygonFeature([triangle(10)]),
          _polygonFeature([triangle(20)]),
        ];

        final meshes = _builder(
          maxVerticesPerSegment: 6,
        ).build(features);

        expect(meshes, hasLength(2));
        expect(meshes[0].vertexCount, 6);
        expect(meshes[1].vertexCount, 3);

        // 各segmentは独立したUint16 index buffer(0始まり)を持つ。
        for (final index in meshes[0].indices) {
          expect(index, lessThan(6));
        }
        for (final index in meshes[1].indices) {
          expect(index, lessThan(3));
        }

        // 面積の総和はsegment分割の有無に関わらず保存される。
        final totalArea = meshes.fold<double>(
          0,
          (sum, mesh) => sum + _totalTriangleArea(mesh),
        );
        expect(totalArea, closeTo(0.5 * 3, 1e-9));
      },
    );

    test(
      'rejects a single feature whose vertex count alone exceeds the '
      'segment capacity, without silently splitting it',
      () {
        final square = _ring([(0, 0), (10, 0), (10, 10), (0, 10)]);
        final feature = _polygonFeature([square]);

        expect(
          () => _builder(maxVerticesPerSegment: 3).build([feature]),
          throwsA(isA<FillMeshLimitExceededException>()),
        );
      },
    );

    test(
      'rejects a feature whose vertex count exceeds the configured '
      'per-feature limit',
      () {
        final square = _ring([(0, 0), (10, 0), (10, 10), (0, 10)]);
        final feature = _polygonFeature([square]);

        expect(
          () => _builder(maxVerticesPerFeature: 3).build([feature]),
          throwsA(isA<FillMeshLimitExceededException>()),
        );
      },
    );

    test(
      'rejects a maxVerticesPerSegment above the Uint16 index ceiling',
      () {
        expect(
          () => _builder(maxVerticesPerSegment: 65537),
          throwsArgumentError,
        );
      },
    );
  });

  group('non-polygon input', () {
    test('rejects a feature whose geometry type is not polygon', () {
      final feature = MvtFeature(
        type: MvtGeometryType.lineString,
        rings: [
          _ring([(0, 0), (10, 0)]),
        ],
      );

      expect(
        () => _builder().build([feature]),
        throwsArgumentError,
      );
    });
  });
}
