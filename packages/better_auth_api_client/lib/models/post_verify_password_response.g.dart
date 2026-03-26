// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_verify_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostVerifyPasswordResponse _$PostVerifyPasswordResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostVerifyPasswordResponse', json, ($checkedConvert) {
  final val = _PostVerifyPasswordResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostVerifyPasswordResponseToJson(
  _PostVerifyPasswordResponse instance,
) => <String, dynamic>{'status': instance.status};
