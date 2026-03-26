// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_reset_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostResetPasswordResponse _$PostResetPasswordResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostResetPasswordResponse', json, ($checkedConvert) {
  final val = _PostResetPasswordResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostResetPasswordResponseToJson(
  _PostResetPasswordResponse instance,
) => <String, dynamic>{'status': instance.status};
