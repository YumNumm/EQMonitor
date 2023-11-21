import 'dart:math' as math;

import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:latlong2/latlong.dart' as lat_long_2;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_data_source.g.dart';

@Riverpod(keepAlive: true)
EstimatedIntensityDataSource estimatedIntensityDataSource(
  EstimatedIntensityDataSourceRef ref,
) =>
    EstimatedIntensityDataSource();

class EstimatedIntensityDataSource {
  List<AnalyzedKmoniObservationPoint> getEstimatedIntensity({
    required List<KmoniObservationPoint> points,
    required double jmaMagnitude,
    required int depth,
    required LatLng hypocenter,
  }) {
    // Mjma(気象庁マグニチュード)->Mw(モーメントマグニチュード)
    // 宇津(1982)の経験式を用いる
    final momentMagnitude = jmaMagnitude - 0.171;
    // 断層長計算(半径)
    final faultLength = math.pow(10, 0.5 * momentMagnitude - 1.85) / 2;
    final result = <AnalyzedKmoniObservationPoint>[];
    const distanceCalcular = lat_long_2.Distance();
    for (final point in points) {
      final epicenterDistance = distanceCalcular.as(
            lat_long_2.LengthUnit.Kilometer,
            lat_long_2.LatLng(point.latLng.lat, point.latLng.lon),
            lat_long_2.LatLng(hypocenter.lat, hypocenter.lon),
          ) -
          faultLength;
      // 断層長を引いた震源距離を求める
      final distance =
          math.pow(math.pow(depth, 2) + math.pow(epicenterDistance, 2), 0.5) -
              faultLength;
      // 計算で利用する震源距離の最短は3kmなので、大きいほうをとる
      final x = math.max(distance, 3);
      // 工学基板上(Vs=600m/s)での最大速度の推定
      final gpv600 = math.pow(
        10,
        (0.58 * momentMagnitude +
                0.0038 * depth -
                1.29 -
                log10(x + 0.0028 * (math.pow(10, 0.5 * momentMagnitude)))) -
            0.002 * x,
      );

      // 予測する地点の工学的基盤（Vs=400m/s）から地表に至る最大速度の増幅率
      final arv = point.arv;
      // 最大速度を工学的基盤（Vs=600m/s）から工学的基盤（Vs=400m/s）へ変換を行う
      final pgv400 = gpv600 * 1.31;
      // 地表面での推定最大速度を求めます
      final pgv = pgv400 * arv;

      //* 予測する地点の地表面推定最大速度から計測震度への変換
      final intensity = 2.68 + 1.72 * log10(pgv);
      result.add(
        AnalyzedKmoniObservationPoint(
          point: point,
          intensityValue: intensity,
        ),
      );
    }
    return result;
  }
}

double log10(num x) => math.log(x) / math.ln10;
