// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'observation_point_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ObservationPointPayload _$ObservationPointPayloadFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ObservationPointPayload',
  json,
  ($checkedConvert) {
    final val = _ObservationPointPayload(
      code: $checkedConvert('code', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      region: $checkedConvert('region', (v) => v as String),
      type: $checkedConvert('type', (v) => v as String),
      location: $checkedConvert(
        'location',
        (v) => LocationPayload.fromJson(v as Map<String, dynamic>),
      ),
      intensity: $checkedConvert('intensity', (v) => v as num?),
      intensityDiff: $checkedConvert('intensity_diff', (v) => v as num),
    );
    return val;
  },
  fieldKeyMap: const {'intensityDiff': 'intensity_diff'},
);

Map<String, dynamic> _$ObservationPointPayloadToJson(
  _ObservationPointPayload instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'region': instance.region,
  'type': instance.type,
  'location': instance.location,
  'intensity': instance.intensity,
  'intensity_diff': instance.intensityDiff,
};
