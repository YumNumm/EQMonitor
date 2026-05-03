import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_provider.g.dart';

final _prefectureRegex = RegExp(r'^(.+?[都道府県])(.+)$');

/// 揺れ検知イベントのバウンディングボックス内に含まれる観測点の
/// region 文字列を都道府県ごとにグループ化して返す。
///
/// キー: 都道府県名（例: "岩手県"）
/// 値: 地域名のリスト（例: ["沿岸北部", "内陸北部"]）
@riverpod
Future<Map<String, List<String>>> shakeDetectionRegions(
  Ref ref,
  ShakeDetectionEvent event,
) async {
  final points =
      await ref.watch(kyoshinObservationPointsProvider.future);

  final grouped = <String, Set<String>>{};

  for (final point in points.points) {
    final lat = point.location.latitude;
    final lng = point.location.longitude;
    if (lat < event.minLat ||
        lat > event.maxLat ||
        lng < event.minLng ||
        lng > event.maxLng) {
      continue;
    }

    final match = _prefectureRegex.firstMatch(point.region);
    if (match == null) {
      continue;
    }

    final prefecture = match.group(1)!;
    final subRegion = match.group(2)!;
    (grouped[prefecture] ??= {}).add(subRegion);
  }

  return {
    for (final entry in grouped.entries)
      entry.key: entry.value.toList()..sort(),
  };
}
