// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_active_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionActiveSnapshot _$ShakeDetectionActiveSnapshotFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionActiveSnapshot', json, ($checkedConvert) {
  final val = _ShakeDetectionActiveSnapshot(
    type: $checkedConvert('type', (v) => v as String),
    revision: $checkedConvert('revision', (v) => (v as num).toInt()),
    responseAt: $checkedConvert(
      'responseAt',
      (v) => DateTime.parse(v as String),
    ),
    events: $checkedConvert(
      'events',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                ShakeDetectionActiveEvent.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ShakeDetectionActiveSnapshotToJson(
  _ShakeDetectionActiveSnapshot instance,
) => <String, dynamic>{
  'type': instance.type,
  'revision': instance.revision,
  'responseAt': instance.responseAt.toIso8601String(),
  'events': instance.events,
};
