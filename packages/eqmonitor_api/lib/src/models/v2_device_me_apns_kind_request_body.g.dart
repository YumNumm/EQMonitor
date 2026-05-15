// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'v2_device_me_apns_kind_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_V2DeviceMeApnsKindRequestBody _$V2DeviceMeApnsKindRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_V2DeviceMeApnsKindRequestBody', json, ($checkedConvert) {
  final val = _V2DeviceMeApnsKindRequestBody(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$V2DeviceMeApnsKindRequestBodyToJson(
  _V2DeviceMeApnsKindRequestBody instance,
) => <String, dynamic>{'token': instance.token};
