// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_forecast_first_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiForecastFirstHeight _$TsunamiForecastFirstHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiForecastFirstHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiForecastFirstHeight(
      arrivalTime: $checkedConvert(
        'arrival_time',
        (v) => DateTime.parse(v as String),
      ),
      condition: $checkedConvert(
        'condition',
        (v) => $enumDecode(_$FirstHeightConditionEnumMap, v),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'arrivalTime': 'arrival_time'},
);

Map<String, dynamic> _$TsunamiForecastFirstHeightToJson(
  _TsunamiForecastFirstHeight instance,
) => <String, dynamic>{
  'arrival_time': instance.arrivalTime.toIso8601String(),
  'condition': instance.condition,
};

const _$FirstHeightConditionEnumMap = {
  FirstHeightCondition.arriving: 'ARRIVING',
  FirstHeightCondition.firstWaveConfirmed: 'FIRST_WAVE_CONFIRMED',
  FirstHeightCondition.imminent: 'IMMINENT',
};
