// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiSettingsRequest _$TsunamiSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiSettingsRequest',
  json,
  ($checkedConvert) {
    final val = _TsunamiSettingsRequest(
      notificationTiers: $checkedConvert(
        'notification_tiers',
        (v) => (v as List<dynamic>?)
            ?.map(
              (e) =>
                  TsunamiNotificationTier.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificationTiers': 'notification_tiers',
    'startLiveActivity': 'start_live_activity',
  },
);

Map<String, dynamic> _$TsunamiSettingsRequestToJson(
  _TsunamiSettingsRequest instance,
) => <String, dynamic>{
  'notification_tiers': ?instance.notificationTiers,
  'start_live_activity': ?instance.startLiveActivity,
};
