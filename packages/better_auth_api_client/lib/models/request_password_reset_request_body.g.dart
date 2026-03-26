// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'request_password_reset_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestPasswordResetRequestBody _$RequestPasswordResetRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_RequestPasswordResetRequestBody',
  json,
  ($checkedConvert) {
    final val = _RequestPasswordResetRequestBody(
      email: $checkedConvert('email', (v) => v as String),
      redirectTo: $checkedConvert('redirect_to', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'redirectTo': 'redirect_to'},
);

Map<String, dynamic> _$RequestPasswordResetRequestBodyToJson(
  _RequestPasswordResetRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'redirect_to': ?instance.redirectTo,
};
