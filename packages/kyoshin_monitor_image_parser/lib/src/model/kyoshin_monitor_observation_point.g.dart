// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KyoshinMonitorObservationPoint _$KyoshinMonitorObservationPointFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinMonitorObservationPoint', json, ($checkedConvert) {
  final val = _KyoshinMonitorObservationPoint(
    code: $checkedConvert('code', (v) => v as String),
    x: $checkedConvert('x', (v) => (v as num).toInt()),
    y: $checkedConvert('y', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$KyoshinMonitorObservationPointToJson(
  _KyoshinMonitorObservationPoint instance,
) => <String, dynamic>{'code': instance.code, 'x': instance.x, 'y': instance.y};

_KyoshinMonitorObservationAnalyzedPoint
_$KyoshinMonitorObservationAnalyzedPointFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_KyoshinMonitorObservationAnalyzedPoint', json, (
      $checkedConvert,
    ) {
      final val = _KyoshinMonitorObservationAnalyzedPoint(
        point: $checkedConvert(
          'point',
          (v) => KyoshinMonitorObservationPoint.fromJson(
            v as Map<String, dynamic>,
          ),
        ),
        scale: $checkedConvert('scale', (v) => (v as num).toDouble()),
        r: $checkedConvert('r', (v) => (v as num).toInt()),
        g: $checkedConvert('g', (v) => (v as num).toInt()),
        b: $checkedConvert('b', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$KyoshinMonitorObservationAnalyzedPointToJson(
  _KyoshinMonitorObservationAnalyzedPoint instance,
) => <String, dynamic>{
  'point': instance.point,
  'scale': instance.scale,
  'r': instance.r,
  'g': instance.g,
  'b': instance.b,
};
