// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_counts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeCounts _$EarthquakeCountsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_EarthquakeCounts', json, ($checkedConvert) {
      final val = _EarthquakeCounts(
        type: $checkedConvert('type', (v) => v as String),
        targetTime: $checkedConvert(
          'targetTime',
          (v) => TargetTime.fromJson(v as Map<String, dynamic>),
        ),
        values: $checkedConvert(
          'values',
          (v) => Values.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$EarthquakeCountsToJson(_EarthquakeCounts instance) =>
    <String, dynamic>{
      'type': instance.type,
      'targetTime': instance.targetTime,
      'values': instance.values,
    };
