// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_request_password_reset_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostRequestPasswordResetResponse _$PostRequestPasswordResetResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostRequestPasswordResetResponse', json, (
  $checkedConvert,
) {
  final val = _PostRequestPasswordResetResponse(
    status: $checkedConvert('status', (v) => v as bool),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$PostRequestPasswordResetResponseToJson(
  _PostRequestPasswordResetResponse instance,
) => <String, dynamic>{'status': instance.status, 'message': instance.message};
