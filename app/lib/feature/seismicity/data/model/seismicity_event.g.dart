// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityEvent _$SeismicityEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_SeismicityEvent',
      json,
      ($checkedConvert) {
        final val = _SeismicityEvent(
          eventId: $checkedConvert('event_id', (v) => v as String),
          originTime: $checkedConvert(
            'origin_time',
            (v) => DateTime.parse(v as String),
          ),
          magnitude: $checkedConvert(
            'magnitude',
            (v) => (v as num?)?.toDouble(),
          ),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toDouble()),
          latitude: $checkedConvert('latitude', (v) => (v as num).toDouble()),
          longitude: $checkedConvert('longitude', (v) => (v as num).toDouble()),
          maxIntensity: $checkedConvert('max_intensity', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'originTime': 'origin_time',
        'maxIntensity': 'max_intensity',
      },
    );

Map<String, dynamic> _$SeismicityEventToJson(_SeismicityEvent instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'origin_time': instance.originTime.toIso8601String(),
      'magnitude': instance.magnitude,
      'depth': instance.depth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'max_intensity': instance.maxIntensity,
    };
