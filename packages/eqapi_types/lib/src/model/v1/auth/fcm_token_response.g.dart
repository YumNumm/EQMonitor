// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fcm_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FcmTokenUpdateResponseImpl _$$FcmTokenUpdateResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FcmTokenUpdateResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$FcmTokenUpdateResponseImpl(
          token: $checkedConvert('token', (v) => v as String?),
          fcmVerify: $checkedConvert('fcm_verify', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'fcmVerify': 'fcm_verify'},
    );

Map<String, dynamic> _$$FcmTokenUpdateResponseImplToJson(
        _$FcmTokenUpdateResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'fcm_verify': instance.fcmVerify,
    };
