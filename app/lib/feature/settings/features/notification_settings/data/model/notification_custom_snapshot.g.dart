// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_custom_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationCustomSnapshot _$NotificationCustomSnapshotFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationCustomSnapshot',
  json,
  ($checkedConvert) {
    final val = _NotificationCustomSnapshot(
      schemaVersion: $checkedConvert(
        'schema_version',
        (v) => (v as num).toInt(),
      ),
      slots: $checkedConvert(
        'slots',
        (v) => (v as List<dynamic>)
            .map(
              (e) => NotificationSlotDraft.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      eewWarning: $checkedConvert(
        'eew_warning',
        (v) => EewWarningSettings.fromJson(v as Map<String, dynamic>),
      ),
      eewGlobal: $checkedConvert(
        'eew_global',
        (v) => EewGlobalSettings.fromJson(v as Map<String, dynamic>),
      ),
      earthquakeGlobal: $checkedConvert(
        'earthquake_global',
        (v) => EarthquakeGlobalSettings.fromJson(v as Map<String, dynamic>),
      ),
      general: $checkedConvert(
        'general',
        (v) => GeneralNotificationSettings.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemaVersion': 'schema_version',
    'eewWarning': 'eew_warning',
    'eewGlobal': 'eew_global',
    'earthquakeGlobal': 'earthquake_global',
  },
);

Map<String, dynamic> _$NotificationCustomSnapshotToJson(
  _NotificationCustomSnapshot instance,
) => <String, dynamic>{
  'schema_version': instance.schemaVersion,
  'slots': instance.slots,
  'eew_warning': instance.eewWarning,
  'eew_global': instance.eewGlobal,
  'earthquake_global': instance.earthquakeGlobal,
  'general': instance.general,
};
