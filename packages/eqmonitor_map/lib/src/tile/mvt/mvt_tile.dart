import 'dart:typed_data';

/// MVT (Mapbox Vector Tile) のgeometry type。GeomType enumのUNKNOWN(0)は
/// styling不能なため受理しない。
enum MvtGeometryType {
  point,
  lineString,
  polygon,
}

/// decode結果のtile。frame hot pathで毎tile生成されるdecode結果であり
/// 永続化しないため、Freezedにはしない。
final class const MvtTile({required final List<MvtLayer> layers});

final class const MvtLayer({
  required final String name,
  required final int version,
  required final int extent,
  required final List<MvtFeature> features,
});

final class const MvtFeature({
  required final MvtGeometryType type,

  /// ringごとにx, yを交互に詰めたtile-local座標。Pointはpartが1つの
  /// ringとして入り、LineString/Polygonはpart(ring)ごとに1要素になる。
  required final List<Int32List> rings,

  /// MVTのtag/key/value tableから解決した文字列property。
  required final Map<String, String> properties,
});
