// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fcm_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FcmTokenRequestImpl _$$FcmTokenRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FcmTokenRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$FcmTokenRequestImpl(
          fcmToken: $checkedConvert('fcm_token', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'fcmToken': 'fcm_token'},
    );

Map<String, dynamic> _$$FcmTokenRequestImplToJson(
        _$FcmTokenRequestImpl instance) =>
    <String, dynamic>{
      'fcm_token': instance.fcmToken,
    };
