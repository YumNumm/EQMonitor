// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'headless_api_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HeadlessApiIdentity _$HeadlessApiIdentityFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HeadlessApiIdentity', json, ($checkedConvert) {
      final val = _HeadlessApiIdentity(
        userAgent: $checkedConvert('user_agent', (v) => v as String),
        version: $checkedConvert('version', (v) => v as String),
        platform: $checkedConvert('platform', (v) => v as String),
        deviceId: $checkedConvert('device_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'userAgent': 'user_agent', 'deviceId': 'device_id'});

Map<String, dynamic> _$HeadlessApiIdentityToJson(
  _HeadlessApiIdentity instance,
) => <String, dynamic>{
  'user_agent': instance.userAgent,
  'version': instance.version,
  'platform': instance.platform,
  'device_id': instance.deviceId,
};
