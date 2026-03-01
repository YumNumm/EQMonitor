// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'apns_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApnsTokenRequest _$ApnsTokenRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ApnsTokenRequest', json, ($checkedConvert) {
      final val = _ApnsTokenRequest(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ApnsTokenRequestToJson(_ApnsTokenRequest instance) =>
    <String, dynamic>{'token': instance.token};
