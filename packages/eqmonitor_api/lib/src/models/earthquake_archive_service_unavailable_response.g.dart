// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_service_unavailable_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeArchiveServiceUnavailableResponse
_$EarthquakeArchiveServiceUnavailableResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EarthquakeArchiveServiceUnavailableResponse', json, (
  $checkedConvert,
) {
  final val = _EarthquakeArchiveServiceUnavailableResponse(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$EarthquakeArchiveServiceUnavailableResponseToJson(
  _EarthquakeArchiveServiceUnavailableResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
