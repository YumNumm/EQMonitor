// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsRequest _$NotificationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettingsRequest',
  json,
  ($checkedConvert) {
    final val = _NotificationSettingsRequest(
      notificationEnabled: $checkedConvert(
        'notification_enabled',
        (v) => v as bool?,
      ),
      tsunamiEnabled: $checkedConvert('tsunami_enabled', (v) => v as bool?),
      trainingEnabled: $checkedConvert('training_enabled', (v) => v as bool?),
      nankaiExtraordinaryEnabled: $checkedConvert(
        'nankai_extraordinary_enabled',
        (v) => v as bool?,
      ),
      nankaiRegularEnabled: $checkedConvert(
        'nankai_regular_enabled',
        (v) => v as bool?,
      ),
      vyse60Enabled: $checkedConvert('vyse60_enabled', (v) => v as bool?),
      earthquakeNoticeEnabled: $checkedConvert(
        'earthquake_notice_enabled',
        (v) => v as bool?,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificationEnabled': 'notification_enabled',
    'tsunamiEnabled': 'tsunami_enabled',
    'trainingEnabled': 'training_enabled',
    'nankaiExtraordinaryEnabled': 'nankai_extraordinary_enabled',
    'nankaiRegularEnabled': 'nankai_regular_enabled',
    'vyse60Enabled': 'vyse60_enabled',
    'earthquakeNoticeEnabled': 'earthquake_notice_enabled',
  },
);

Map<String, dynamic> _$NotificationSettingsRequestToJson(
  _NotificationSettingsRequest instance,
) => <String, dynamic>{
  'notification_enabled': ?instance.notificationEnabled,
  'tsunami_enabled': ?instance.tsunamiEnabled,
  'training_enabled': ?instance.trainingEnabled,
  'nankai_extraordinary_enabled': ?instance.nankaiExtraordinaryEnabled,
  'nankai_regular_enabled': ?instance.nankaiRegularEnabled,
  'vyse60_enabled': ?instance.vyse60Enabled,
  'earthquake_notice_enabled': ?instance.earthquakeNoticeEnabled,
};
