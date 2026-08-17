import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_observation_point.freezed.dart';
part 'kyoshin_monitor_observation_point.g.dart';

@freezed
abstract class KyoshinMonitorObservationPoint
    with _$KyoshinMonitorObservationPoint {
  const factory({
    required String code,
    required int x,
    required int y,
  }) = _KyoshinMonitorObservationPoint;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorObservationPointFromJson(json);
}

@freezed
abstract class KyoshinMonitorObservationAnalyzedPoint
    with _$KyoshinMonitorObservationAnalyzedPoint {
  const factory({
    required KyoshinMonitorObservationPoint point,
    required double scale,
    required int r,
    required int g,
    required int b,
  }) = _KyoshinMonitorObservationAnalyzedPoint;

  const new _();

  factory fromJson(
    Map<String, dynamic> json,
  ) => _$KyoshinMonitorObservationAnalyzedPointFromJson(json);

  double get scaleToIntensity => scale * 10 - 3;
  double get scaleToPga => math.pow(10, 5 * scale - 2).toDouble();
  double get scaleToPgv => math.pow(10, 5 * scale - 3).toDouble();
  double get scaleToPgd => math.pow(10, 5 * scale - 4).toDouble();
}

/// 観測点の表示名・座標を含む。GIF 解析入力用の [KyoshinMonitorObservationPoint] と
/// インデックスで対応する。
@freezed
abstract class NamedObservationPoint with _$NamedObservationPoint {
  const factory({
    required String code,
    required String name,
    required double latitude,
    required double longitude,
    required int x,
    required int y,
  }) = _NamedObservationPoint;

  factory fromJson(Map<String, dynamic> json) =>
      _$NamedObservationPointFromJson(json);
}
