import 'dart:math' as math;

import 'package:latlong2/latlong.dart';

import '../../schema/remote/dmdata/parameter-earthquake/parameter-earthquake.dart';
import '../../ui/theme/jma_intensity.dart';
import '../../utils/math_log.dart';

/// ## 距離減衰式による震度計算
/// ref: https://qiita.com/soshi1822/items/f5fd9ccf6830d834abc4
/// ref: https://www.data.jma.go.jp/svd/eqev/data/study-panel/tyoshuki_joho_kentokai/yoho1/sanko1.pdf
/// ref: https://www.jstage.jst.go.jp/article/segj/60/5/60_5_367/_pdf/-char/ja
class IntensityEstimateApi {
  /// ## 震度計算
  /// [jmaMagnitude] マグニチュード
  /// [depth] 深さ
  /// [hypocenter] 震央
  /// [obsPoints] 観測点
  List<EstimatedEarthquakeParameterItem> estimateIntensity({
    required double jmaMagnitude,
    required double depth,
    required LatLng hypocenter,
    required List<ParameterEarthquakeItem> obsPoints,
  }) {
    // Mjma(気象庁マグニチュード)->Mw(モーメントマグニチュード)
    // 宇津(1982)の経験式を用いる
    final momentMagnitude = jmaMagnitude - 0.171;
    // 断層長計算(半径)
    final faultLength = math.pow(10, 0.5 * momentMagnitude - 1.85) / 2;
    final estimatedKyoshinKansokutens = <EstimatedEarthquakeParameterItem>[];
    //* 各観測点毎の処理
    for (final obsPoint in obsPoints) {
      // 震央と観測点の距離を求める
      final epicenterDistance = const Distance().as(
        LengthUnit.Kilometer,
        hypocenter,
        LatLng(obsPoint.latitude, obsPoint.longitude),
      );
      // 断層長を引いた震源距離を求める
      final hypocenterDistance =
          math.pow(math.pow(depth, 2) + math.pow(epicenterDistance, 2), 0.5) -
              faultLength;
      // 計算で利用する震源距離の最短は3kmなので、大きいほうをとる
      final x = math.max(hypocenterDistance, 3);
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
      final arv = obsPoint.arv;
      // 最大速度を工学的基盤（Vs=600m/s）から工学的基盤（Vs=400m/s）へ変換を行う
      final pgv400 = gpv600 * 1.31;
      // 地表面での推定最大速度を求めます
      final pgv = pgv400 * arv;

      //* 予測する地点の地表面推定最大速度から計測震度への変換
      final intensity = 2.68 + 1.72 * log10(pgv);
      final jmaIntensity = JmaIntensity.toJmaIntensity(intensity: intensity);
      estimatedKyoshinKansokutens.add(
        EstimatedEarthquakeParameterItem(
          estimatedIntensity: intensity,
          estimatedJmaIntensity: jmaIntensity,
          name: obsPoint.name,
          arv: obsPoint.arv,
          city: obsPoint.city,
          code: obsPoint.code,
          latitude: obsPoint.latitude,
          longitude: obsPoint.longitude,
          kana: obsPoint.kana,
          noCode: obsPoint.noCode,
          owner: obsPoint.owner,
          region: obsPoint.region,
          status: obsPoint.status,
        ),
      );
    }
    return estimatedKyoshinKansokutens;
  }
}

class EstimatedEarthquakeParameterItem extends ParameterEarthquakeItem {
  EstimatedEarthquakeParameterItem({
    required super.region,
    required super.city,
    required super.noCode,
    required super.code,
    required super.name,
    required super.kana,
    required super.status,
    required super.owner,
    required super.latitude,
    required super.longitude,
    required super.arv,
    required this.estimatedIntensity,
    required this.estimatedJmaIntensity,
  });

  final double estimatedIntensity;
  final JmaIntensity estimatedJmaIntensity;
}
