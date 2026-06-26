// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeCount _$FeedEarthquakeCountFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_FeedEarthquakeCount', json, ($checkedConvert) {
      final val = _FeedEarthquakeCount(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$FeedTelegramTypeEnumMap, v),
        ),
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

const _$FeedTelegramTypeEnumMap = {
  FeedTelegramType.oneHourEarthquakeCount: 'ONE_HOUR_EARTHQUAKE_COUNT',
  FeedTelegramType.accumulativeEarthquakeCount: 'ACCUMULATIVE_EARTHQUAKE_COUNT',
  FeedTelegramType.earthquakeCount: 'EARTHQUAKE_COUNT',
};
