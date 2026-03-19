// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'delete_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeleteUserRequestBody _$DeleteUserRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeleteUserRequestBody', json, ($checkedConvert) {
  final val = _DeleteUserRequestBody(
    callbackUrl: $checkedConvert('callbackURL', (v) => v as String),
    password: $checkedConvert('password', (v) => v as String),
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'callbackUrl': 'callbackURL'});

Map<String, dynamic> _$DeleteUserRequestBodyToJson(
  _DeleteUserRequestBody instance,
) => <String, dynamic>{
  'callbackURL': instance.callbackUrl,
  'password': instance.password,
  'token': instance.token,
};
