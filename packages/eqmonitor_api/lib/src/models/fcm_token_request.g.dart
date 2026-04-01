// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fcm_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FcmTokenRequest _$FcmTokenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FcmTokenRequest', json, ($checkedConvert) {
      final val = _FcmTokenRequest(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FcmTokenRequestToJson(_FcmTokenRequest instance) =>
    <String, dynamic>{'token': instance.token};
