// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'merged_events3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MergedEvents3 _$MergedEvents3FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MergedEvents3', json, ($checkedConvert) {
      final val = _MergedEvents3(
        eventId: $checkedConvert('eventId', (v) => v as String),
        mergedAt: $checkedConvert(
          'mergedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MergedEvents3ToJson(_MergedEvents3 instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'mergedAt': instance.mergedAt.toIso8601String(),
    };
