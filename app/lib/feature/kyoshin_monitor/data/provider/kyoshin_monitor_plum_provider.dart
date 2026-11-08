import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_plum_calculator.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_plum_observation_reader.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_image_request_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_plum_provider.g.dart';

@riverpod
KyoshinMonitorPlumObservationReader kyoshinMonitorPlumObservationReader(
  Ref ref,
) => const KyoshinMonitorPlumObservationReader();

@riverpod
KyoshinMonitorPlumCalculator kyoshinMonitorPlumCalculator(Ref ref) =>
    const KyoshinMonitorPlumCalculator();

/// PLUM 法の予測震度表示を選べるか。
///
/// 入力にリアルタイム震度 (地表) を使うため、それ以外のデータ種別・レイヤーでは使えない。
@riverpod
bool kyoshinMonitorPlumAvailable(Ref ref) {
  final settings = ref.watch(kyoshinMonitorSettingsProvider).value;
  if (settings == null ||
      !settings.useKmoni ||
      settings.realtimeDataType != RealtimeDataType.shindo) {
    return false;
  }
  final request = ref.watch(kyoshinMonitorImageRequestProvider);
  return request.layer == RealtimeLayer.surface;
}

/// PLUM 法の予測震度表示が有効か。
@riverpod
bool kyoshinMonitorPlumEnabled(Ref ref) {
  final isAvailable = ref.watch(kyoshinMonitorPlumAvailableProvider);
  final showPlumIntensity = ref.watch(
    kyoshinMonitorSettingsProvider.select(
      (value) => value.value?.showPlumIntensity ?? false,
    ),
  );
  return isAvailable && showPlumIntensity;
}

/// 強震モニタのリアルタイム震度から PLUM 法で予測した細分区域ごとの震度。
///
/// 地図の震度塗りレイヤーへそのまま渡せるよう [EewForecastRegionInfo] で返す。
@riverpod
List<EewForecastRegionInfo> kyoshinMonitorPlumForecastRegions(Ref ref) {
  if (!ref.watch(kyoshinMonitorPlumEnabledProvider)) {
    return const [];
  }
  final snapshot = ref.watch(
    kyoshinMonitorProvider.select(
      (value) => (
        geoJson: value.value?.geoJson,
        dataType: value.value?.currentRealtimeDataType,
        layer: value.value?.currentRealtimeLayer,
      ),
    ),
  );
  final geoJson = snapshot.geoJson;
  // 設定を切り替えた直後は前のデータ種別の画像が残るため、入力を確認する。
  if (geoJson == null ||
      snapshot.dataType != RealtimeDataType.shindo ||
      snapshot.layer != RealtimeLayer.surface) {
    return const [];
  }
  final stationIndex = ref.watch(estimatedIntensityStationIndexProvider).value;
  if (stationIndex == null) {
    return const [];
  }

  final observations = ref
      .watch(kyoshinMonitorPlumObservationReaderProvider)
      .read(geoJson);
  final regions = ref
      .watch(kyoshinMonitorPlumCalculatorProvider)
      .calculate(
        observations: observations,
        targets: stationIndex.regionStations,
      );
  return [
    for (final region in regions)
      EewForecastRegionInfo(
        code: region.regionCode,
        name: region.regionName,
        isPlum: true,
        isWarning: false,
        intensity: JmaIntensityFromRawKnetInt.fromRawKnetInt(region.intensity),
        intensityIsOver: false,
      ),
  ];
}
