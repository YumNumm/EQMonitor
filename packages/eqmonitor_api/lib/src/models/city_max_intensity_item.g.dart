// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'city_max_intensity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CityMaxIntensityItem _$CityMaxIntensityItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CityMaxIntensityItem', json, ($checkedConvert) {
  final val = _CityMaxIntensityItem(
    cityId: $checkedConvert('city_id', (v) => v as String),
    maxIntensity: $checkedConvert(
      'max_intensity',
      (v) => $enumDecode(_$JmaIntensityEnumMap, v),
    ),
  );
  return val;
}, fieldKeyMap: const {'cityId': 'city_id', 'maxIntensity': 'max_intensity'});

Map<String, dynamic> _$CityMaxIntensityItemToJson(
  _CityMaxIntensityItem instance,
) => <String, dynamic>{
  'city_id': instance.cityId,
  'max_intensity': instance.maxIntensity,
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
