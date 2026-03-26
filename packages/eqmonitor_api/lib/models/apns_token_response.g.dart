// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'apns_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApnsTokenResponse _$ApnsTokenResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApnsTokenResponse', json, ($checkedConvert) {
      final val = _ApnsTokenResponse(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ApnsTokenTypeEnumMap, v),
        ),
        token: $checkedConvert('token', (v) => v as String),
        environment: $checkedConvert(
          'environment',
          (v) => $enumDecode(_$ApnsTokenResponseEnvironmentEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ApnsTokenResponseToJson(_ApnsTokenResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'token': instance.token,
      'environment': instance.environment,
    };

const _$ApnsTokenTypeEnumMap = {
  ApnsTokenType.notification: 'NOTIFICATION',
  ApnsTokenType.liveActivityStart: 'LIVE_ACTIVITY_START',
};

const _$ApnsTokenResponseEnvironmentEnumMap = {
  ApnsTokenResponseEnvironment.development: 'development',
  ApnsTokenResponseEnvironment.production: 'production',
};
