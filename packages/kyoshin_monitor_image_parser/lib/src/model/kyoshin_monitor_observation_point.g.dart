// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinMonitorObservationPointImpl
_$$KyoshinMonitorObservationPointImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(r'_$KyoshinMonitorObservationPointImpl', json, (
      $checkedConvert,
    ) {
      final val = _$KyoshinMonitorObservationPointImpl(
        code: $checkedConvert('code', (v) => v as String),
        x: $checkedConvert('x', (v) => (v as num).toInt()),
        y: $checkedConvert('y', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$$KyoshinMonitorObservationPointImplToJson(
  _$KyoshinMonitorObservationPointImpl instance,
) => <String, dynamic>{'code': instance.code, 'x': instance.x, 'y': instance.y};

_$KyoshinMonitorObservationAnalyzedPointImpl
_$$KyoshinMonitorObservationAnalyzedPointImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$KyoshinMonitorObservationAnalyzedPointImpl', json, (
  $checkedConvert,
) {
  final val = _$KyoshinMonitorObservationAnalyzedPointImpl(
    point: $checkedConvert(
      'point',
      (v) => KyoshinMonitorObservationPoint.fromJson(v as Map<String, dynamic>),
    ),
    scale: $checkedConvert('scale', (v) => (v as num).toDouble()),
    r: $checkedConvert('r', (v) => (v as num).toInt()),
    g: $checkedConvert('g', (v) => (v as num).toInt()),
    b: $checkedConvert('b', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$$KyoshinMonitorObservationAnalyzedPointImplToJson(
  _$KyoshinMonitorObservationAnalyzedPointImpl instance,
) => <String, dynamic>{
  'point': instance.point,
  'scale': instance.scale,
  'r': instance.r,
  'g': instance.g,
  'b': instance.b,
};
