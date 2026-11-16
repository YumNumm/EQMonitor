import 'dart:math' as math;

import 'package:shake_eew_correlator/src/geo_distance.dart';

/// 司・翠川(1999)の最大速度距離減衰式を経由して計測震度を予測する。
///
/// EEW から断層タイプを判定できないため、断層タイプ係数は 0 とする。
final class const SiMidorikawaIntensityEstimator({
  final GeoDistanceCalculator distance = const GeoDistanceCalculator(),
}) {
  static const _momentMagnitudeOffset = -0.171;
  static const _faultLengthMagnitude = 0.5;
  static const _faultLengthIntercept = -1.85;
  static const _pgvMagnitude = 0.58;
  static const _pgvDepth = 0.0038;
  static const _pgvDistanceScale = 0.0028;
  static const _pgvDistanceMagnitude = 0.5;
  static const _pgvAnelasticAttenuation = 0.002;
  static const _pgvIntercept = -1.29;
  static const _vs600ToVs400 = 1.31;
  static const _intensityIntercept = 2.68;
  static const _intensityLogPgv = 1.72;
  static const _minDistance = 3.0;

  double estimate({
    required double hypocenterLatitude,
    required double hypocenterLongitude,
    required double depth,
    required double magnitude,
    required double latitude,
    required double longitude,
    required double? arv,
  }) {
    final hypocentralDistance = distance.hypocentral(
      epicentralDistance: distance.epicentral(
        latitude1: hypocenterLatitude,
        longitude1: hypocenterLongitude,
        latitude2: latitude,
        longitude2: longitude,
      ),
      depth: depth,
    );
    final momentMagnitude = magnitude + _momentMagnitudeOffset;
    final faultLength = math.pow(
      10,
      _faultLengthMagnitude * momentMagnitude + _faultLengthIntercept,
    );
    final closestDistance = math.max(
      hypocentralDistance - faultLength / 2,
      _minDistance,
    );
    final logPgv600 =
        _pgvMagnitude * momentMagnitude +
        _pgvDepth * depth -
        _log10(
          closestDistance +
              _pgvDistanceScale *
                  math.pow(10, _pgvDistanceMagnitude * momentMagnitude),
        ) -
        _pgvAnelasticAttenuation * closestDistance +
        _pgvIntercept;
    final amplification = arv != null && arv > 0 && arv.isFinite ? arv : 1.0;
    final surfacePgv = math.pow(10, logPgv600) * _vs600ToVs400 * amplification;
    return _intensityIntercept + _intensityLogPgv * _log10(surfacePgv);
  }

  double _log10(num value) => math.log(value) / math.ln10;
}
