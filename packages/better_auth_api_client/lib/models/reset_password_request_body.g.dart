// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'reset_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResetPasswordRequestBody _$ResetPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ResetPasswordRequestBody',
  json,
  ($checkedConvert) {
    final val = _ResetPasswordRequestBody(
      newPassword: $checkedConvert('new_password', (v) => v as String),
      token: $checkedConvert('token', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'newPassword': 'new_password'},
);

Map<String, dynamic> _$ResetPasswordRequestBodyToJson(
  _ResetPasswordRequestBody instance,
) => <String, dynamic>{
  'new_password': instance.newPassword,
  'token': ?instance.token,
};
