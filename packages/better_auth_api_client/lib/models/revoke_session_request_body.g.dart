// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'revoke_session_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevokeSessionRequestBody _$RevokeSessionRequestBodyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_RevokeSessionRequestBody', json, ($checkedConvert) {
  final val = _RevokeSessionRequestBody(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$RevokeSessionRequestBodyToJson(
  _RevokeSessionRequestBody instance,
) => <String, dynamic>{'token': instance.token};
