// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fcm_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FcmTokenUpdateResponse _$FcmTokenUpdateResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FcmTokenUpdateResponse', json, ($checkedConvert) {
  final val = _FcmTokenUpdateResponse(
    token: $checkedConvert('token', (v) => v as String?),
    fcmVerify: $checkedConvert('fcm_verify', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'fcmVerify': 'fcm_verify'});

Map<String, dynamic> _$FcmTokenUpdateResponseToJson(
  _FcmTokenUpdateResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'fcm_verify': instance.fcmVerify,
};
