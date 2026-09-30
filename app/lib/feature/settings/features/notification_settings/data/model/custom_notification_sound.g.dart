// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'custom_notification_sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomNotificationSound _$CustomNotificationSoundFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_CustomNotificationSound',
  json,
  ($checkedConvert) {
    final val = _CustomNotificationSound(
      id: $checkedConvert('id', (v) => v as String),
      displayName: $checkedConvert('display_name', (v) => v as String),
      fileName: $checkedConvert('file_name', (v) => v as String),
      durationMs: $checkedConvert('duration_ms', (v) => (v as num).toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      isAvailable: $checkedConvert('is_available', (v) => v as bool? ?? true),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayName': 'display_name',
    'fileName': 'file_name',
    'durationMs': 'duration_ms',
    'createdAt': 'created_at',
    'isAvailable': 'is_available',
  },
);

Map<String, dynamic> _$CustomNotificationSoundToJson(
  _CustomNotificationSound instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'file_name': instance.fileName,
  'duration_ms': instance.durationMs,
  'created_at': instance.createdAt.toIso8601String(),
  'is_available': instance.isAvailable,
};
