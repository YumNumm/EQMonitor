// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeCount _$FeedEarthquakeCountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedEarthquakeCount', json, ($checkedConvert) {
      final val = _FeedEarthquakeCount(
        type: $checkedConvert('type', (v) => $enumDecode(_$TypeEnumMap, v)),
        targetTime: $checkedConvert(
          'targetTime',
          (v) =>
              FeedEarthquakeCountTargetTime.fromJson(v as Map<String, dynamic>),
        ),
        values: $checkedConvert(
          'values',
          (v) => FeedEarthquakeCountValues.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$FeedEarthquakeCountToJson(
  _FeedEarthquakeCount instance,
) => <String, dynamic>{
  'type': instance.type,
  'targetTime': instance.targetTime,
  'values': instance.values,
};

const _$TypeEnumMap = {
  Type.undefined0: '１時間地震回数',
  Type.undefined1: '累積地震回数',
  Type.undefined2: '地震回数',
};
