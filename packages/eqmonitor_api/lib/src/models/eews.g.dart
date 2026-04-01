// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Eews _$EewsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Eews', json, ($checkedConvert) {
      final val = _Eews(
        eventId: $checkedConvert('eventId', (v) => v as String),
        type: $checkedConvert('type', (v) => $enumDecode(_$Type5EnumMap, v)),
        serialNo: $checkedConvert('serialNo', (v) => v as num),
        regions: $checkedConvert(
          'regions',
          (v) => (v as List<dynamic>)
              .map((e) => Regions.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        reportTime: $checkedConvert('reportTime', (v) => v as String),
        maxIntensity: $checkedConvert('maxIntensity', (v) => v as String?),
        headline: $checkedConvert('headline', (v) => v as String?),
        originTime: $checkedConvert('originTime', (v) => v as String?),
        arrivalTime: $checkedConvert('arrivalTime', (v) => v as String?),
        hypocenter: $checkedConvert(
          'hypocenter',
          (v) => v == null
              ? null
              : EventHypocenter.fromJson(v as Map<String, dynamic>),
        ),
        magnitude: $checkedConvert('magnitude', (v) => v as num?),
        isWarning: $checkedConvert('isWarning', (v) => v as bool?),
        isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool?),
        isCancel: $checkedConvert('isCancel', (v) => v as bool?),
        hypocenterReduceName: $checkedConvert(
          'hypocenterReduceName',
          (v) => v as String?,
        ),
        hasWarningZones: $checkedConvert('hasWarningZones', (v) => v as bool?),
        isPlum: $checkedConvert('isPlum', (v) => v as bool?),
        isLevel: $checkedConvert('isLevel', (v) => v as bool?),
        isOnePoint: $checkedConvert('isOnePoint', (v) => v as bool?),
        comment: $checkedConvert('comment', (v) => v as String?),
        prefectures: $checkedConvert(
          'prefectures',
          (v) => (v as List<dynamic>?)
              ?.map((e) => Prefectures.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EewsToJson(_Eews instance) => <String, dynamic>{
  'eventId': instance.eventId,
  'type': instance.type,
  'serialNo': instance.serialNo,
  'regions': instance.regions,
  'reportTime': instance.reportTime,
  'maxIntensity': ?instance.maxIntensity,
  'headline': ?instance.headline,
  'originTime': ?instance.originTime,
  'arrivalTime': ?instance.arrivalTime,
  'hypocenter': ?instance.hypocenter,
  'magnitude': ?instance.magnitude,
  'isWarning': ?instance.isWarning,
  'isLastInfo': ?instance.isLastInfo,
  'isCancel': ?instance.isCancel,
  'hypocenterReduceName': ?instance.hypocenterReduceName,
  'hasWarningZones': ?instance.hasWarningZones,
  'isPlum': ?instance.isPlum,
  'isLevel': ?instance.isLevel,
  'isOnePoint': ?instance.isOnePoint,
  'comment': ?instance.comment,
  'prefectures': ?instance.prefectures,
};

const _$Type5EnumMap = {
  Type5.eew: 'EEW',
  Type5.earthquake: 'EARTHQUAKE',
  Type5.estimatedIntensity: 'ESTIMATED_INTENSITY',
};
