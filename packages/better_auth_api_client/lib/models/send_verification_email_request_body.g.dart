// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'send_verification_email_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendVerificationEmailRequestBody _$SendVerificationEmailRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_SendVerificationEmailRequestBody',
  json,
  ($checkedConvert) {
    final val = _SendVerificationEmailRequestBody(
      email: $checkedConvert('email', (v) => v as String),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'callbackUrl': 'callbackURL'},
);

Map<String, dynamic> _$SendVerificationEmailRequestBodyToJson(
  _SendVerificationEmailRequestBody instance,
) => <String, dynamic>{
  'email': instance.email,
  'callbackURL': ?instance.callbackUrl,
};
