// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'post_send_verification_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostSendVerificationEmailResponse _$PostSendVerificationEmailResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PostSendVerificationEmailResponse', json, (
  $checkedConvert,
) {
  final val = _PostSendVerificationEmailResponse(
    status: $checkedConvert('status', (v) => v as bool),
  );
  return val;
});

Map<String, dynamic> _$PostSendVerificationEmailResponseToJson(
  _PostSendVerificationEmailResponse instance,
) => <String, dynamic>{'status': instance.status};
