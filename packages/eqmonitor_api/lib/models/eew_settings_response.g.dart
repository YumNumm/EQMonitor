// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewSettingsResponse _$EewSettingsResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewSettingsResponse',
      json,
      ($checkedConvert) {
        final val = _EewSettingsResponse(
          enabled: $checkedConvert('enabled', (v) => v as bool),
          overrideSilentMode: $checkedConvert(
            'override_silent_mode',
            (v) => v as bool,
          ),
          sound: $checkedConvert(
            'sound',
            (v) => SoundSettingsResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EewSettingsResponseToJson(
  _EewSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'override_silent_mode': instance.overrideSilentMode,
  'sound': instance.sound,
  'start_live_activity': instance.startLiveActivity,
};
