// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'change_password_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChangePasswordRequestBody _$ChangePasswordRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ChangePasswordRequestBody',
  json,
  ($checkedConvert) {
    final val = _ChangePasswordRequestBody(
      newPassword: $checkedConvert('new_password', (v) => v as String),
      currentPassword: $checkedConvert('current_password', (v) => v as String),
      revokeOtherSessions: $checkedConvert(
        'revoke_other_sessions',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'newPassword': 'new_password',
    'currentPassword': 'current_password',
    'revokeOtherSessions': 'revoke_other_sessions',
  },
);

Map<String, dynamic> _$ChangePasswordRequestBodyToJson(
  _ChangePasswordRequestBody instance,
) => <String, dynamic>{
  'new_password': instance.newPassword,
  'current_password': instance.currentPassword,
  'revoke_other_sessions': ?instance.revokeOtherSessions,
};
