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
final class MvtTile {
  const MvtTile({required this.layers});

  final List<MvtLayer> layers;
}

final class MvtLayer {
  const MvtLayer({
    required this.name,
    required this.version,
    required this.extent,
    required this.features,
  });

  final String name;
  final int version;
  final int extent;
  final List<MvtFeature> features;
}

/// properties(tag/key/value)とfeature IDはwire上ではskipするが、この
/// 縦切りではlayer名だけでstylingが足りるためモデルへ持たせない。
final class MvtFeature {
  const MvtFeature({required this.type, required this.rings});

  final MvtGeometryType type;

  /// ringごとにx, yを交互に詰めたtile-local座標。Pointはpartが1つの
  /// ringとして入り、LineString/Polygonはpart(ring)ごとに1要素になる。
  final List<Int32List> rings;
}
