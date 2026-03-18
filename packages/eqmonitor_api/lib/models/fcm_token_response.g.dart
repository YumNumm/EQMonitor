// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fcm_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FcmTokenResponse _$FcmTokenResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FcmTokenResponse', json, ($checkedConvert) {
      final val = _FcmTokenResponse(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$FcmTokenResponseToJson(_FcmTokenResponse instance) =>
    <String, dynamic>{'token': instance.token};
