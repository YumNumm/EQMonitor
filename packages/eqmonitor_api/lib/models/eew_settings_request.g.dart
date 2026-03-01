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

Map<String, dynamic> _$EewSettingsRequestToJson(_EewSettingsRequest instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'override_silent_mode': instance.overrideSilentMode,
      'sound': instance.sound,
      'start_live_activity': instance.startLiveActivity,
    };
