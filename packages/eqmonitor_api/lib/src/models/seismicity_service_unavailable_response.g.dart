// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityServiceUnavailableResponse
_$SeismicityServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SeismicityServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _SeismicityServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SeismicityServiceUnavailableResponseToJson(
  _SeismicityServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
