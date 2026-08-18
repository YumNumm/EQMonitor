// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_list_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeListServiceUnavailableResponse
_$EarthquakeListServiceUnavailableResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeListServiceUnavailableResponse', json, (
      $checkedConvert,
    ) {
      final val = _EarthquakeListServiceUnavailableResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeListServiceUnavailableResponseToJson(
  _EarthquakeListServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
