// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EewGlobalSettings _$EewGlobalSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_EewGlobalSettings',
      json,
      ($checkedConvert) {
        final val = _EewGlobalSettings(
          enabled: $checkedConvert('enabled', (v) => v as bool),
          defaultSound: $checkedConvert('default_sound', (v) => v as String),
          defaultInterruptionLevel: $checkedConvert(
            'default_interruption_level',
            (v) => $enumDecode(_$InterruptionLevelEnumMap, v),
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

Map<String, dynamic> _$EewGlobalSettingsToJson(_EewGlobalSettings instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'default_sound': instance.defaultSound,
      'default_interruption_level':
          _$InterruptionLevelEnumMap[instance.defaultInterruptionLevel]!,
      'start_live_activity': instance.startLiveActivity,
      'collapse_notification': instance.collapseNotification,
      'warning_enabled': instance.warningEnabled,
    };

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'timeSensitive',
  InterruptionLevel.critical: 'critical',
};
