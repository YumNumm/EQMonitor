import 'dart:math' as math;
import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';
import 'package:flutter_test/flutter_test.dart';

// このtestの期待値は、すべて`LineMeshBuilder`を呼ばずに手計算・独立導出した
// 固定値である(実装を呼んで得た配列をそのまま期待値にはしない)。
//
// 押し出し法線の導出式(docs/knowledge/20260805_maplibre_native_renderer_
// reference.md「Line頂点生成」節):
//   joinNormal = normalize(prevNormal + nextNormal)
//   miterLength = 1 / cosHalfAngle = 2 / |prevNormal + nextNormal|
//     (|prevNormal + nextNormal| == 2 * cosHalfAngle は、prevNormalと
//     nextNormalのなす角をθとした二等分線ベクトルの長さの公式そのもの)
//   extrude = joinNormal * min(miterLength, miterLimit)
// 直線部分・cap(端点)はmiterLength == 1相当(隣接segmentが1つしかない、
// または2つのsegmentが同一方向を向く)であり、extrudeは単位法線のまま
// segmentの向きに直交する。miter join頂点はmiterLength(またはclamp後の
// limit)倍に伸びるため、どちらの隣接segmentにも直交しなくなる。

LineMeshBuilder _builder({
  int maxVerticesPerSegment = 65536,
  double miterLimit = 4,
}) {
  return LineMeshBuilder(
    limits: LineMeshBuilderLimits(maxVerticesPerSegment: maxVerticesPerSegment),
    miterLimit: miterLimit,
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

MvtFeature _lineFeature(List<Int32List> rings) {
  return MvtFeature(type: MvtGeometryType.lineString, rings: rings);
}

double _dot(double ax, double ay, double bx, double by) => ax * bx + ay * by;

void main() {
  group('straight line', () {
    test(
      'a 3-point collinear line keeps a unit normal perpendicular to the '
      'line at every vertex (cap and interior alike), and removes no '
      'points',
      () {
        // (0,0) -> (10,0) -> (20,0)。方向ベクトルは常に(1,0)、法線は
        // (-dy, dx)/len = (0, 1)。折れ曲がりが無いのでprevNormalと
        // nextNormalが完全に一致し、和のノルムは2、miterLength = 2/2 = 1、
        // joinNormalはそのまま(0,1)なので、interior頂点もcapと同じ
        // extrudeになる。
        final ring = _ring([(0, 0), (10, 0), (20, 0)]);
        final feature = _lineFeature([ring]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 6);
        expect(
          mesh.positions,
          Float32List.fromList([
            0, 0, 0, 0, //
            10, 0, 10, 0, //
            20, 0, 20, 0, //
          ]),
        );
        expect(
          mesh.extrudes,
          Float32List.fromList([
            0, 1, 0, -1, //
            0, 1, 0, -1, //
            0, 1, 0, -1, //
          ]),
        );
        // 各segmentの四角形(plus 2頂点 + next plusとminus)を対角線
        // (自身のminus - 次点のplus)で2枚のtriangleへ分割する。
        // segment 0(点0-1): plus/minus頂点index = 0,1,2,3。
        // segment 1(点1-2): plus/minus頂点index = 2,3,4,5。
        expect(
          mesh.indices,
          Uint16List.fromList([
            0, 1, 2, 1, 3, 2, //
            2, 3, 4, 3, 5, 4, //
          ]),
        );

        // 押し出し法線が線分の方向に直交すること(直線部分の不変条件。
        // miter join頂点ではこの不変条件は成り立たない、後続のtestを参照)。
        const dirX = 1.0;
        const dirY = 0.0;
        for (var i = 0; i < mesh.vertexCount; i++) {
          final ex = mesh.extrudes[i * 2];
          final ey = mesh.extrudes[i * 2 + 1];
          expect(
            _dot(ex, ey, dirX, dirY),
            closeTo(0, 1e-6),
            reason: 'vertex $i の押し出し法線が線分方向に直交していない',
          );
        }
      },
    );

    test(
      'a consecutive duplicate point (and the zero-length segment it '
      'creates) is removed, producing the exact same mesh as the '
      'deduplicated 3-point line',
      () {
        // (10,0)が2回連続する。除去後は(0,0),(10,0),(20,0)の3点になり、
        // 上のtestと完全に同じmeshになるはずである。
        final ring = _ring([(0, 0), (10, 0), (10, 0), (20, 0)]);
        final feature = _lineFeature([ring]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 6, reason: '重複頂点が除去されず4点のまま扱われている');
        expect(
          mesh.positions,
          Float32List.fromList([
            0, 0, 0, 0, //
            10, 0, 10, 0, //
            20, 0, 20, 0, //
          ]),
        );
        expect(
          mesh.extrudes,
          Float32List.fromList([
            0, 1, 0, -1, //
            0, 1, 0, -1, //
            0, 1, 0, -1, //
          ]),
        );
      },
    );
  });

  group('right-angle miter join', () {
    test(
      'a 90-degree turn produces an interior extrude of exactly (-1, 1), '
      'which is NOT perpendicular to either adjacent segment, while the '
      'two endpoint caps remain perpendicular to their own segment',
      () {
        // (0,0) -> (10,0) -> (10,10)。
        // segment0の方向(1,0)、法線(0,1)。segment1の方向(0,1)、法線(-1,0)。
        // sum = (0,1)+(-1,0) = (-1,1)、sumLength = sqrt(2)。
        // joinNormal = (-1,1)/sqrt(2)、miterLength = 2/sqrt(2) = sqrt(2)。
        // extrude = joinNormal * sqrt(2) = (-1,1)(sqrt(2)が約分されて
        // 綺麗な整数になる)。miterLimit=4はsqrt(2)を超えるためclampされない。
        final ring = _ring([(0, 0), (10, 0), (10, 10)]);
        final feature = _lineFeature([ring]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 6);
        expect(
          mesh.positions,
          Float32List.fromList([
            0, 0, 0, 0, //
            10, 0, 10, 0, //
            10, 10, 10, 10, //
          ]),
        );
        expect(
          mesh.extrudes,
          Float32List.fromList([
            0, 1, 0, -1, //
            -1, 1, 1, -1, //
            -1, 0, 1, 0, //
          ]),
        );

        // 配列レイアウト: 点iはplus頂点(offset i*4, i*4+1)とminus頂点
        // (offset i*4+2, i*4+3)の計4 floatを占める。
        // capは直交する: 始点(点0のplus, offset 0,1)はsegment0の方向
        // (1,0)に、終点(点2のplus, offset 8,9)はsegment1の方向(0,1)に
        // 直交する。
        expect(
          _dot(mesh.extrudes[0], mesh.extrudes[1], 1, 0),
          closeTo(0, 1e-6),
        );
        expect(
          _dot(mesh.extrudes[8], mesh.extrudes[9], 0, 1),
          closeTo(0, 1e-6),
        );

        // miter join頂点(点1のplus, offset 4,5)はどちらのsegmentにも
        // 直交しない(内積が明確に非0)。これがmiter joinの非直交性の検証。
        final joinEx = mesh.extrudes[4];
        final joinEy = mesh.extrudes[5];
        expect(_dot(joinEx, joinEy, 1, 0), isNot(closeTo(0, 1e-6)));
        expect(_dot(joinEx, joinEy, 0, 1), isNot(closeTo(0, 1e-6)));
      },
    );
  });

  group('sharp turn and miter limit clamping', () {
    // (0,0) -> (10,0) -> (6,-3)。
    // segment0の方向(1,0)、法線normal0 = (0,1)。
    // segment1: dx=6-10=-4, dy=-3-0=-3、長さ5(3-4-5直角三角形)、
    // 方向(-4/5,-3/5)、法線normal1 = (3/5,-4/5) = (0.6,-0.8)。
    // sum = (0+0.6, 1-0.8) = (0.6, 0.2)、sumLength = sqrt(0.36+0.04)
    //     = sqrt(0.4) = sqrt(10)/5。
    // miterLength = 2/sumLength = 2*5/sqrt(10) = 10/sqrt(10) = sqrt(10)
    //     (≈3.16228)。
    // joinNormal = (0.6,0.2)/sumLength = (3/sqrt(10), 1/sqrt(10))
    //     (単位ベクトル: (3/sqrt(10))^2+(1/sqrt(10))^2 = 9/10+1/10 = 1)。
    // extrude(unclamped) = joinNormal * miterLength
    //     = (3/sqrt(10)*sqrt(10), 1/sqrt(10)*sqrt(10)) = (3, 1)
    //     (sqrt(10)が約分されて綺麗な整数になる)。

    final ring = _ring([(0, 0), (10, 0), (6, -3)]);

    test(
      'miterLength for this turn is exactly sqrt(10) and, with a limit '
      'above it, the interior extrude is the unclamped (3, 1)',
      () {
        final feature = _lineFeature([ring]);
        // miterLimit=10 > sqrt(10) ≈ 3.162なのでclampされない。
        final meshes = _builder(miterLimit: 10).build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 6);
        // 点1(中間点)のplus頂点はoffset i*4=4,5(点iはplus 2 + minus 2の
        // 計4 floatを占める配列レイアウト)。
        expect(mesh.extrudes[4], closeTo(3, 1e-4));
        expect(mesh.extrudes[5], closeTo(1, 1e-4));

        final magnitude = math.sqrt(
          mesh.extrudes[4] * mesh.extrudes[4] +
              mesh.extrudes[5] * mesh.extrudes[5],
        );
        expect(magnitude, closeTo(math.sqrt(10), 1e-4));
      },
    );

    test(
      'a miter limit below sqrt(10) clamps the interior extrude to exactly '
      'that limit length while preserving the join direction',
      () {
        final feature = _lineFeature([ring]);
        const limit = 2.0;
        // sqrt(10) ≈ 3.162 > 2 なのでclampが発生する。
        // clamp後の期待値 = joinNormal * limit
        //   = (3/sqrt(10), 1/sqrt(10)) * 2 = (6/sqrt(10), 2/sqrt(10))。
        final meshes = _builder(miterLimit: limit).build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        final expectedX = 6 / math.sqrt(10);
        final expectedY = 2 / math.sqrt(10);
        // 点1(中間点)のplus頂点はoffset i*4=4,5。
        expect(mesh.extrudes[4], closeTo(expectedX, 1e-4));
        expect(mesh.extrudes[5], closeTo(expectedY, 1e-4));

        final magnitude = math.sqrt(
          mesh.extrudes[4] * mesh.extrudes[4] +
              mesh.extrudes[5] * mesh.extrudes[5],
        );
        expect(
          magnitude,
          closeTo(limit, 1e-4),
          reason: 'clamp後のextrude長はmiterLimitちょうどでなければならない',
        );

        // clampはlimitではなく本来のmiterLengthそのものを格納していないか
        // (=clampが実際には効いていないか)の確認。
        expect(magnitude, isNot(closeTo(math.sqrt(10), 1e-3)));
      },
    );
  });

  group('closed loop', () {
    test(
      'a closed square ring wraps the join computation across the '
      'closing edge, so vertex 0 uses both the last and first segment '
      'normals instead of being treated as an open-line start cap',
      () {
        // (0,0)-(10,0)-(10,10)-(0,10)-(0,0)。末尾が先頭と同一座標なので
        // dedupeRingは閉路とみなし末尾を除去、4点・4辺のringになる。
        // 各辺の法線:
        //   seg0 (0,0)->(10,0):  normal = (0,1)
        //   seg1 (10,0)->(10,10): normal = (-1,0)
        //   seg2 (10,10)->(0,10): normal = (0,-1)
        //   seg3 (0,10)->(0,0):  normal = (1,0)
        // 各頂点は隣接する2辺(wrap-aroundを含む)からjoinNormalを作る。
        // どの頂点も直角なのでsumLength = sqrt(2)、miterLength = sqrt(2)。
        //   vertex0: prev=seg3=(1,0), next=seg0=(0,1) -> sum=(1,1)
        //            -> extrude = (1,1)
        //   vertex1: prev=seg0=(0,1), next=seg1=(-1,0) -> sum=(-1,1)
        //            -> extrude = (-1,1)
        //   vertex2: prev=seg1=(-1,0), next=seg2=(0,-1) -> sum=(-1,-1)
        //            -> extrude = (-1,-1)
        //   vertex3: prev=seg2=(0,-1), next=seg3=(1,0) -> sum=(1,-1)
        //            -> extrude = (1,-1)
        // vertex0が(1,1)ではなく(0,1)(=開いたlineの始点capの値)になって
        // いたら、閉路のwrap-aroundが実装されていないバグである。
        final ring = _ring([
          (0, 0),
          (10, 0),
          (10, 10),
          (0, 10),
          (0, 0),
        ]);
        final feature = _lineFeature([ring]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        expect(mesh.vertexCount, 8, reason: '閉路の末尾重複点は除去され4点×2にならなければならない');
        expect(
          mesh.positions,
          Float32List.fromList([
            0, 0, 0, 0, //
            10, 0, 10, 0, //
            10, 10, 10, 10, //
            0, 10, 0, 10, //
          ]),
        );
        expect(
          mesh.extrudes,
          Float32List.fromList([
            1, 1, -1, -1, //
            -1, 1, 1, -1, //
            -1, -1, 1, 1, //
            1, -1, -1, 1, //
          ]),
        );

        // 閉路はsegmentCount == 頂点数(最後の点から先頭点へ戻る辺を含む)。
        // segment k=(a,b)ごとにplus/minus 4頂点から2 triangle。
        // k=3(a=3,b=0)は閉じ辺であり、bとして頂点0(index 0,1)を参照する。
        expect(
          mesh.indices,
          Uint16List.fromList([
            0, 1, 2, 1, 3, 2, // seg0: a=0,b=1
            2, 3, 4, 3, 5, 4, // seg1: a=1,b=2
            4, 5, 6, 5, 7, 6, // seg2: a=2,b=3
            6, 7, 0, 7, 1, 0, // seg3: a=3,b=0 (閉じ辺)
          ]),
        );
      },
    );
  });

  group('degenerate rings shorter than 2 vertices', () {
    test(
      'a ring collapsing to a single point after dedup contributes no '
      'mesh, while sibling rings in the same feature still render',
      () {
        final degenerate = _ring([(5, 5), (5, 5), (5, 5)]);
        final onlyDegenerate = _lineFeature([degenerate]);

        expect(_builder().build([onlyDegenerate]), isEmpty);

        final valid = _ring([(0, 0), (10, 0), (20, 0)]);
        final mixed = _lineFeature([degenerate, valid]);
        final meshes = _builder().build([mixed]);

        expect(meshes, hasLength(1));
        expect(
          meshes.single.vertexCount,
          6,
          reason: '縮退したringの頂点が混ざらず、有効なringの3点×2だけになる',
        );
      },
    );
  });

  group('multiple rings in a single feature', () {
    // 1 featureが複数ringを持つケース(`countries`のようなPolygon由来の
    // Line layerが典型例。多数の国・島を1 featureの複数ringとして持つ)を
    // 直接検証する。三角形の3頂点がすべて同一ring由来であることを
    // 不変条件として固定する(特定のindex配列と比較する形にはしない)。
    //
    // ring境界を検出する方法: 各ringはdedup後の頂点数nに対し、常に
    // 2n個の頂点(各点のplus/minus)を生成し、feature内ではring登場順に
    // 連続したindex区間を占める(`LineMeshBuilder.build`のlocalOffset
    // 累積)。よってringごとの頂点数さえ分かれば、区間境界は
    // このtestの入力から導出できる(実装のindex配列そのものを直接
    // 比較するわけではない)。
    void expectNoCrossRingTriangle(
      LineMesh mesh,
      List<int> vertexCountPerRing,
    ) {
      final ringStart = <int>[];
      var offset = 0;
      for (final count in vertexCountPerRing) {
        ringStart.add(offset);
        offset += count;
      }
      int ringIndexOf(int vertexIndex) {
        for (var r = ringStart.length - 1; r >= 0; r--) {
          if (vertexIndex >= ringStart[r]) {
            return r;
          }
        }
        throw StateError('vertexIndex $vertexIndex is out of range');
      }

      for (var i = 0; i + 2 < mesh.indices.length; i += 3) {
        final ring0 = ringIndexOf(mesh.indices[i]);
        final ring1 = ringIndexOf(mesh.indices[i + 1]);
        final ring2 = ringIndexOf(mesh.indices[i + 2]);
        expect(
          {ring0, ring1, ring2},
          hasLength(1),
          reason:
              'triangle at indices[$i..${i + 2}] mixes vertices from '
              'different rings (ring0=$ring0, ring1=$ring1, ring2=$ring2), '
              'which means a ring boundary was bridged.',
        );
      }
    }

    double triArea(
      LineMesh mesh,
      int ia,
      int ib,
      int ic, {
      double halfWidth = 1,
    }) {
      double px(int idx) =>
          mesh.positions[idx * 2] + mesh.extrudes[idx * 2] * halfWidth;
      double py(int idx) =>
          mesh.positions[idx * 2 + 1] + mesh.extrudes[idx * 2 + 1] * halfWidth;
      final ax = px(ia);
      final ay = py(ia);
      final bx = px(ib);
      final by = py(ib);
      final cx = px(ic);
      final cy = py(ic);
      return ((bx - ax) * (cy - ay) - (cx - ax) * (by - ay)).abs() / 2;
    }

    test(
      'a feature with two widely separated closed rings never produces a '
      'triangle whose vertices span both rings, and the extruded '
      "triangle areas stay within each ring's own small bounding box "
      '(no bridge across the ~4000-unit gap between the rings)',
      () {
        // ringA: tile-local (0,0)を中心とした10x10の小さな正方形。
        // ringB: ringAから4000単位離れた(4000,4000)を中心とした同じ大きさの
        // 正方形。もしring遷移でindexが分離されず橋渡しされていれば、
        // 2つのringの頂点(距離約4000)を結ぶ巨大な三角形が生成されるはずで
        // あり、その面積は数千のオーダーになる(ring単独の押し出し後
        // 三角形の面積はたかだか数十のオーダー)。
        final ringA = _ring([(0, 0), (10, 0), (10, 10), (0, 10), (0, 0)]);
        final ringB = _ring([
          (4000, 4000),
          (4010, 4000),
          (4010, 4010),
          (4000, 4010),
          (4000, 4000),
        ]);
        final feature = _lineFeature([ringA, ringB]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        // 各ringは4点(dedup+closing後)なので、plus/minusで8頂点ずつ。
        expect(mesh.vertexCount, 16);
        expectNoCrossRingTriangle(mesh, [8, 8]);

        var maxArea = 0.0;
        for (var i = 0; i + 2 < mesh.indices.length; i += 3) {
          final area = triArea(
            mesh,
            mesh.indices[i],
            mesh.indices[i + 1],
            mesh.indices[i + 2],
          );
          if (area > maxArea) {
            maxArea = area;
          }
        }
        // ringAの1辺は10、押し出しはmiter joinを含めても最大miterLimit
        // (既定4)倍。単独ringの三角形面積は明らかに1000を超えない
        // (10 * 4 = 40程度が上限のオーダー)。一方、橋渡しが起きた場合の
        // 面積は距離差(約4000)に比例するため、1000という閾値は
        // 「橋渡しがあれば必ず検出でき、橋渡しがなければ絶対に超えない」
        // 安全なマージンを持つ。
        expect(
          maxArea,
          lessThan(1000),
          reason:
              'a triangle this large can only be explained by a vertex from '
              'ringA being connected to a vertex from ringB',
        );
      },
    );

    test(
      'a feature with two widely separated open line rings also keeps '
      'triangles within their own ring',
      () {
        final ringA = _ring([(0, 0), (10, 0), (10, 10)]);
        final ringB = _ring([(4000, 4000), (4010, 4000), (4010, 4010)]);
        final feature = _lineFeature([ringA, ringB]);

        final meshes = _builder().build([feature]);

        expect(meshes, hasLength(1));
        final mesh = meshes.single;
        // 開いたlineはring1本につき3点×2(plus/minus) = 6頂点。
        expect(mesh.vertexCount, 12);
        expectNoCrossRingTriangle(mesh, [6, 6]);
      },
    );
  });

  group('segment splitting at the Uint16 index boundary', () {
    test(
      'keeps 2-point line features together while the running vertex '
      'count stays at or under the configured segment capacity, and '
      'starts a new segment only once adding a feature would exceed it',
      () {
        // 2点のlineは1点あたりplus/minus 2頂点で、計4頂点を生む。
        // segment容量を8に設定すると、1つ目+2つ目でちょうど8
        // (容量と等しい、超過しない)、3つ目を足すと12(容量超過)になる
        // ため、3つ目の直前でsegmentが切られる(FillMeshBuilderの
        // segment分割規則と同じ)。
        Int32List line(int offset) => _ring([(offset, 0), (offset + 1, 0)]);

        final features = [
          _lineFeature([line(0)]),
          _lineFeature([line(10)]),
          _lineFeature([line(20)]),
        ];

        final meshes = _builder(maxVerticesPerSegment: 8).build(features);

        expect(meshes, hasLength(2));
        expect(meshes[0].vertexCount, 8);
        expect(meshes[1].vertexCount, 4);

        for (final index in meshes[0].indices) {
          expect(index, lessThan(8));
        }
        for (final index in meshes[1].indices) {
          expect(index, lessThan(4));
        }
      },
    );

    test(
      'rejects a single feature whose vertex count alone exceeds the '
      'segment capacity, without silently splitting it',
      () {
        // 5点のlineは10頂点(plus/minus)を生む。容量6を超えるため、
        // 分割ではなく例外を投げる。
        final ring = _ring([
          (0, 0),
          (1, 0),
          (2, 0),
          (3, 0),
          (4, 0),
        ]);
        final feature = _lineFeature([ring]);

        expect(
          () => _builder(maxVerticesPerSegment: 6).build([feature]),
          throwsA(isA<LineMeshLimitExceededException>()),
        );
      },
    );
  });

  group('invalid arguments', () {
    test('rejects a maxVerticesPerSegment above the Uint16 index ceiling', () {
      expect(
        () => _builder(maxVerticesPerSegment: 65537),
        throwsArgumentError,
      );
    });

    test('rejects a miterLimit below 1', () {
      expect(() => _builder(miterLimit: 0.5), throwsArgumentError);
    });

    test('rejects a feature whose geometry type is not lineString', () {
      final feature = MvtFeature(
        type: MvtGeometryType.polygon,
        rings: [
          _ring([(0, 0), (10, 0), (10, 10)]),
        ],
      );

      expect(
        () => _builder().build([feature]),
        throwsArgumentError,
      );
    });
  });
}
