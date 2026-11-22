import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:maplibre/maplibre.dart';

/// MapLibre のリソースを layer → source → image の順で独立して破棄する。
class const MapStyleResourceRemover._() {
  static Future<void> remove({
    required StyleController styleController,
    List<String> layerIds = const [],
    List<String> sourceIds = const [],
    List<String> imageIds = const [],
  }) async {
    for (final id in layerIds) {
      try {
        await styleController.layers.remove(id);
      } on Exception catch (error, stackTrace) {
        talker.handle(error, stackTrace);
      }
    }
    for (final id in sourceIds) {
      try {
        await styleController.sources.remove(id);
        // 0.4 は使用中の source の削除を StateError で拒否する。
        // ignore: avoid_catching_errors
      } on StateError catch (error, stackTrace) {
        talker.handle(error, stackTrace);
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
}
