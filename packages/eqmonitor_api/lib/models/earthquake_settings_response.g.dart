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
      sound: $checkedConvert(
        'sound',
        (v) => SoundSettingsResponse.fromJson(v as Map<String, dynamic>),
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

Map<String, dynamic> _$EarthquakeSettingsResponseToJson(
  _EarthquakeSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'sound': instance.sound,
  'hypocenter_update_enabled': instance.hypocenterUpdateEnabled,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
};
