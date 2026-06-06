// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_me_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceMeResponse _$DeviceMeResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceMeResponse', json, ($checkedConvert) {
  final val = _DeviceMeResponse(
    id: $checkedConvert('id', (v) => v as String),
    type: $checkedConvert('type', (v) => $enumDecode(_$DeviceTypeEnumMap, v)),
    locale: $checkedConvert(
      'locale',
      (v) => $enumDecode(_$DeviceLocaleEnumMap, v),
    ),
    registrationType: $checkedConvert(
      'registrationType',
      (v) => $enumDecode(_$DeviceRegistrationTypeEnumMap, v),
    ),
    userId: $checkedConvert('userId', (v) => v as String?),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    updatedAt: $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
  );
  return val;
});

Map<String, dynamic> _$DeviceMeResponseToJson(_DeviceMeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'locale': instance.locale,
      'registrationType': instance.registrationType,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.ios: 'IOS',
  DeviceType.android: 'ANDROID',
};

const _$DeviceLocaleEnumMap = {
  DeviceLocale.ja: 'ja',
  DeviceLocale.en: 'en',
  DeviceLocale.zh: 'zh',
};

const _$DeviceRegistrationTypeEnumMap = {
  DeviceRegistrationType.appCheck: 'app_check',
  DeviceRegistrationType.challenge: 'challenge',
};
