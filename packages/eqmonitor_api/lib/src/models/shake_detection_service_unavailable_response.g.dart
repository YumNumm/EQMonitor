// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionServiceUnavailableResponse
_$ShakeDetectionServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShakeDetectionServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _ShakeDetectionServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ShakeDetectionServiceUnavailableResponseToJson(
  _ShakeDetectionServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
