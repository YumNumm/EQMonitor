// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_verify_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetVerifyEmailResponse _$GetVerifyEmailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_GetVerifyEmailResponse', json, ($checkedConvert) {
  final val = _GetVerifyEmailResponse(
    user: $checkedConvert(
      'user',
      (v) => User.fromJson(v as Map<String, dynamic>),
    ),
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$GetVerifyEmailResponseToJson(
  _GetVerifyEmailResponse instance,
) => <String, dynamic>{'user': instance.user, 'status': instance.status};
