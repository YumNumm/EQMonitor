// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'sign_in_email_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInEmailRequestBody _$SignInEmailRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SignInEmailRequestBody',
  json,
  ($checkedConvert) {
    final val = _SignInEmailRequestBody(
      email: $checkedConvert('email', (v) => v as String),
      password: $checkedConvert('password', (v) => v as String),
      rememberMe: $checkedConvert('remember_me', (v) => v as bool? ?? true),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'rememberMe': 'remember_me',
    'callbackUrl': 'callbackURL',
  },
);

Map<String, dynamic> _$SignInEmailRequestBodyToJson(
  _SignInEmailRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'remember_me': instance.rememberMe,
  'callbackURL': ?instance.callbackUrl,
};
