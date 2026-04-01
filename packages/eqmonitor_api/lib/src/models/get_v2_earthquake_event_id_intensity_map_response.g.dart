// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'get_v2_earthquake_event_id_intensity_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetV2EarthquakeEventIdIntensityMapResponse
_$GetV2EarthquakeEventIdIntensityMapResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_GetV2EarthquakeEventIdIntensityMapResponse',
  json,
  ($checkedConvert) {
    final val = _GetV2EarthquakeEventIdIntensityMapResponse(
      url: $checkedConvert('url', (v) => v as String?),
      objectKey: $checkedConvert('object_key', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'objectKey': 'object_key'},
);

Map<String, dynamic> _$GetV2EarthquakeEventIdIntensityMapResponseToJson(
  _GetV2EarthquakeEventIdIntensityMapResponse instance,
) => <String, dynamic>{'url': instance.url, 'object_key': instance.objectKey};
