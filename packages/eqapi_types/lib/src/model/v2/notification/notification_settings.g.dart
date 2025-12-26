// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettings _$NotificationSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettings',
  json,
  ($checkedConvert) {
    final val = _NotificationSettings(
      tsunamiEnabled: $checkedConvert('tsunami_enabled', (v) => v as bool),
      trainingEnabled: $checkedConvert('training_enabled', (v) => v as bool),
    );
    return val;
  },
  fieldKeyMap: const {
    'tsunamiEnabled': 'tsunami_enabled',
    'trainingEnabled': 'training_enabled',
  },
);

Map<String, dynamic> _$NotificationSettingsToJson(
  _NotificationSettings instance,
) => <String, dynamic>{
  'tsunami_enabled': instance.tsunamiEnabled,
  'training_enabled': instance.trainingEnabled,
};

_NotificationSettingsRequest _$NotificationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettingsRequest',
  json,
  ($checkedConvert) {
    final val = _NotificationSettingsRequest(
      tsunamiEnabled: $checkedConvert('tsunami_enabled', (v) => v as bool?),
      trainingEnabled: $checkedConvert('training_enabled', (v) => v as bool?),
    );
    return val;
  },
  fieldKeyMap: const {
    'tsunamiEnabled': 'tsunami_enabled',
    'trainingEnabled': 'training_enabled',
  },
);

Map<String, dynamic> _$NotificationSettingsRequestToJson(
  _NotificationSettingsRequest instance,
) => <String, dynamic>{
  'tsunami_enabled': instance.tsunamiEnabled,
  'training_enabled': instance.trainingEnabled,
};

_EarthquakeNotificationSettings _$EarthquakeNotificationSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeNotificationSettings',
  json,
  ($checkedConvert) {
    final val = _EarthquakeNotificationSettings(
      enabled: $checkedConvert('enabled', (v) => v as bool),
      sound: $checkedConvert(
        'sound',
        (v) => SoundSettings.fromJson(v as Map<String, dynamic>),
      ),
      hypocenterUpdateEnabled: $checkedConvert(
        'hypocenter_update_enabled',
        (v) => v as bool,
      ),
      estimatedIntensityEnabled: $checkedConvert(
        'estimated_intensity_enabled',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'hypocenterUpdateEnabled': 'hypocenter_update_enabled',
    'estimatedIntensityEnabled': 'estimated_intensity_enabled',
  },
);

Map<String, dynamic> _$EarthquakeNotificationSettingsToJson(
  _EarthquakeNotificationSettings instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'sound': instance.sound,
  'hypocenter_update_enabled': instance.hypocenterUpdateEnabled,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
};

_EarthquakeNotificationSettingsRequest
_$EarthquakeNotificationSettingsRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EarthquakeNotificationSettingsRequest',
      json,
      ($checkedConvert) {
        final val = _EarthquakeNotificationSettingsRequest(
          enabled: $checkedConvert('enabled', (v) => v as bool?),
          sound: $checkedConvert(
            'sound',
            (v) => v == null
                ? null
                : SoundSettings.fromJson(v as Map<String, dynamic>),
          ),
          hypocenterUpdateEnabled: $checkedConvert(
            'hypocenter_update_enabled',
            (v) => v as bool?,
          ),
          estimatedIntensityEnabled: $checkedConvert(
            'estimated_intensity_enabled',
            (v) => v as bool?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'hypocenterUpdateEnabled': 'hypocenter_update_enabled',
        'estimatedIntensityEnabled': 'estimated_intensity_enabled',
      },
    );

Map<String, dynamic> _$EarthquakeNotificationSettingsRequestToJson(
  _EarthquakeNotificationSettingsRequest instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'sound': instance.sound,
  'hypocenter_update_enabled': instance.hypocenterUpdateEnabled,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
};

_EewNotificationSettings _$EewNotificationSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewNotificationSettings',
  json,
  ($checkedConvert) {
    final val = _EewNotificationSettings(
      enabled: $checkedConvert('enabled', (v) => v as bool),
      overrideSilentMode: $checkedConvert(
        'override_silent_mode',
        (v) => v as bool,
      ),
      sound: $checkedConvert(
        'sound',
        (v) => SoundSettings.fromJson(v as Map<String, dynamic>),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'overrideSilentMode': 'override_silent_mode',
    'startLiveActivity': 'start_live_activity',
  },
);

Map<String, dynamic> _$EewNotificationSettingsToJson(
  _EewNotificationSettings instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'override_silent_mode': instance.overrideSilentMode,
  'sound': instance.sound,
  'start_live_activity': instance.startLiveActivity,
};

_EewNotificationSettingsRequest _$EewNotificationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EewNotificationSettingsRequest',
  json,
  ($checkedConvert) {
    final val = _EewNotificationSettingsRequest(
      enabled: $checkedConvert('enabled', (v) => v as bool?),
      overrideSilentMode: $checkedConvert(
        'override_silent_mode',
        (v) => v as bool?,
      ),
      sound: $checkedConvert(
        'sound',
        (v) => v == null
            ? null
            : SoundSettings.fromJson(v as Map<String, dynamic>),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'overrideSilentMode': 'override_silent_mode',
    'startLiveActivity': 'start_live_activity',
  },
);

Map<String, dynamic> _$EewNotificationSettingsRequestToJson(
  _EewNotificationSettingsRequest instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'override_silent_mode': instance.overrideSilentMode,
  'sound': instance.sound,
  'start_live_activity': instance.startLiveActivity,
};
