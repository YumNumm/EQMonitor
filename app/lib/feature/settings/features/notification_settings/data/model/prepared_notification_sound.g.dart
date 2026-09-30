// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'prepared_notification_sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PreparedNotificationSound _$PreparedNotificationSoundFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_PreparedNotificationSound', json, ($checkedConvert) {
  final val = _PreparedNotificationSound(
    id: $checkedConvert('id', (v) => v as String),
    durationMs: $checkedConvert('duration_ms', (v) => (v as num).toInt()),
  );
  return val;
}, fieldKeyMap: const {'durationMs': 'duration_ms'});

Map<String, dynamic> _$PreparedNotificationSoundToJson(
  _PreparedNotificationSound instance,
) => <String, dynamic>{'id': instance.id, 'duration_ms': instance.durationMs};
