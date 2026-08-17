import 'package:vector_tile/raw/raw_vector_tile.dart';

extension type SeismicityFixtureScalar._(VectorTile_Value raw) {
  new string(String value)
    : this._(createVectorTileValue(stringValue: value));
  new float(double value)
    : this._(createVectorTileValue(floatValue: value));
  new double(double value)
    : this._(createVectorTileValue(doubleValue: value));
  new signed(String value)
    : this._(VectorTile_Value.fromJson('{"4":"$value"}'));
  new unsigned(String value)
    : this._(VectorTile_Value.fromJson('{"5":"$value"}'));
  new zigZagSigned(String value)
    : this._(VectorTile_Value.fromJson('{"6":"$value"}'));
  new boolean({required bool value})
    : this._(createVectorTileValue(boolValue: value));
  new multiple({
    required SeismicityFixtureScalar first,
    required SeismicityFixtureScalar second,
  }) : this._(first.raw.deepCopy()..mergeFromMessage(second.raw));
}

final class SeismicityMvtFixtureBuilder {
  List<int> build({
    required String layerName,
    required int layerVersion,
    required int layerExtent,
    required String featureId,
    required List<int> featureTags,
    required VectorTile_GeomType featureType,
    required ({int x, int y}) point,
    required List<String> keys,
    required List<SeismicityFixtureScalar> values,
  }) {
    final feature = createVectorTileFeature(
      type: featureType,
      tags: featureTags,
      geometry: encodeSeismicityFixturePoint(x: point.x, y: point.y),
    )..mergeFromJson('{"1":"$featureId"}');
    final layer = createVectorTileLayer(
      name: layerName,
      version: layerVersion,
      extent: layerExtent,
      keys: keys,
      values: values.map((value) => value.raw).toList(growable: false),
      features: [feature],
    );
    return createVectorTile(layers: [layer]).writeToBuffer();
  }
}

List<int> encodeSeismicityFixturePoint({required int x, required int y}) => [
  9,
  (x << 1) ^ (x >> 63),
  (y << 1) ^ (y >> 63),
];
