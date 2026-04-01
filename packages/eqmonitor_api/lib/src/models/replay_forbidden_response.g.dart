// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_forbidden_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplayForbiddenResponse _$ReplayForbiddenResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ReplayForbiddenResponse', json, ($checkedConvert) {
  final val = _ReplayForbiddenResponse(
    code: $checkedConvert('code', (v) => v),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ReplayForbiddenResponseToJson(
  _ReplayForbiddenResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
