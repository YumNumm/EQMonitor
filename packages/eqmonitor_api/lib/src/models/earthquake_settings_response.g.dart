// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeSettingsResponse _$EarthquakeSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeSettingsResponse',
  json,
  ($checkedConvert) {
    final val = _EarthquakeSettingsResponse(
      enabled: $checkedConvert('enabled', (v) => v as bool),
      defaultSound: $checkedConvert('default_sound', (v) => v as String),
      defaultInterruptionLevel: $checkedConvert(
        'default_interruption_level',
        (v) => $enumDecode(_$DefaultInterruptionLevelEnumMap, v),
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

Map<String, dynamic> _$EarthquakeSettingsResponseToJson(
  _EarthquakeSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'default_sound': instance.defaultSound,
  'default_interruption_level': instance.defaultInterruptionLevel,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
  'collapse_notification': instance.collapseNotification,
};

const _$DefaultInterruptionLevelEnumMap = {
  DefaultInterruptionLevel.passive: 'passive',
  DefaultInterruptionLevel.active: 'active',
  DefaultInterruptionLevel.timeSensitive: 'time_sensitive',
  DefaultInterruptionLevel.critical: 'critical',
};
