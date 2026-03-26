// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_reset_password_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetResetPasswordTokenResponse _$GetResetPasswordTokenResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetResetPasswordTokenResponse', json, ($checkedConvert) {
  final val = _GetResetPasswordTokenResponse(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$GetResetPasswordTokenResponseToJson(
  _GetResetPasswordTokenResponse instance,
) => <String, dynamic>{'token': instance.token};
