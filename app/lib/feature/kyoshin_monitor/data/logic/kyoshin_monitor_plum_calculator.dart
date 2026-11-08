import 'dart:math' as math;

import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_station_index.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_plum_observation.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_plum_region_intensity.dart';
import 'package:lat_lng/lat_lng.dart';

/// PLUM 法 (Propagation of Local Undamped Motion) による予測震度の計算。
///
/// 予測地点 (気象庁震度観測点) ごとに、半径 [radiusKm] 以内にある強震モニタ観測点の
/// リアルタイム震度の最大値を、距離減衰をかけずにそのまま予測震度とする。
/// 細分区域ごとに、区域内の予測地点の最大値を返す。
final class const KyoshinMonitorPlumCalculator({
  final double radiusKm = 30,
  final double minIntensity = 0.5,
}) {
  /// 緯度 1 度あたりの距離 (km)。境界ボックスによる絞り込みにだけ使う。
  static const _kmPerLatitudeDegree = 110.0;

  List<KyoshinMonitorPlumRegionIntensity> calculate({
    required List<KyoshinMonitorPlumObservation> observations,
    required List<EstimatedIntensityRegionStation> targets,
  }) {
    // 静穏時は閾値以上の観測点がほとんど無いため、先に絞り込んで計算量を抑える。
    final active = observations
        .where((observation) => observation.intensity >= minIntensity)
        .toList();
    if (active.isEmpty) {
      return const [];
    }

    final radiusMeters = radiusKm * 1000;
    final latitudeDelta = radiusKm / _kmPerLatitudeDegree;
    final regionMax = <String, KyoshinMonitorPlumRegionIntensity>{};

    for (final target in targets) {
      final latitude = target.point.lat;
      final longitude = target.point.lon;
      final longitudeDelta =
          latitudeDelta / math.max(math.cos(latitude * math.pi / 180), 0.1);
      final targetLatLng = LatLng(latitude, longitude);

      double? predicted;
      for (final observation in active) {
        if ((observation.latitude - latitude).abs() > latitudeDelta ||
            (observation.longitude - longitude).abs() > longitudeDelta) {
          continue;
        }
        if (predicted != null && observation.intensity <= predicted) {
          continue;
        }
        final distance = targetLatLng.distanceTo(
          LatLng(observation.latitude, observation.longitude),
        );
        if (distance <= radiusMeters) {
          predicted = observation.intensity;
        }
      }
      if (predicted == null) {
        continue;
      }

      final current = regionMax[target.regionCode];
      if (current == null || predicted > current.intensity) {
        regionMax[target.regionCode] = KyoshinMonitorPlumRegionIntensity(
          regionCode: target.regionCode,
          regionName: target.regionName,
          intensity: predicted,
        );
      }
    }

    return regionMax.values.toList();
  }
}
