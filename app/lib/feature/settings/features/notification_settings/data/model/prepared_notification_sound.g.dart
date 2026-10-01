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
    durationMs: $checkedConvert('durationMs', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$PreparedNotificationSoundToJson(
  _PreparedNotificationSound instance,
) => <String, dynamic>{'id': instance.id, 'durationMs': instance.durationMs};
