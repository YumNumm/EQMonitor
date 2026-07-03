// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'migration_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MigrationResultResponse _$MigrationResultResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_MigrationResultResponse',
  json,
  ($checkedConvert) {
    final val = _MigrationResultResponse(
      earthquakeRegions: $checkedConvert('earthquake_regions', (v) => v as num),
      eewRegions: $checkedConvert('eew_regions', (v) => v as num),
      notificationSettings: $checkedConvert(
        'notification_settings',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'earthquakeRegions': 'earthquake_regions',
    'eewRegions': 'eew_regions',
    'notificationSettings': 'notification_settings',
  },
);

Map<String, dynamic> _$MigrationResultResponseToJson(
  _MigrationResultResponse instance,
) => <String, dynamic>{
  'earthquake_regions': instance.earthquakeRegions,
  'eew_regions': instance.eewRegions,
  'notification_settings': instance.notificationSettings,
};
