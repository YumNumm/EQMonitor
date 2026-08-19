import 'package:geolocator/geolocator.dart';

/// 現在地を市区町村単位で扱うために要求する水平精度の上限（メートル）。
///
/// 市街地の市区町村界は数百m間隔で並ぶため、これより粗い測位を市区町村判定に
/// 使うと隣接市区町村の震度を「現在地の震度」として表示してしまう。
const currentLocationCityAccuracyThresholdMeters = 500.0;

/// 現在地をどの粒度まで信用してよいか。
enum CurrentLocationPrecision {
  /// 市区町村まで一意に決めてよい。
  city,

  /// 市区町村までは決められないため、細分区域に留める。
  region,
}

/// 権限の精度と実測の水平精度から、現在地を扱える粒度を決める。
final class CurrentLocationPrecisionResolver {
  const new();

  /// - [accuracyStatus] が [LocationAccuracyStatus.precise] でない場合、
  ///   OS が座標自体をぼかすため市区町村は決められない。
  /// - [horizontalAccuracyMeters] が不明（iOS は無効値として負数を返す）または
  ///   [currentLocationCityAccuracyThresholdMeters] より粗い場合も同様。
  CurrentLocationPrecision resolve({
    required LocationAccuracyStatus? accuracyStatus,
    required double? horizontalAccuracyMeters,
  }) {
    if (accuracyStatus != LocationAccuracyStatus.precise) {
      return CurrentLocationPrecision.region;
    }
    if (horizontalAccuracyMeters == null || horizontalAccuracyMeters <= 0) {
      return CurrentLocationPrecision.region;
    }
    if (horizontalAccuracyMeters > currentLocationCityAccuracyThresholdMeters) {
      return CurrentLocationPrecision.region;
    }
    return CurrentLocationPrecision.city;
  }
}
