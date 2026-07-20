import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:maplibre/maplibre.dart';

/// MapLibre のリソースを layer → source → image の順で独立して破棄する。
Future<void> removeMapStyleResources({
  required StyleController styleController,
  List<String> layerIds = const [],
  List<String> sourceIds = const [],
  List<String> imageIds = const [],
}) async {
  for (final id in layerIds) {
    try {
      await styleController.removeLayer(id);
    } on Exception catch (error, stackTrace) {
      talker.handle(error, stackTrace);
    }
  }
  for (final id in sourceIds) {
    try {
      await styleController.removeSource(id);
    } on Exception catch (error, stackTrace) {
      talker.handle(error, stackTrace);
    }
  }
  for (final id in imageIds) {
    try {
      await styleController.removeImage(id);
    } on Exception catch (error, stackTrace) {
      talker.handle(error, stackTrace);
    }
  }
}
