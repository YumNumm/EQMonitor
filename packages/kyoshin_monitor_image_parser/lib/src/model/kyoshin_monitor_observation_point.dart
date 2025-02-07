import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_observation_point.freezed.dart';
part 'kyoshin_monitor_observation_point.g.dart';

@freezed
class KyoshinMonitorObservationPoint with _$KyoshinMonitorObservationPoint {
  const factory KyoshinMonitorObservationPoint({
    required String code,
    required int x,
    required int y,
  }) = _KyoshinMonitorObservationPoint;

  factory KyoshinMonitorObservationPoint.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorObservationPointFromJson(json);
}

@freezed
class KyoshinMonitorObservationAnalyzedPoint
    with _$KyoshinMonitorObservationAnalyzedPoint {
  const factory KyoshinMonitorObservationAnalyzedPoint({
    required KyoshinMonitorObservationPoint point,
    required double scale,
    required int r,
    required int g,
    required int b,
  }) = _KyoshinMonitorObservationAnalyzedPoint;

  const KyoshinMonitorObservationAnalyzedPoint._();

  factory KyoshinMonitorObservationAnalyzedPoint.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$KyoshinMonitorObservationAnalyzedPointFromJson(json);

  double get scaleToIntensity => scale * 10 - 3;
  double get scaleToPga => math.pow(10, 5 * scale - 2).toDouble();
  double get scaleToPgv => math.pow(10, 5 * scale - 3).toDouble();
  double get scaleToPgd => math.pow(10, 5 * scale - 4).toDouble();
}
