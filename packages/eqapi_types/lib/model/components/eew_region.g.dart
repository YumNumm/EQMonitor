// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewRegionImpl _$$EewRegionImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$EewRegionImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          isPlum: $checkedConvert('isPlum', (v) => v as bool),
          isWarning: $checkedConvert('isWarning', (v) => v as bool),
          forecastMaxInt: $checkedConvert('forecastMaxInt',
              (v) => ForecastMaxInt.fromJson(v as Map<String, dynamic>)),
          forecastMaxLgInt: $checkedConvert(
              'forecastMaxLgInt',
              (v) => v == null
                  ? null
                  : ForecastMaxLgInt.fromJson(v as Map<String, dynamic>)),
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewRegionImplToJson(_$EewRegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'isPlum': instance.isPlum,
      'isWarning': instance.isWarning,
      'forecastMaxInt': instance.forecastMaxInt,
      'forecastMaxLgInt': instance.forecastMaxLgInt,
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
    };
