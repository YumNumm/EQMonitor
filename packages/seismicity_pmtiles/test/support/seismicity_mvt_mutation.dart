import 'package:vector_tile/raw/raw_vector_tile.dart';

extension SeismicityMvtMutation on List<int> {
  List<int> replaceMvtLayer({
    required int at,
    required VectorTile_Layer layer,
  }) => (VectorTile.fromBuffer(this)..layers[at] = layer).writeToBuffer();

  List<int> removeMvtLayer({required int at}) =>
      (VectorTile.fromBuffer(this)..layers.removeAt(at)).writeToBuffer();

  List<int> appendMvtLayer({required VectorTile_Layer layer}) =>
      (VectorTile.fromBuffer(this)..layers.add(layer)).writeToBuffer();

  List<int> replaceMvtFeature({
    required int layerAt,
    required int featureAt,
    List<int>? tags,
    List<int>? geometry,
    VectorTile_GeomType? type,
  }) {
    final tile = VectorTile.fromBuffer(this);
    final feature = tile.layers[layerAt].features[featureAt];
    if (tags != null) {
      feature.tags.replaceRange(0, feature.tags.length, tags);
    }
    if (geometry != null) {
      feature.geometry.replaceRange(0, feature.geometry.length, geometry);
    }
    if (type != null) {
      feature.type = type;
    }
    return tile.writeToBuffer();
  }

  List<int> replaceMvtValue({
    required int layerAt,
    required int valueAt,
    required VectorTile_Value value,
  }) => (VectorTile.fromBuffer(
    this,
  )..layers[layerAt].values[valueAt] = value).writeToBuffer();

  List<int> truncateMvtBytes({required int length}) => sublist(0, length);
}
