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
      notificationTiers: $checkedConvert(
        'notification_tiers',
        (v) => (v as List<dynamic>)
            .map((e) => NotificationTiers.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      estimatedIntensityEnabled: $checkedConvert(
        'estimated_intensity_enabled',
        (v) => v as bool,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificationTiers': 'notification_tiers',
    'estimatedIntensityEnabled': 'estimated_intensity_enabled',
  },
);

Map<String, dynamic> _$EarthquakeSettingsResponseToJson(
  _EarthquakeSettingsResponse instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'notification_tiers': instance.notificationTiers,
  'estimated_intensity_enabled': instance.estimatedIntensityEnabled,
};
