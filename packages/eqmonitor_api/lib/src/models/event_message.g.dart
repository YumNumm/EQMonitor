// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'event_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventMessage _$EventMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EventMessage',
  json,
  ($checkedConvert) {
    final val = _EventMessage(
      eventId: $checkedConvert('event_id', (v) => v as String),
      type: $checkedConvert('type', (v) => $enumDecode(_$EventTypeEnumMap, v)),
      serialNo: $checkedConvert('serial_no', (v) => v as num),
      regions: $checkedConvert(
        'regions',
        (v) => (v as List<dynamic>)
            .map((e) => Regions.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      reportTime: $checkedConvert('report_time', (v) => v as String),
      maxIntensity: $checkedConvert('max_intensity', (v) => v as String?),
      headline: $checkedConvert('headline', (v) => v as String?),
      originTime: $checkedConvert('origin_time', (v) => v as String?),
      arrivalTime: $checkedConvert('arrival_time', (v) => v as String?),
      hypocenter: $checkedConvert(
        'hypocenter',
        (v) => v == null
            ? null
            : EventHypocenter.fromJson(v as Map<String, dynamic>),
      ),
      magnitude: $checkedConvert('magnitude', (v) => v as num?),
      isWarning: $checkedConvert('is_warning', (v) => v as bool?),
      isLastInfo: $checkedConvert('is_last_info', (v) => v as bool?),
      isCancel: $checkedConvert('is_cancel', (v) => v as bool?),
      hypocenterReduceName: $checkedConvert(
        'hypocenter_reduce_name',
        (v) => v as String?,
      ),
      hasWarningZones: $checkedConvert('has_warning_zones', (v) => v as bool?),
      isPlum: $checkedConvert('is_plum', (v) => v as bool?),
      isLevel: $checkedConvert('is_level', (v) => v as bool?),
      isOnePoint: $checkedConvert('is_one_point', (v) => v as bool?),
      comment: $checkedConvert('comment', (v) => v as String?),
      prefectures: $checkedConvert(
        'prefectures',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Prefectures.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eventId': 'event_id',
    'serialNo': 'serial_no',
    'reportTime': 'report_time',
    'maxIntensity': 'max_intensity',
    'originTime': 'origin_time',
    'arrivalTime': 'arrival_time',
    'isWarning': 'is_warning',
    'isLastInfo': 'is_last_info',
    'isCancel': 'is_cancel',
    'hypocenterReduceName': 'hypocenter_reduce_name',
    'hasWarningZones': 'has_warning_zones',
    'isPlum': 'is_plum',
    'isLevel': 'is_level',
    'isOnePoint': 'is_one_point',
  },
);

Map<String, dynamic> _$EventMessageToJson(_EventMessage instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'type': instance.type,
      'serial_no': instance.serialNo,
      'regions': instance.regions,
      'report_time': instance.reportTime,
      'max_intensity': ?instance.maxIntensity,
      'headline': ?instance.headline,
      'origin_time': ?instance.originTime,
      'arrival_time': ?instance.arrivalTime,
      'hypocenter': ?instance.hypocenter,
      'magnitude': ?instance.magnitude,
      'is_warning': ?instance.isWarning,
      'is_last_info': ?instance.isLastInfo,
      'is_cancel': ?instance.isCancel,
      'hypocenter_reduce_name': ?instance.hypocenterReduceName,
      'has_warning_zones': ?instance.hasWarningZones,
      'is_plum': ?instance.isPlum,
      'is_level': ?instance.isLevel,
      'is_one_point': ?instance.isOnePoint,
      'comment': ?instance.comment,
      'prefectures': ?instance.prefectures,
    };

const _$EventTypeEnumMap = {
  EventType.eew: 'EEW',
  EventType.earthquake: 'EARTHQUAKE',
  EventType.estimatedIntensity: 'ESTIMATED_INTENSITY',
};
