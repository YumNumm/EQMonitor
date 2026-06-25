// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram_body_intensity_region.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewTelegramBodyIntensityRegion _$EewTelegramBodyIntensityRegionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewTelegramBodyIntensityRegion', json, ($checkedConvert) {
  final val = _EewTelegramBodyIntensityRegion(
    eventId: $checkedConvert('eventId', (v) => v as String),
    serialNo: $checkedConvert('serialNo', (v) => v as num),
    code: $checkedConvert('code', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    isPlum: $checkedConvert('isPlum', (v) => v as bool),
    isWarning: $checkedConvert('isWarning', (v) => v as bool),
    intensity: $checkedConvert(
      'intensity',
      (v) => $enumDecode(_$JmaIntensityEnumMap, v),
    ),
    intensityIsOver: $checkedConvert('intensityIsOver', (v) => v as bool),
    lpgmIntensity: $checkedConvert(
      'lpgmIntensity',
      (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
    ),
    lpgmIntensityIsOver: $checkedConvert(
      'lpgmIntensityIsOver',
      (v) => v as bool?,
    ),
    arrivalTime: $checkedConvert('arrivalTime', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EewTelegramBodyIntensityRegionToJson(
  _EewTelegramBodyIntensityRegion instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'serialNo': instance.serialNo,
  'code': instance.code,
  'name': instance.name,
  'isPlum': instance.isPlum,
  'isWarning': instance.isWarning,
  'intensity': instance.intensity,
  'intensityIsOver': instance.intensityIsOver,
  'lpgmIntensity': ?instance.lpgmIntensity,
  'lpgmIntensityIsOver': ?instance.lpgmIntensityIsOver,
  'arrivalTime': ?instance.arrivalTime,
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

const _$JmaLpgmIntensityEnumMap = {
  JmaLpgmIntensity.value0: '0',
  JmaLpgmIntensity.value1: '1',
  JmaLpgmIntensity.value2: '2',
  JmaLpgmIntensity.value3: '3',
  JmaLpgmIntensity.value4: '4',
};
