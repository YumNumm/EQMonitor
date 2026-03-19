// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewSettingsRequest _$EewSettingsRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewSettingsRequest',
      json,
      ($checkedConvert) {
        final val = _EewSettingsRequest(
          enabled: $checkedConvert('enabled', (v) => v as bool),
          notificationTiers: $checkedConvert(
            'notification_tiers',
            (v) => (v as List<dynamic>)
                .map(
                  (e) => NotificationTiers4.fromJson(e as Map<String, dynamic>),
                )
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

Map<String, dynamic> _$EewSettingsRequestToJson(_EewSettingsRequest instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'notification_tiers': instance.notificationTiers,
      'start_live_activity': instance.startLiveActivity,
    };
