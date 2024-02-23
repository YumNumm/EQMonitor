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
          isPlum: $checkedConvert('is_plum', (v) => v as bool),
          isWarning: $checkedConvert('is_warning', (v) => v as bool),
          forecastMaxInt: $checkedConvert('forecast_max_int',
              (v) => ForecastMaxInt.fromJson(v as Map<String, dynamic>)),
          forecastMaxLgInt: $checkedConvert(
              'forecast_max_lg_int',
              (v) => v == null
                  ? null
                  : ForecastMaxLgInt.fromJson(v as Map<String, dynamic>)),
          arrivalTime: $checkedConvert('arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'isPlum': 'is_plum',
        'isWarning': 'is_warning',
        'forecastMaxInt': 'forecast_max_int',
        'forecastMaxLgInt': 'forecast_max_lg_int',
        'arrivalTime': 'arrival_time'
      },
    );

Map<String, dynamic> _$$EewRegionImplToJson(_$EewRegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'is_plum': instance.isPlum,
      'is_warning': instance.isWarning,
      'forecast_max_int': instance.forecastMaxInt,
      'forecast_max_lg_int': instance.forecastMaxLgInt,
      'arrival_time': instance.arrivalTime?.toIso8601String(),
    };
