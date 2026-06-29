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
          defaultSound: $checkedConvert('default_sound', (v) => v as String),
          defaultInterruptionLevel: $checkedConvert(
            'default_interruption_level',
            (v) => $enumDecode(_$DefaultInterruptionLevelEnumMap, v),
          ),
          startLiveActivity: $checkedConvert(
            'start_live_activity',
            (v) => v as bool,
          ),
          collapseNotification: $checkedConvert(
            'collapse_notification',
            (v) => v as bool,
          ),
          warningEnabled: $checkedConvert('warning_enabled', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'defaultSound': 'default_sound',
        'defaultInterruptionLevel': 'default_interruption_level',
        'startLiveActivity': 'start_live_activity',
        'collapseNotification': 'collapse_notification',
        'warningEnabled': 'warning_enabled',
      },
    );

Map<String, dynamic> _$EewSettingsResponseToJson(
  _EewSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'default_sound': instance.defaultSound,
  'default_interruption_level': instance.defaultInterruptionLevel,
  'start_live_activity': instance.startLiveActivity,
  'collapse_notification': instance.collapseNotification,
  'warning_enabled': instance.warningEnabled,
};

const _$DefaultInterruptionLevelEnumMap = {
  DefaultInterruptionLevel.passive: 'passive',
  DefaultInterruptionLevel.active: 'active',
  DefaultInterruptionLevel.timeSensitive: 'time_sensitive',
  DefaultInterruptionLevel.critical: 'critical',
};
