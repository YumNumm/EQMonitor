// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewSettingsResponse _$EewSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewSettingsResponse',
  json,
  ($checkedConvert) {
    final val = _EewSettingsResponse(
      enabled: $checkedConvert('enabled', (v) => v as bool),
      notificationTiers: $checkedConvert(
        'notification_tiers',
        (v) => (v as List<dynamic>)
            .map((e) => NotificationTiers3.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool,
      ),
      onePointEnabled: $checkedConvert('one_point_enabled', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificationTiers': 'notification_tiers',
    'startLiveActivity': 'start_live_activity',
    'onePointEnabled': 'one_point_enabled',
  },
);

Map<String, dynamic> _$EewSettingsResponseToJson(
  _EewSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'notification_tiers': instance.notificationTiers,
  'start_live_activity': instance.startLiveActivity,
  'one_point_enabled': instance.onePointEnabled,
};
