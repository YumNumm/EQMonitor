// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user_device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDeviceResponse _$UserDeviceResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_UserDeviceResponse',
      json,
      ($checkedConvert) {
        final val = _UserDeviceResponse(
          id: $checkedConvert('id', (v) => v as String),
          type: $checkedConvert(
            'type',
            (v) => $enumDecode(_$UserDeviceResponseTypeEnumMap, v),
          ),
          locale: $checkedConvert(
            'locale',
            (v) => $enumDecode(_$UserDeviceResponseLocaleEnumMap, v),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at', 'updatedAt': 'updated_at'},
    );

Map<String, dynamic> _$UserDeviceResponseToJson(_UserDeviceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'locale': instance.locale,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

const _$UserDeviceResponseTypeEnumMap = {
  UserDeviceResponseType.ios: 'IOS',
  UserDeviceResponseType.android: 'ANDROID',
};

const _$UserDeviceResponseLocaleEnumMap = {
  UserDeviceResponseLocale.ja: 'ja',
  UserDeviceResponseLocale.en: 'en',
  UserDeviceResponseLocale.zh: 'zh',
};
