// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceRegisterResponse _$DeviceRegisterResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeviceRegisterResponse', json, ($checkedConvert) {
  final val = _DeviceRegisterResponse(
    deviceId: $checkedConvert('deviceId', (v) => v as String),
    deviceToken: $checkedConvert('deviceToken', (v) => v as String),
    expiresAt: $checkedConvert('expiresAt', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$DeviceRegisterResponseToJson(
  _DeviceRegisterResponse instance,
) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'deviceToken': instance.deviceToken,
  'expiresAt': instance.expiresAt,
};
