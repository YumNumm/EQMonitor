// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'merged_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MergedEvents _$MergedEventsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MergedEvents', json, ($checkedConvert) {
      final val = _MergedEvents(
        eventId: $checkedConvert('eventId', (v) => v as String),
        mergedAt: $checkedConvert(
          'mergedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MergedEventsToJson(_MergedEvents instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'mergedAt': instance.mergedAt.toIso8601String(),
    };
