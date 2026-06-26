// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterServiceUnavailableResponse
_$ParameterServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _ParameterServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ParameterServiceUnavailableResponseToJson(
  _ParameterServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
