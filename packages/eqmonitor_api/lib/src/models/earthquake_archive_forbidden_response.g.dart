// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_forbidden_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeArchiveForbiddenResponse
_$EarthquakeArchiveForbiddenResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeArchiveForbiddenResponse', json, (
      $checkedConvert,
    ) {
      final val = _EarthquakeArchiveForbiddenResponse(
        code: $checkedConvert('code', (v) => v as String),
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeArchiveForbiddenResponseToJson(
  _EarthquakeArchiveForbiddenResponse instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};
