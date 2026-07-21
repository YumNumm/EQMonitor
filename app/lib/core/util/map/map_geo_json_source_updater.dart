import 'package:maplibre/maplibre.dart';

/// GeoJSON source の初期化完了待機と重複更新抑止を担う。
class MapGeoJsonSourceUpdater {
  String? _latestGeoJson;

  Future<void> update({
    required StyleController styleController,
    required String sourceId,
    required String geoJson,
    required Future<void>? initialization,
    required bool Function() isDisposed,
  }) async {
    if (initialization != null) {
      await initialization;
    }
    if (isDisposed() || _latestGeoJson == geoJson) {
      return;
    }
    await styleController.updateGeoJsonSource(id: sourceId, data: geoJson);
    _latestGeoJson = geoJson;
  }

  void reset() => _latestGeoJson = null;
}
