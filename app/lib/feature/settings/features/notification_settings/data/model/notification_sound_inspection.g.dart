// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_inspection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSoundInspection _$NotificationSoundInspectionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationSoundInspection', json, ($checkedConvert) {
  final val = _NotificationSoundInspection(
    sourceDisplayName: $checkedConvert('sourceDisplayName', (v) => v as String),
    durationMs: $checkedConvert('durationMs', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$NotificationSoundInspectionToJson(
  _NotificationSoundInspection instance,
) => <String, dynamic>{
  'sourceDisplayName': instance.sourceDisplayName,
  'durationMs': instance.durationMs,
};
