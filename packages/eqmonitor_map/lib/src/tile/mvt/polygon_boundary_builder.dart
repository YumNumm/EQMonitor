import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/mvt/mvt_tile.dart';

/// Polygon の ring を閉じた LineString として再利用可能にする変換器。
///
/// MVT Polygon は ClosePath を終端の重複座標として保持しないため、境界線の
/// 最後の一辺を line mesh の利用側へ伝えるには始点の複製が必要。
final class PolygonBoundaryBuilder {
  const new();

  MvtFeature build({required MvtFeature feature}) {
    if (feature.type != MvtGeometryType.polygon) {
      throw ArgumentError.value(feature.type, 'feature', 'must be polygon');
    }
    return MvtFeature(
      type: MvtGeometryType.lineString,
      rings: List.unmodifiable([
        for (final ring in feature.rings)
          Int32List(ring.length + 2)
            ..setRange(0, ring.length, ring)
            ..[ring.length] = ring[0]
            ..[ring.length + 1] = ring[1],
      ]),
      properties: feature.properties,
    );
  }
}
