// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'rate_limited_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RateLimitedResponse _$RateLimitedResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RateLimitedResponse', json, ($checkedConvert) {
      final val = _RateLimitedResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$RateLimitedResponseToJson(
  _RateLimitedResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
