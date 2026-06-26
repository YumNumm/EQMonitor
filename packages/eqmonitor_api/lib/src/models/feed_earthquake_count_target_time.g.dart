// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'feed_earthquake_count_target_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEarthquakeCountTargetTime _$FeedEarthquakeCountTargetTimeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_FeedEarthquakeCountTargetTime', json, ($checkedConvert) {
  final val = _FeedEarthquakeCountTargetTime(
    start: $checkedConvert('start', (v) => v as String),
    end: $checkedConvert('end', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$FeedEarthquakeCountTargetTimeToJson(
  _FeedEarthquakeCountTargetTime instance,
) => <String, dynamic>{'start': instance.start, 'end': instance.end};
