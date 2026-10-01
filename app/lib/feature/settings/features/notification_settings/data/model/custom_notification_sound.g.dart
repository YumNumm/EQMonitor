// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'custom_notification_sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomNotificationSound _$CustomNotificationSoundFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_CustomNotificationSound', json, ($checkedConvert) {
  final val = _CustomNotificationSound(
    id: $checkedConvert('id', (v) => v as String),
    displayName: $checkedConvert('displayName', (v) => v as String),
    fileName: $checkedConvert('fileName', (v) => v as String),
    durationMs: $checkedConvert('durationMs', (v) => (v as num).toInt()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    isAvailable: $checkedConvert('isAvailable', (v) => v as bool? ?? true),
  );
  return val;
});

Map<String, dynamic> _$CustomNotificationSoundToJson(
  _CustomNotificationSound instance,
) => <String, dynamic>{
  'id': instance.id,
  'displayName': instance.displayName,
  'fileName': instance.fileName,
  'durationMs': instance.durationMs,
  'createdAt': instance.createdAt.toIso8601String(),
  'isAvailable': instance.isAvailable,
};
