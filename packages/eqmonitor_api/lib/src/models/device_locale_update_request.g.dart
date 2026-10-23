// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_locale_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceLocaleUpdateRequest _$DeviceLocaleUpdateRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceLocaleUpdateRequest', json, ($checkedConvert) {
  final val = _DeviceLocaleUpdateRequest(
    locale: $checkedConvert(
      'locale',
      (v) => $enumDecode(_$DeviceLocaleEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$DeviceLocaleUpdateRequestToJson(
  _DeviceLocaleUpdateRequest instance,
) => <String, dynamic>{'locale': instance.locale};

const _$DeviceLocaleEnumMap = {
  DeviceLocale.ja: 'ja',
  DeviceLocale.en: 'en',
  DeviceLocale.zh: 'zh',
};
