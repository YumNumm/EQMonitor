// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'verify_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyPasswordRequestBody _$VerifyPasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_VerifyPasswordRequestBody', json, ($checkedConvert) {
  final val = _VerifyPasswordRequestBody(
    password: $checkedConvert('password', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$VerifyPasswordRequestBodyToJson(
  _VerifyPasswordRequestBody instance,
) => <String, dynamic>{'password': instance.password};
