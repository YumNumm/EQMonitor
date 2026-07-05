// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'highest_intensity_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighestIntensityEntry _$HighestIntensityEntryFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_HighestIntensityEntry', json, ($checkedConvert) {
  final val = _HighestIntensityEntry(
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

Map<String, dynamic> _$HighestIntensityEntryToJson(
  _HighestIntensityEntry instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'intensity': _$JmaIntensityEnumMap[instance.intensity]!,
  'count': instance.count,
  'earthquake': instance.earthquake,
};

const _$JmaIntensityEnumMap = {
  JmaIntensity.unknown: 'unknown',
  JmaIntensity.zero: 'zero',
  JmaIntensity.one: 'one',
  JmaIntensity.two: 'two',
  JmaIntensity.three: 'three',
  JmaIntensity.four: 'four',
  JmaIntensity.fiveUnknown: 'fiveUnknown',
  JmaIntensity.fiveLower: 'fiveLower',
  JmaIntensity.fiveUpper: 'fiveUpper',
  JmaIntensity.sixLower: 'sixLower',
  JmaIntensity.sixUpper: 'sixUpper',
  JmaIntensity.seven: 'seven',
};
