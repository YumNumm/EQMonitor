import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_provider.g.dart';

/// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
/// 都道府県ごとの地域名リストを返す。
///
/// キー: 都道府県名（例: "岩手県"）
/// 値: EEW予報区名のリスト（例: ["岩手県沿岸北部", "岩手県内陸北部"]）
@riverpod
Future<Map<String, List<String>>> shakeDetectionRegions(
  Ref ref,
  ShakeDetectionEvent event,
) async {
  final points = await ref.watch(kyoshinObservationPointsProvider.future);
  final codeTable = await ref.watch(jmaCodeTableProvider.future);

  final prefectureItems =
      codeTable.codeTables.areaInformationPrefectureEarthquake;
  final eewAreaItems = codeTable.codeTables.areaForecastLocalEew;

  final grouped = <String, Set<String>>{};

  for (final point in points.points) {
    final lat = point.location.lat;
    final lng = point.location.lon;
    if (lat < event.minLat ||
        lat > event.maxLat ||
        lng < event.minLng ||
        lng > event.maxLng) {
      continue;
    }

    final prefCode = point.prefectureCode;
    final regionCode = point.regionCode;
    if (prefCode == null || regionCode == null) {
      continue;
    }

    final prefName = prefectureItems
        .where((p) => p.code == prefCode)
        .firstOrNull
        ?.name
        .ja;
    final regionName = eewAreaItems
        .where((r) => r.code == regionCode)
        .firstOrNull
        ?.name
        .ja;

    if (prefName == null || regionName == null) {
      continue;
    }

    (grouped[prefName] ??= {}).add(regionName);
  }

  return {
    for (final entry in grouped.entries)
      entry.key: entry.value.toList()..sort(),
  };
}
