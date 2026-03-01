// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'live_activity_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveActivityTokenRequest _$LiveActivityTokenRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_LiveActivityTokenRequest', json, ($checkedConvert) {
  final val = _LiveActivityTokenRequest(
    token: $checkedConvert('token', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$LiveActivityTokenRequestToJson(
  _LiveActivityTokenRequest instance,
) => <String, dynamic>{'token': instance.token};
