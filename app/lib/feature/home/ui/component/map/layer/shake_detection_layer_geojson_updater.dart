import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';

/// 揺れ検知レイヤーの GeoJSON ソースを差分更新する。
class ShakeDetectionLayerGeoJsonUpdater {
  const ShakeDetectionLayerGeoJsonUpdater();

  Future<void> updateIfChanged({
    required StyleController styleController,
    required String sourceId,
    required String geoJson,
    required ObjectRef<String?> latestGeoJson,
    required ObjectRef<Future<void>?> initFuture,
    required ObjectRef<bool> disposed,
  }) async {
    // 初期化(source/layer 追加)の完了を待つ。この await 中に破棄処理
    // (source/layer 削除)が完了する可能性があるため、await 後に必ず
    // disposed を再チェックしてから styleController を操作する。
    await initFuture.value;
    if (disposed.value) {
      return;
    }
    if (latestGeoJson.value == geoJson) {
      return;
    }
    try {
      await styleController.updateGeoJsonSource(id: sourceId, data: geoJson);
      latestGeoJson.value = geoJson;
    } catch (e, stackTrace) {
      talker.handle(e, stackTrace);
    }
  }
}
