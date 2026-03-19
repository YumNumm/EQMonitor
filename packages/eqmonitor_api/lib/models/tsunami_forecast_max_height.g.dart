// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_forecast_max_height.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiForecastMaxHeight _$TsunamiForecastMaxHeightFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiForecastMaxHeight',
  json,
  ($checkedConvert) {
    final val = _TsunamiForecastMaxHeight(
      value: $checkedConvert('value', (v) => v as num),
      over: $checkedConvert('over', (v) => v as bool),
      qualitative: $checkedConvert(
        'qualitative',
        (v) => $enumDecode(_$QualitativeHeightEnumMap, v),
      ),
      isImportant: $checkedConvert('is_important', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {'isImportant': 'is_important'},
);

Map<String, dynamic> _$TsunamiForecastMaxHeightToJson(
  _TsunamiForecastMaxHeight instance,
) => <String, dynamic>{
  'value': instance.value,
  'over': instance.over,
  'qualitative': instance.qualitative,
  'is_important': instance.isImportant,
};

const _$QualitativeHeightEnumMap = {
  QualitativeHeight.enormous: 'ENORMOUS',
  QualitativeHeight.high: 'HIGH',
};
