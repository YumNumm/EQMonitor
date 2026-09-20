import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_fill_layer_action.g.dart';

@riverpod
IntensityFillLayerAction intensityFillLayerAction(Ref ref) =>
    const IntensityFillLayerAction();

class const IntensityFillLayerAction() {
  Future<void> replace({
    required StyleController styleController,
    required Iterable<String> layerIds,
    required Iterable<MapStyleLayerEntry> layers,
  }) async {
    try {
      await MapStyleLayerReplacer.replace(
        styleController: styleController,
        layerIds: layerIds,
        layers: layers,
      );
    } on Object catch (error, stackTrace) {
      talker.handle(
        error,
        stackTrace,
        'IntensityFillLayer: failed to add ${layerIds.join(', ')}',
      );
    }
  }

  Future<void> removeAll({
    required StyleController styleController,
    required Iterable<String> layerIds,
  }) async {
    for (final id in layerIds.toList().reversed) {
      try {
        await styleController.removeLayer(id);
      } on Object catch (error, stackTrace) {
        talker.handle(
          error,
          stackTrace,
          'IntensityFillLayer: failed to remove $id',
        );
      }
    }
  }
}
