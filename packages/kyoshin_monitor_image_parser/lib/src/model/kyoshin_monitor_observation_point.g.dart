// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'kyoshin_monitor_observation_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KyoshinMonitorObservationPointImpl
    _$$KyoshinMonitorObservationPointImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$KyoshinMonitorObservationPointImpl',
          json,
          ($checkedConvert) {
            final val = _$KyoshinMonitorObservationPointImpl(
              code: $checkedConvert('code', (v) => v as String),
              x: $checkedConvert('x', (v) => (v as num).toInt()),
              y: $checkedConvert('y', (v) => (v as num).toInt()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$KyoshinMonitorObservationPointImplToJson(
        _$KyoshinMonitorObservationPointImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'x': instance.x,
      'y': instance.y,
    };

_$KyoshinMonitorObservationAnalyzedPointImpl
    _$$KyoshinMonitorObservationAnalyzedPointImplFromJson(
            Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$KyoshinMonitorObservationAnalyzedPointImpl',
          json,
          ($checkedConvert) {
            final val = _$KyoshinMonitorObservationAnalyzedPointImpl(
              point: $checkedConvert(
                  'point',
                  (v) => KyoshinMonitorObservationPoint.fromJson(
                      v as Map<String, dynamic>)),
              scale: $checkedConvert('scale', (v) => (v as num).toDouble()),
              color: $checkedConvert(
                  'color', (v) => _colorFromJson(v as Map<String, dynamic>)),
            );
            return val;
          },
        );

Map<String, dynamic> _$$KyoshinMonitorObservationAnalyzedPointImplToJson(
        _$KyoshinMonitorObservationAnalyzedPointImpl instance) =>
    <String, dynamic>{
      'point': instance.point,
      'scale': instance.scale,
      'color': _colorToJson(instance.color),
    };
