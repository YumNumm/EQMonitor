// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_change_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostChangePasswordResponse _$PostChangePasswordResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostChangePasswordResponse', json, ($checkedConvert) {
  final val = _PostChangePasswordResponse(
    user: $checkedConvert(
      'user',
      (v) => User3.fromJson(v as Map<String, dynamic>),
    ),
    token: $checkedConvert('token', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$PostChangePasswordResponseToJson(
  _PostChangePasswordResponse instance,
) => <String, dynamic>{'user': instance.user, 'token': ?instance.token};
