import 'package:maplibre/maplibre.dart';

typedef MapStyleLayerEntry = ({StyleLayer layer, String? belowLayerId});

/// 固定 ID の MapLibre layer を、既存 layer の残留に強い形で置き換える。
class const MapStyleLayerReplacer._() {
  static Future<void> replace({
    required StyleController styleController,
    required Iterable<String> layerIds,
    required Iterable<MapStyleLayerEntry> layers,
  }) async {
    for (final id in layerIds) {
      await styleController.layers.remove(id);
    }

    for (final entry in layers) {
      await styleController.layers.add(
        entry.layer,
        belowLayerId: entry.belowLayerId,
      );
    }
  }
}
