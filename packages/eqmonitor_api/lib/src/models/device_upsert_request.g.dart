// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_upsert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceUpsertRequest _$DeviceUpsertRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_DeviceUpsertRequest', json, ($checkedConvert) {
      final val = _DeviceUpsertRequest(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$DeviceTypeEnumMap, v),
        ),
        locale: $checkedConvert(
          'locale',
          (v) => $enumDecodeNullable(_$DeviceLocaleEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$DeviceUpsertRequestToJson(
  _DeviceUpsertRequest instance,
) => <String, dynamic>{'type': instance.type, 'locale': ?instance.locale};

const _$DeviceTypeEnumMap = {
  DeviceType.ios: 'IOS',
  DeviceType.android: 'ANDROID',
};

const _$DeviceLocaleEnumMap = {
  DeviceLocale.ja: 'ja',
  DeviceLocale.en: 'en',
  DeviceLocale.zh: 'zh',
};
