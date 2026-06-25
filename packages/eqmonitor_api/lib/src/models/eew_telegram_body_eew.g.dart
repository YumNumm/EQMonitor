// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_telegram_body_eew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewTelegramBodyEew _$EewTelegramBodyEewFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EewTelegramBodyEew', json, ($checkedConvert) {
  final val = _EewTelegramBodyEew(
    eventId: $checkedConvert('eventId', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$TelegramTypeEnumMap, v)),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$TelegramStatusEnumMap, v),
    ),
    infoType: $checkedConvert(
      'infoType',
      (v) => $enumDecode(_$InfoTypeEnumMap, v),
    ),
    serialNo: $checkedConvert('serialNo', (v) => v as num),
    isCanceled: $checkedConvert('isCanceled', (v) => v as bool),
    isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool),
    isPlum: $checkedConvert('isPlum', (v) => v as bool),
    headline: $checkedConvert('headline', (v) => v as String?),
    isWarning: $checkedConvert('isWarning', (v) => v as bool?),
    originTime: $checkedConvert('originTime', (v) => v as String?),
    arrivalTime: $checkedConvert('arrivalTime', (v) => v as String?),
    hypocenterCode: $checkedConvert('hypocenterCode', (v) => v as num?),
    hypocenterName: $checkedConvert('hypocenterName', (v) => v as String?),
    hypocenterReduceCode: $checkedConvert(
      'hypocenterReduceCode',
      (v) => v as num?,
    ),
    hypocenterReduceName: $checkedConvert(
      'hypocenterReduceName',
      (v) => v as String?,
    ),
    depth: $checkedConvert('depth', (v) => v as num?),
    latitude: $checkedConvert('latitude', (v) => v as String?),
    longitude: $checkedConvert('longitude', (v) => v as String?),
    magnitude: $checkedConvert('magnitude', (v) => v as String?),
    forecastMaxIntensity: $checkedConvert(
      'forecastMaxIntensity',
      (v) => $enumDecodeNullable(_$JmaIntensityEnumMap, v),
    ),
    forecastMaxLpgmIntensity: $checkedConvert(
      'forecastMaxLpgmIntensity',
      (v) => $enumDecodeNullable(_$JmaLpgmIntensityEnumMap, v),
    ),
    forecastMaxIntensityIsOver: $checkedConvert(
      'forecastMaxIntensityIsOver',
      (v) => v as bool?,
    ),
    forecastMaxLpgmIntensityIsOver: $checkedConvert(
      'forecastMaxLpgmIntensityIsOver',
      (v) => v as bool?,
    ),
    accuracy: $checkedConvert(
      'accuracy',
      (v) => v == null
          ? null
          : EewTelegramBodyAccuracy.fromJson(v as Map<String, dynamic>),
    ),
    editorialOffice: $checkedConvert('editorialOffice', (v) => v as String?),
    reportTime: $checkedConvert('reportTime', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$EewTelegramBodyEewToJson(
  _EewTelegramBodyEew instance,
) => <String, dynamic>{
  'eventId': instance.eventId,
  'type': instance.type,
  'status': instance.status,
  'infoType': instance.infoType,
  'serialNo': instance.serialNo,
  'isCanceled': instance.isCanceled,
  'isLastInfo': instance.isLastInfo,
  'isPlum': instance.isPlum,
  'headline': ?instance.headline,
  'isWarning': ?instance.isWarning,
  'originTime': ?instance.originTime,
  'arrivalTime': ?instance.arrivalTime,
  'hypocenterCode': ?instance.hypocenterCode,
  'hypocenterName': ?instance.hypocenterName,
  'hypocenterReduceCode': ?instance.hypocenterReduceCode,
  'hypocenterReduceName': ?instance.hypocenterReduceName,
  'depth': ?instance.depth,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'magnitude': ?instance.magnitude,
  'forecastMaxIntensity': ?instance.forecastMaxIntensity,
  'forecastMaxLpgmIntensity': ?instance.forecastMaxLpgmIntensity,
  'forecastMaxIntensityIsOver': ?instance.forecastMaxIntensityIsOver,
  'forecastMaxLpgmIntensityIsOver': ?instance.forecastMaxLpgmIntensityIsOver,
  'accuracy': ?instance.accuracy,
  'editorialOffice': ?instance.editorialOffice,
  'reportTime': ?instance.reportTime,
};

const _$TelegramTypeEnumMap = {
  TelegramType.vzse40: 'VZSE40',
  TelegramType.vxse42: 'VXSE42',
  TelegramType.vxse43: 'VXSE43',
  TelegramType.vxse44: 'VXSE44',
  TelegramType.vxse45: 'VXSE45',
  TelegramType.vxse47: 'VXSE47',
  TelegramType.vtse41: 'VTSE41',
  TelegramType.vtse51: 'VTSE51',
  TelegramType.vtse52: 'VTSE52',
  TelegramType.vxse51: 'VXSE51',
  TelegramType.vxse52: 'VXSE52',
  TelegramType.vxse53: 'VXSE53',
  TelegramType.vxse56: 'VXSE56',
  TelegramType.vxse60: 'VXSE60',
  TelegramType.vxse61: 'VXSE61',
  TelegramType.vxse62: 'VXSE62',
  TelegramType.nankai: 'NANKAI',
  TelegramType.vyse60: 'VYSE60',
  TelegramType.shindoDb: 'SHINDO_DB',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: 'NORMAL',
  TelegramStatus.training: 'TRAINING',
  TelegramStatus.test: 'TEST',
};

const _$InfoTypeEnumMap = {
  InfoType.publication: 'PUBLICATION',
  InfoType.correction: 'CORRECTION',
  InfoType.delay: 'DELAY',
  InfoType.cancellation: 'CANCELLATION',
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
