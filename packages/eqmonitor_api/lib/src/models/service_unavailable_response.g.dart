// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceUnavailableResponse _$ServiceUnavailableResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ServiceUnavailableResponse', json, ($checkedConvert) {
  final val = _ServiceUnavailableResponse(
    code: $checkedConvert('code', (v) => v),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ServiceUnavailableResponseToJson(
  _ServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
