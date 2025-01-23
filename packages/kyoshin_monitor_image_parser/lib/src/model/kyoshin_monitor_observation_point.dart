import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart';

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
    @JsonKey(fromJson: _colorFromJson, toJson: _colorToJson)
    required ColorInt8 color,
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

ColorInt8 _colorFromJson(Map<String, dynamic> json) => ColorInt8.rgb(
      json['r'] as int,
      json['g'] as int,
      json['b'] as int,
    );

Map<String, dynamic> _colorToJson(ColorInt8 color) => {
      'r': color.r,
      'g': color.g,
      'b': color.b,
    };
