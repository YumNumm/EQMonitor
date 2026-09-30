// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSoundInspection _$NotificationSoundInspectionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSoundInspection',
  json,
  ($checkedConvert) {
    final val = _NotificationSoundInspection(
      sourceDisplayName: $checkedConvert(
        'source_display_name',
        (v) => v as String,
      ),
      durationMs: $checkedConvert('duration_ms', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'sourceDisplayName': 'source_display_name',
    'durationMs': 'duration_ms',
  },
);

Map<String, dynamic> _$NotificationSoundInspectionToJson(
  _NotificationSoundInspection instance,
) => <String, dynamic>{
  'source_display_name': instance.sourceDisplayName,
  'duration_ms': instance.durationMs,
};
