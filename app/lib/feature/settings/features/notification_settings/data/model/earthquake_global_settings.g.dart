// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeGlobalSettings _$EarthquakeGlobalSettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeGlobalSettings',
  json,
  ($checkedConvert) {
    final val = _EarthquakeGlobalSettings(
      enabled: $checkedConvert('enabled', (v) => v as bool),
      defaultSound: $checkedConvert('default_sound', (v) => v as String),
      defaultInterruptionLevel: $checkedConvert(
        'default_interruption_level',
        (v) => $enumDecode(_$InterruptionLevelEnumMap, v),
      ),
      estimatedIntensityEnabled: $checkedConvert(
        'estimated_intensity_enabled',
        (v) => v as bool,
      ),
      collapseNotification: $checkedConvert(
        'collapse_notification',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'defaultSound': 'default_sound',
    'defaultInterruptionLevel': 'default_interruption_level',
    'estimatedIntensityEnabled': 'estimated_intensity_enabled',
    'collapseNotification': 'collapse_notification',
  },
);

Map<String, dynamic> _$EarthquakeGlobalSettingsToJson(
  _EarthquakeGlobalSettings instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'default_sound': instance.defaultSound,
  'default_interruption_level':
      _$InterruptionLevelEnumMap[instance.defaultInterruptionLevel]!,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
  'collapse_notification': instance.collapseNotification,
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'timeSensitive',
  InterruptionLevel.critical: 'critical',
};
