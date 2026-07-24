// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'merged_events2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MergedEvents2 _$MergedEvents2FromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MergedEvents2', json, ($checkedConvert) {
      final val = _MergedEvents2(
        eventId: $checkedConvert('eventId', (v) => v as String),
        mergedAt: $checkedConvert(
          'mergedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MergedEvents2ToJson(_MergedEvents2 instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'mergedAt': instance.mergedAt.toIso8601String(),
    };
