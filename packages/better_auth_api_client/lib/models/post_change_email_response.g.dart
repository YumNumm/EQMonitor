// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_change_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostChangeEmailResponse _$PostChangeEmailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostChangeEmailResponse', json, ($checkedConvert) {
  final val = _PostChangeEmailResponse(
    status: $checkedConvert('status', (v) => v as bool),
    user: $checkedConvert(
      'user',
      (v) => v == null ? null : User.fromJson(v as Map<String, dynamic>),
    ),
    message: $checkedConvert(
      'message',
      (v) => $enumDecodeNullable(_$MessageEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$PostChangeEmailResponseToJson(
  _PostChangeEmailResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'user': ?instance.user,
  'message': ?instance.message,
};

const _$MessageEnumMap = {
  Message.emailUpdated: 'Email updated',
  Message.verificationEmailSent: 'Verification email sent',
};
