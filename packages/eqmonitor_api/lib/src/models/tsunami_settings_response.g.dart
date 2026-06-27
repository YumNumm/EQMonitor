// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiSettingsResponse _$TsunamiSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiSettingsResponse',
  json,
  ($checkedConvert) {
    final val = _TsunamiSettingsResponse(
      notificationTiers: $checkedConvert(
        'notification_tiers',
        (v) => (v as List<dynamic>)
            .map((e) => NotificationTiers5.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificationTiers': 'notification_tiers',
    'startLiveActivity': 'start_live_activity',
  },
);

Map<String, dynamic> _$TsunamiSettingsResponseToJson(
  _TsunamiSettingsResponse instance,
) => <String, dynamic>{
  'notification_tiers': instance.notificationTiers,
  'start_live_activity': instance.startLiveActivity,
};
