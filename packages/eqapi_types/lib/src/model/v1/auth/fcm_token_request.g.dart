// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fcm_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FcmTokenRequest', json, ($checkedConvert) {
      final val = _FcmTokenRequest(
        fcmToken: $checkedConvert('fcm_token', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'fcmToken': 'fcm_token'});

Map<String, dynamic> _$FcmTokenRequestToJson(_FcmTokenRequest instance) =>
    <String, dynamic>{'fcm_token': instance.fcmToken};
