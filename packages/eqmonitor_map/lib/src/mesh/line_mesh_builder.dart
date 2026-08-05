import 'dart:math' as math;
import 'dart:typed_data';

import 'package:eqmonitor_map/src/mesh/line_mesh.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_build_exception.dart';
import 'package:eqmonitor_map/src/mesh/line_mesh_builder_limits.dart';
import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';

/// index bufferがUint16のため、1つの[LineMesh] segmentが持てる頂点数の
/// 絶対上限。index値0〜65535が指せる頂点は65536個。
const _maxIndexableVerticesPerSegment = 65536;

/// 隣接segmentの単位法線の和(`prevNormal + nextNormal`)がほぼ0ベクトルに
/// なる場合、joinNormalの向きが数値的に不定になる(2つのsegmentがほぼ真逆を
/// 向く「折り返し」)。単位法線同士の和のノルムで判定するため、float32の
/// 丸め誤差より十分大きく実用上の折り返しだけを拾える値として1e-6を選ぶ。
/// この場合はprevNormalをそのまま(miterLength=1で)使い、joinNormalの向きが
/// 不定になってNaN/Infinityを生む代わりに、butt capと同じ扱いへ落とす
/// (MapLibreはこのケースをBevelへ切り替えるが、本実装はbevelを実装しない
/// 方針のため、代わりにこのfallbackで安全側に倒す)。
const _antiParallelEpsilon = 1e-6;

/// [MvtFeature.rings](MVT decoderが出力するtile-local座標のring列。
/// `MvtGeometryType.lineString`ではringごとに1本のLineStringになる)から
/// [LineMesh]を組み立てる。
///
/// joinはmiterのみ、capはbuttのみ実装する
/// (docs/knowledge/20260805_maplibre_native_renderer_reference.md
/// 「Line頂点生成」節。bevel/round/dash/linesofarは実装しない)。頂点属性は
/// float32のみとし、MapLibreの6 byte packing(押し出し法線をint8へ量子化する
/// 方式)は採用しない(同docの「採用しないもの」節。`gpu.VertexFormat`の
/// int16/uint8正規化対応が未検証のため)。
///
/// Douglas-Peuckerによる間引きはこのbuilderでは実装しない。間引きを後段で
/// 挿入できるよう、入力は[MvtFeature.rings]のring座標列のまま受け取り、
/// builder内部では頂点の除去(重複・零長segment)以外に座標を生成・加工
/// しない。
final class LineMeshBuilder {
  LineMeshBuilder({required this.limits, required this.miterLimit}) {
    if (limits.maxVerticesPerSegment <= 0 ||
        limits.maxVerticesPerSegment > _maxIndexableVerticesPerSegment) {
      throw ArgumentError.value(
        limits.maxVerticesPerSegment,
        'limits.maxVerticesPerSegment',
        'must be within 1..$_maxIndexableVerticesPerSegment because indices '
            'are stored as Uint16.',
      );
    }
    if (miterLimit < 1) {
      // 直線部分・capのmiterLengthは常に1であり(cosHalfAngle == 1)、
      // miterLengthが1を下回ることはない。1未満のlimitを許すと直線部分まで
      // clampしてしまい、素直な押し出しすら細くなってしまうため拒否する。
      throw ArgumentError.value(
        miterLimit,
        'miterLimit',
        'must be >= 1 because miterLength never falls below 1 for a '
            'straight segment or a butt-capped endpoint.',
      );
    }
  }

  final LineMeshBuilderLimits limits;

  /// miter joinの押し出し長(`miterLength = 1 / cosHalfAngle`)の上限。
  /// これを超えるjoinは、MapLibreのようにbevel三角形を追加する代わりに
  /// 押し出し長だけをこの値でclampする(brief記載の意図的な簡略化。鋭角では
  /// 見た目が崩れることを許容し、後段でbevelを追加できる形にしておく)。
  final double miterLimit;

  /// [features]をtile-local座標のline meshへ変換する。全featureの頂点が
  /// 1 segmentに収まらない場合、featureの境界でのみ分割した複数の
  /// [LineMesh]を返す(1つのfeatureが複数segmentへまたがることはない、
  /// `FillMeshBuilder.build`と同じ規則)。
  ///
  /// [features]はすべて[MvtGeometryType.lineString]でなければならない。
  /// 呼び出し側がlayerからLineString featureだけを選んで渡す契約であり、
  /// それ以外の型が混じっているのは呼び出し側の実装誤りなので
  /// [ArgumentError]で落とす([LineMeshBuildException]は入力データ
  /// (untrusted tile bytes)由来の問題専用に予約する)。
  List<LineMesh> build(Iterable<MvtFeature> features) {
    final segments = <LineMesh>[];
    var positions = <double>[];
    var extrudes = <double>[];
    var indices = <int>[];

    void flush() {
      if (positions.isEmpty) {
        return;
      }
      segments.add(
        LineMesh(
          positions: Float32List.fromList(positions),
          extrudes: Float32List.fromList(extrudes),
          indices: Uint16List.fromList(indices),
          vertexCount: positions.length ~/ 2,
        ),
      );
      positions = <double>[];
      extrudes = <double>[];
      indices = <int>[];
    }

    for (final feature in features) {
      if (feature.type != MvtGeometryType.lineString) {
        throw ArgumentError.value(
          feature.type,
          'features',
          'LineMeshBuilder only accepts MvtGeometryType.lineString '
              'features.',
        );
      }

      final featurePositions = <double>[];
      final featureExtrudes = <double>[];
      final featureIndices = <int>[];
      var localOffset = 0;
      for (final ring in feature.rings) {
        final built = _buildRing(ring, miterLimit: miterLimit);
        if (built == null) {
          // dedup後に頂点2未満。このringはmeshへ出さず、featureの他の
          // ringだけで処理を続ける(brief記載: 「除去後に頂点2未満になった
          // lineはmeshへ出さない」)。
          continue;
        }
        featurePositions.addAll(built.positions);
        featureExtrudes.addAll(built.extrudes);
        for (final index in built.indices) {
          featureIndices.add(index + localOffset);
        }
        localOffset += built.positions.length ~/ 2;
      }

      final featureVertexCount = featurePositions.length ~/ 2;
      if (featureVertexCount == 0) {
        // featureの全ringが頂点2未満でskipされた。
        continue;
      }
      if (featureVertexCount > limits.maxVerticesPerSegment) {
        throw LineMeshBuildException.limitExceeded(
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
      extrudes.addAll(featureExtrudes);
      for (final index in featureIndices) {
        indices.add(index + offset);
      }
    }

    flush();
    return segments;
  }
}

/// 1本のringを[LineMesh]の断片(このring単独でのlocal 0-based index)へ
/// 変換する。頂点2未満(dedup後)の場合は`null`を返す。
({List<double> positions, List<double> extrudes, List<int> indices})?
_buildRing(Int32List ring, {required double miterLimit}) {
  final deduped = _dedupeRing(ring);
  final xs = deduped.xs;
  final ys = deduped.ys;
  final n = xs.length;
  if (n < 2) {
    return null;
  }
  final isClosed = deduped.isClosed;

  // segmentCountは「点の数」ではなく「辺の数」。開いたlineはn点でn-1辺、
  // 閉じたring(先頭末尾が同一座標で、dedupeRingが既に末尾の重複を除去済み)
  // はn点でn辺(最後の点から先頭点へ戻る辺を含む)。
  final segmentCount = isClosed ? n : n - 1;
  final segmentNormalX = Float64List(segmentCount);
  final segmentNormalY = Float64List(segmentCount);
  for (var k = 0; k < segmentCount; k++) {
    final a = k;
    final b = isClosed ? (k + 1) % n : k + 1;
    final dx = xs[b] - xs[a];
    final dy = ys[b] - ys[a];
    // dedupeRingが連続する重複頂点と、閉路の閉じ辺の重複(先頭==末尾)を
    // 除去済みのため、ここでのsegment長は常に非0であることが保証される。
    final length = math.sqrt(dx * dx + dy * dy);
    segmentNormalX[k] = -dy / length;
    segmentNormalY[k] = dx / length;
  }

  final positions = List<double>.filled(n * 4, 0);
  final extrudes = List<double>.filled(n * 4, 0);

  for (var i = 0; i < n; i++) {
    double extrudeX;
    double extrudeY;
    if (!isClosed && i == 0) {
      // 開いたlineの始点。隣接segmentが1つしかないためjoinを計算せず、
      // そのsegmentの法線をそのまま使う(butt cap、miterLength == 1相当)。
      extrudeX = segmentNormalX[0];
      extrudeY = segmentNormalY[0];
    } else if (!isClosed && i == n - 1) {
      // 開いたlineの終点。始点と対称にsegmentCount-1番目のsegmentの
      // 法線をそのまま使う。
      extrudeX = segmentNormalX[segmentCount - 1];
      extrudeY = segmentNormalY[segmentCount - 1];
    } else {
      // 閉路の全頂点、または開いたlineの内部頂点。prevSegmentとnext
      // segmentはisClosedの場合だけmod segmentCountでwrapする
      // (閉路の頂点0はsegmentCount-1番目のsegment(最後の点から頂点0へ
      // 戻る閉じ辺)とsegment 0の間のjoinになる)。
      final prevSegment = isClosed
          ? (i - 1 + segmentCount) % segmentCount
          : i - 1;
      final nextSegment = isClosed ? i % segmentCount : i;
      final prevX = segmentNormalX[prevSegment];
      final prevY = segmentNormalY[prevSegment];
      final nextX = segmentNormalX[nextSegment];
      final nextY = segmentNormalY[nextSegment];

      final sumX = prevX + nextX;
      final sumY = prevY + nextY;
      final sumLength = math.sqrt(sumX * sumX + sumY * sumY);

      double joinX;
      double joinY;
      double miterLength;
      if (sumLength < _antiParallelEpsilon) {
        joinX = prevX;
        joinY = prevY;
        miterLength = 1;
      } else {
        // joinNormal = normalize(prevNormal + nextNormal)。
        // |prevNormal + nextNormal| == 2 * cos(halfAngle) (halfAngleは
        // prevNormalとnextNormalのなす角の半分、すなわちsegment同士の
        // turn angleの半分)であるため、miterLength == 1 / cosHalfAngle
        // == 2 / sumLength で求まる
        // (docs/knowledge/20260805_maplibre_native_renderer_reference.md
        // 「Line頂点生成」節)。
        joinX = sumX / sumLength;
        joinY = sumY / sumLength;
        miterLength = 2 / sumLength;
      }

      final clampedLength = miterLength > miterLimit ? miterLimit : miterLength;
      extrudeX = joinX * clampedLength;
      extrudeY = joinY * clampedLength;
    }

    final x = xs[i];
    final y = ys[i];
    // 中心線の同じ座標を2頂点分格納し、押し出し法線を+/-反転させることで
    // 線の両側(plus側/minus側)を表す。押し出し自体はshader側が
    // `position + extrude * halfWidth`として行う想定であり、ここでは
    // 中心線座標と押し出し法線だけを持つ。
    positions[i * 4] = x;
    positions[i * 4 + 1] = y;
    positions[i * 4 + 2] = x;
    positions[i * 4 + 3] = y;
    extrudes[i * 4] = extrudeX;
    extrudes[i * 4 + 1] = extrudeY;
    extrudes[i * 4 + 2] = -extrudeX;
    extrudes[i * 4 + 3] = -extrudeY;
  }

  final indices = <int>[];
  for (var k = 0; k < segmentCount; k++) {
    final a = k;
    final b = isClosed ? (k + 1) % n : k + 1;
    // 点a, bそれぞれのplus側頂点(2a, 2b)とminus側頂点(2a+1, 2b+1)が
    // 作る四角形を、対角線(aのminus側 - bのplus側)で2つのtriangleへ
    // 明示的に分割する(triangle stripは使わない)。
    final aPlus = a * 2;
    final aMinus = a * 2 + 1;
    final bPlus = b * 2;
    final bMinus = b * 2 + 1;
    indices
      ..add(aPlus)
      ..add(aMinus)
      ..add(bPlus)
      ..add(aMinus)
      ..add(bMinus)
      ..add(bPlus);
  }

  return (positions: positions, extrudes: extrudes, indices: indices);
}

/// ringの連続する重複頂点と、それによって生じる長さ0のsegmentを除去する。
///
/// 併せて、除去後の先頭と末尾が同一座標であれば「閉じたring(閉路)」と
/// みなし、冗長な末尾の点を取り除いた上で`isClosed: true`を返す
/// (末尾の点は先頭と同一座標であり、閉路のjoin計算はwrap-aroundで
/// 表現するため、別頂点として保持する必要がない)。
({List<double> xs, List<double> ys, bool isClosed}) _dedupeRing(
  Int32List ring,
) {
  final rawCount = ring.length ~/ 2;
  final xs = <double>[];
  final ys = <double>[];
  for (var i = 0; i < rawCount; i++) {
    final x = ring[i * 2].toDouble();
    final y = ring[i * 2 + 1].toDouble();
    if (xs.isNotEmpty && xs.last == x && ys.last == y) {
      continue;
    }
    xs.add(x);
    ys.add(y);
  }

  var isClosed = false;
  if (xs.length >= 2 && xs.first == xs.last && ys.first == ys.last) {
    isClosed = true;
    xs.removeLast();
    ys.removeLast();
  }

  return (xs: xs, ys: ys, isClosed: isClosed);
}
