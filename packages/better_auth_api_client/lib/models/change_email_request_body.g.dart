// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'change_email_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangeEmailRequestBody _$ChangeEmailRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ChangeEmailRequestBody',
  json,
  ($checkedConvert) {
    final val = _ChangeEmailRequestBody(
      newEmail: $checkedConvert('new_email', (v) => v as String),
      callbackUrl: $checkedConvert('callbackURL', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'newEmail': 'new_email', 'callbackUrl': 'callbackURL'},
);

Map<String, dynamic> _$ChangeEmailRequestBodyToJson(
  _ChangeEmailRequestBody instance,
) => <String, dynamic>{
  'new_email': instance.newEmail,
  'callbackURL': ?instance.callbackUrl,
};
