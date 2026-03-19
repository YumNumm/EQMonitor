// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'sign_up_email_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpEmailRequestBody _$SignUpEmailRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SignUpEmailRequestBody',
  json,
  ($checkedConvert) {
    final val = _SignUpEmailRequestBody(
      name: $checkedConvert('name', (v) => v as String),
      email: $checkedConvert('email', (v) => v as String),
      password: $checkedConvert('password', (v) => v as String),
      image: $checkedConvert('image', (v) => v as String?),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
      rememberMe: $checkedConvert('remember_me', (v) => v as bool?),
    );
    return val;
  },
  fieldKeyMap: const {
    'callbackUrl': 'callbackURL',
    'rememberMe': 'remember_me',
  },
);

Map<String, dynamic> _$SignUpEmailRequestBodyToJson(
  _SignUpEmailRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'image': ?instance.image,
  'callbackURL': ?instance.callbackUrl,
  'remember_me': ?instance.rememberMe,
};
