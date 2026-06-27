// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'highest_intensity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighestIntensityItem _$HighestIntensityItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HighestIntensityItem', json, ($checkedConvert) {
  final val = _HighestIntensityItem(
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    intensity: $checkedConvert(
      'intensity',
      (v) => $enumDecode(_$JmaIntensityEnumMap, v),
    ),
    count: $checkedConvert('count', (v) => (v as num).toInt()),
    earthquake: $checkedConvert(
      'earthquake',
      (v) => EarthquakePartial.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$HighestIntensityItemToJson(
  _HighestIntensityItem instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': instance.intensity,
  'count': instance.count,
  'earthquake': instance.earthquake,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.value0: '0',
  JmaIntensity.value1: '1',
  JmaIntensity.value2: '2',
  JmaIntensity.value3: '3',
  JmaIntensity.value4: '4',
  JmaIntensity.value5unknown: '!5-',
  JmaIntensity.value5minus: '5-',
  JmaIntensity.value5plus: '5+',
  JmaIntensity.value6unknown: '!6-',
  JmaIntensity.value6minus: '6-',
  JmaIntensity.value6plus: '6+',
  JmaIntensity.value7: '7',
};
