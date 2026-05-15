// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v2_device_me_fcm_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2DeviceMeFcmRequestBody _$V2DeviceMeFcmRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_V2DeviceMeFcmRequestBody', json, ($checkedConvert) {
  final val = _V2DeviceMeFcmRequestBody(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$V2DeviceMeFcmRequestBodyToJson(
  _V2DeviceMeFcmRequestBody instance,
) => <String, dynamic>{'token': instance.token};
