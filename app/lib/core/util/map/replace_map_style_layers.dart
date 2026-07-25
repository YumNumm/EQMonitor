import 'package:maplibre/maplibre.dart';

typedef MapStyleLayerEntry = ({
  StyleLayer layer,
  String? belowLayerId,
  String? aboveLayerId,
  int? atIndex,
});

/// 固定 ID の MapLibre layer を、既存 layer の残留に強い形で置き換える。
Future<void> replaceMapStyleLayers({
  required StyleController styleController,
  required Iterable<String> layerIds,
  required Iterable<MapStyleLayerEntry> layers,
}) async {
  for (final id in layerIds) {
    try {
      await styleController.removeLayer(id);
    } on Exception {
      // 追加前の掃除なので、未存在 layer の削除失敗は無視する。
    }
  }

  for (final entry in layers) {
    await styleController.addLayer(
      entry.layer,
      belowLayerId: entry.belowLayerId,
      aboveLayerId: entry.aboveLayerId,
      atIndex: entry.atIndex,
    );
  }
}
