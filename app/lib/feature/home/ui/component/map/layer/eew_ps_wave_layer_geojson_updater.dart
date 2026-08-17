import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';

/// P波/S波レイヤーの GeoJSON ソースを差分更新する。
class EewPsWaveLayerGeoJsonUpdater {
  const EewPsWaveLayerGeoJsonUpdater();

  Future<void> updateIfChanged({
    required StyleController styleController,
    required String pWaveSourceId,
    required String sWaveSourceId,
    required String pWaveGeojson,
    required String sWaveGeojson,
    required ObjectRef<String?> latestPWaveGeoJson,
    required ObjectRef<String?> latestSWaveGeoJson,
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
    final shouldUpdatePWave = latestPWaveGeoJson.value != pWaveGeojson;
    final shouldUpdateSWave = latestSWaveGeoJson.value != sWaveGeojson;
    if (!shouldUpdatePWave && !shouldUpdateSWave) {
      return;
    }

    if (shouldUpdatePWave) {
      try {
        await styleController.updateGeoJsonSource(
          id: pWaveSourceId,
          data: pWaveGeojson,
        );
        latestPWaveGeoJson.value = pWaveGeojson;
      } catch (e, stackTrace) {
        talker.handle(e, stackTrace);
      }
    }
    if (disposed.value) {
      return;
    }

    if (shouldUpdateSWave) {
      try {
        await styleController.updateGeoJsonSource(
          id: sWaveSourceId,
          data: sWaveGeojson,
        );
        latestSWaveGeoJson.value = sWaveGeojson;
      } catch (e, stackTrace) {
        talker.handle(e, stackTrace);
      }
    }
  }
}
