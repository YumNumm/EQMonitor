// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EarthquakeSettingsRequest _$EarthquakeSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_EarthquakeSettingsRequest',
  json,
  ($checkedConvert) {
    final val = _EarthquakeSettingsRequest(
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

Map<String, dynamic> _$EarthquakeSettingsRequestToJson(
  _EarthquakeSettingsRequest instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'sound': instance.sound,
  'hypocenter_update_enabled': instance.hypocenterUpdateEnabled,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
};
