import 'dart:typed_data';

import 'package:dart_earcut/dart_earcut.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/fill_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';

/// index bufferがUint16のため、1つの[FillMesh] segmentが持てる頂点数の
/// 絶対上限。index値0〜65535が指せる頂点は65536個。
const _maxIndexableVerticesPerSegment = 65536;

/// [MvtFeature.rings](MVT decoderが出力するtile-local座標のring列)から
/// [FillMesh]を組み立てる。三角形化自体は自前実装せず`dart_earcut`
/// (`Earcut.triangulateRaw`)へ委譲し、このbuilderはring winding分類・
/// 穴込みでのearcut呼び出し・segment分割だけを担う
/// (docs/knowledge/20260805_maplibre_native_renderer_reference.md
/// 「Fill頂点生成」節: `classifyRings` → `limitHoles` → `earcut`)。
final class FillMeshBuilder {
  new({required this.limits}) {
    if (limits.maxVerticesPerSegment <= 0 ||
        limits.maxVerticesPerSegment > _maxIndexableVerticesPerSegment) {
      throw ArgumentError.value(
        limits.maxVerticesPerSegment,
        'limits.maxVerticesPerSegment',
        'must be within 1..$_maxIndexableVerticesPerSegment because indices '
            'are stored as Uint16.',
      );
    }
  }

  final FillMeshBuilderLimits limits;

  /// [features]をtile-local座標のfill meshへ変換する。全featureの頂点が
  /// 1 segmentに収まらない場合、featureの境界でのみ分割した複数の
  /// [FillMesh]を返す(1つのfeatureが複数segmentへまたがることはない)。
  ///
  /// [features]はすべて[MvtGeometryType.polygon]でなければならない。
  /// 呼び出し側がlayerからPolygon featureだけを選んで渡す契約であり、
  /// それ以外の型が混じっているのは呼び出し側の実装誤りなので
  /// [ArgumentError]で落とす([FillMeshBuildException]は入力データ
  /// (untrusted tile bytes)由来の問題専用に予約する)。
  List<FillMesh> build(Iterable<MvtFeature> features) {
    final segments = <FillMesh>[];
    var positions = <double>[];
    var indices = <int>[];

    void flush() {
      if (positions.isEmpty) {
        return;
      }
      segments.add(
        FillMesh(
          positions: Float32List.fromList(positions),
          indices: Uint16List.fromList(indices),
          vertexCount: positions.length ~/ 2,
        ),
      );
      positions = <double>[];
      indices = <int>[];
    }

    for (final feature in features) {
      if (feature.type != MvtGeometryType.polygon) {
        throw ArgumentError.value(
          feature.type,
          'features',
          'FillMeshBuilder only accepts MvtGeometryType.polygon features.',
        );
      }

      final polygons = _classifyRings(feature.rings, limits: limits);
      final featurePositions = <double>[];
      final featureTriangleIndices = <int>[];
      var localOffset = 0;
      for (final polygon in polygons) {
        final triangulated = _triangulatePolygon(polygon);
        featurePositions.addAll(triangulated.vertices);
        for (final index in triangulated.triangleIndices) {
          featureTriangleIndices.add(index + localOffset);
        }
        localOffset += triangulated.vertices.length ~/ 2;
      }

      final featureVertexCount = featurePositions.length ~/ 2;
      if (featureVertexCount > limits.maxVerticesPerFeature) {
        throw FillMeshBuildException.limitExceeded(
          reason:
              'A feature has $featureVertexCount vertices, exceeding the '
              'configured per-feature limit '
              '(${limits.maxVerticesPerFeature}).',
        );
      }
      if (featureVertexCount > limits.maxVerticesPerSegment) {
        throw FillMeshBuildException.limitExceeded(
          reason:
              'A feature has $featureVertexCount vertices, which cannot fit '
              'in a single segment (limit: ${limits.maxVerticesPerSegment}). '
              'A single feature is never split across segments.',
        );
      }

      final currentVertexCount = positions.length ~/ 2;
      if (currentVertexCount + featureVertexCount >
          limits.maxVerticesPerSegment) {
        flush();
      }

      final offset = positions.length ~/ 2;
      positions.addAll(featurePositions);
      for (final index in featureTriangleIndices) {
        indices.add(index + offset);
      }
    }

    flush();
    return segments;
  }
}

/// 1つの外形ringとその穴ringからなるpolygon。ring自体はtile-local座標を
/// x, y交互に詰めた[Int32List]のままここでも保持し、この段階では座標を
/// 変換しない。
final class _RawPolygon {
  new({required this.exterior});

  final Int32List exterior;
  final List<Int32List> holes = [];
}

/// featureの全ringをwindingで外形/穴に分類する。
///
/// MVT仕様上、ringの符号付き面積(shoelace公式)の符号がexterior/interiorを
/// 決める。このbuilderは符号付き面積を`x_i*y_{i+1} - x_{i+1}*y_i`の総和
/// (2倍面積)としてそのまま計算し、軸の向きを補正しない。tile-local座標系は
/// yが下方向へ増える(画面/pixel座標と同じ)ため、この生の総和が正になる
/// ringは画面上で時計回りに見える外形、負になるringは反時計回りに見える
/// 穴である。Task 3の`mvt_decoder_test.dart`
/// (`decodes a Polygon with a hole and preserves ring winding`)が同じ
/// 生の総和を計算し、外形で`greaterThan(0)`、穴で`lessThan(0)`を検証して
/// いるのと同じ規約であり、本builderもそれに合わせる。
///
/// 最初に現れるring(feature内で最初に処理するring)が穴の符号を持つ場合、
/// それを内包すべき外形が存在しないため復元不能であり
/// [FillMeshBuildException.holeBeforeExterior]で拒否する。「featureの先頭
/// ringは常に外形として扱う」という寛容なfallbackは置かない
/// (符号だけがexterior/interiorを決める、というMVT仕様どおりの挙動を保つ
/// ため)。
List<_RawPolygon> _classifyRings(
  List<Int32List> rings, {
  required FillMeshBuilderLimits limits,
}) {
  final polygons = <_RawPolygon>[];
  for (final ring in rings) {
    final vertexCount = ring.length ~/ 2;
    if (vertexCount < 3) {
      throw FillMeshBuildException.degenerateRing(
        reason:
            'A ring has fewer than 3 vertices ($vertexCount), which cannot '
            'enclose an area.',
      );
    }

    final signedAreaTwice = _signedAreaTwice(ring);
    if (signedAreaTwice == 0) {
      throw const FillMeshBuildException.degenerateRing(
        reason: 'A ring has zero signed area and encloses no surface.',
      );
    }

    if (signedAreaTwice > 0) {
      polygons.add(_RawPolygon(exterior: ring));
      continue;
    }

    if (polygons.isEmpty) {
      throw const FillMeshBuildException.holeBeforeExterior(
        reason:
            'A hole ring (negative signed area) appeared before any '
            'exterior ring in the feature.',
      );
    }
    final current = polygons.last;
    if (current.holes.length >= limits.maxHolesPerPolygon) {
      throw FillMeshBuildException.limitExceeded(
        reason:
            'A polygon exceeds the configured hole limit '
            '(${limits.maxHolesPerPolygon}).',
      );
    }
    current.holes.add(ring);
  }
  return polygons;
}

/// ringの符号付き面積の2倍を整数のまま計算する。tile-local座標はint32の
/// 範囲を持ち得るため、doubleではなくint(64bit)で積算し、ゼロ判定の丸め
/// 誤差を避ける。
int _signedAreaTwice(Int32List ring) {
  final vertexCount = ring.length ~/ 2;
  var sum = 0;
  for (var i = 0; i < vertexCount; i++) {
    final x0 = ring[i * 2];
    final y0 = ring[i * 2 + 1];
    final nextIndex = (i + 1) % vertexCount;
    final x1 = ring[nextIndex * 2];
    final y1 = ring[nextIndex * 2 + 1];
    sum += x0 * y1 - x1 * y0;
  }
  return sum;
}

/// 1つのpolygon(外形+穴)を`dart_earcut`で三角形化する。
///
/// 頂点は外形→穴の順にそのまま連結するだけで、reorderingはしない
/// (`Earcut.triangulateRaw`は内部で必要な走査順を自前のlinked listへ
/// 変換するため、呼び出し側が事前に winding を揃える必要はない)。
/// 返す`triangleIndices`は連結後の頂点列に対するlocal index
/// (0-based)であり、featureへ積む際の呼び出し側でoffsetを加算する。
({List<double> vertices, List<int> triangleIndices}) _triangulatePolygon(
  _RawPolygon polygon,
) {
  final vertices = <double>[];

  void appendRing(Int32List ring) {
    final vertexCount = ring.length ~/ 2;
    for (var i = 0; i < vertexCount; i++) {
      vertices
        ..add(ring[i * 2].toDouble())
        ..add(ring[i * 2 + 1].toDouble());
    }
  }

  appendRing(polygon.exterior);
  final holeIndices = <int>[];
  var pointCount = polygon.exterior.length ~/ 2;
  for (final hole in polygon.holes) {
    holeIndices.add(pointCount);
    appendRing(hole);
    pointCount += hole.length ~/ 2;
  }

  final triangleIndices = Earcut.triangulateRaw(
    vertices,
    holeIndices: holeIndices.isEmpty ? null : holeIndices,
  );
  return (vertices: vertices, triangleIndices: triangleIndices);
}
