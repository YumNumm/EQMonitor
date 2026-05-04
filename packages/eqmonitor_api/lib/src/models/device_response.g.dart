// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceResponse _$DeviceResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_DeviceResponse',
      json,
      ($checkedConvert) {
        final val = _DeviceResponse(
          id: $checkedConvert('id', (v) => v as String),
          type: $checkedConvert(
            'type',
            (v) => $enumDecode(_$DeviceTypeEnumMap, v),
          ),
          userId: $checkedConvert('user_id', (v) => v as String?),
          locale: $checkedConvert(
            'locale',
            (v) => $enumDecode(_$DeviceLocaleEnumMap, v),
          ),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$DeviceResponseToJson(_DeviceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'user_id': instance.userId,
      'locale': instance.locale,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
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
