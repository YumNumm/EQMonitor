// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_defaults_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDefaultsRequest _$NotificationDefaultsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationDefaultsRequest',
  json,
  ($checkedConvert) {
    final val = _NotificationDefaultsRequest(
      eewDefaultSound: $checkedConvert(
        'eew_default_sound',
        (v) => v as String?,
      ),
      eewDefaultInterruptionLevel: $checkedConvert(
        'eew_default_interruption_level',
        (v) => $enumDecodeNullable(_$EewDefaultInterruptionLevelEnumMap, v),
      ),
      earthquakeDefaultSound: $checkedConvert(
        'earthquake_default_sound',
        (v) => v as String?,
      ),
      earthquakeDefaultInterruptionLevel: $checkedConvert(
        'earthquake_default_interruption_level',
        (v) =>
            $enumDecodeNullable(_$EarthquakeDefaultInterruptionLevelEnumMap, v),
      ),
      startLiveActivity: $checkedConvert(
        'start_live_activity',
        (v) => v as bool?,
      ),
      eewOnePointEnabled: $checkedConvert(
        'eew_one_point_enabled',
        (v) => v as bool?,
      ),
      eewCollapseNotification: $checkedConvert(
        'eew_collapse_notification',
        (v) => v as bool?,
      ),
      earthquakeEstimatedIntensityEnabled: $checkedConvert(
        'earthquake_estimated_intensity_enabled',
        (v) => v as bool?,
      ),
      earthquakeCollapseNotification: $checkedConvert(
        'earthquake_collapse_notification',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'eewDefaultSound': 'eew_default_sound',
    'eewDefaultInterruptionLevel': 'eew_default_interruption_level',
    'earthquakeDefaultSound': 'earthquake_default_sound',
    'earthquakeDefaultInterruptionLevel':
        'earthquake_default_interruption_level',
    'startLiveActivity': 'start_live_activity',
    'eewOnePointEnabled': 'eew_one_point_enabled',
    'eewCollapseNotification': 'eew_collapse_notification',
    'earthquakeEstimatedIntensityEnabled':
        'earthquake_estimated_intensity_enabled',
    'earthquakeCollapseNotification': 'earthquake_collapse_notification',
  },
);

Map<String, dynamic> _$NotificationDefaultsRequestToJson(
  _NotificationDefaultsRequest instance,
) => <String, dynamic>{
  'eew_default_sound': ?instance.eewDefaultSound,
  'eew_default_interruption_level': ?instance.eewDefaultInterruptionLevel,
  'earthquake_default_sound': ?instance.earthquakeDefaultSound,
  'earthquake_default_interruption_level':
      ?instance.earthquakeDefaultInterruptionLevel,
  'start_live_activity': ?instance.startLiveActivity,
  'eew_one_point_enabled': ?instance.eewOnePointEnabled,
  'eew_collapse_notification': ?instance.eewCollapseNotification,
  'earthquake_estimated_intensity_enabled':
      ?instance.earthquakeEstimatedIntensityEnabled,
  'earthquake_collapse_notification': ?instance.earthquakeCollapseNotification,
};

const _$EewDefaultInterruptionLevelEnumMap = {
  EewDefaultInterruptionLevel.passive: 'passive',
  EewDefaultInterruptionLevel.active: 'active',
  EewDefaultInterruptionLevel.timeSensitive: 'time_sensitive',
  EewDefaultInterruptionLevel.critical: 'critical',
};

const _$EarthquakeDefaultInterruptionLevelEnumMap = {
  EarthquakeDefaultInterruptionLevel.passive: 'passive',
  EarthquakeDefaultInterruptionLevel.active: 'active',
  EarthquakeDefaultInterruptionLevel.timeSensitive: 'time_sensitive',
  EarthquakeDefaultInterruptionLevel.critical: 'critical',
};
