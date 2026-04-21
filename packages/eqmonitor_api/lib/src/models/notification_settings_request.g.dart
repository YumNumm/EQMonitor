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
      tsunamiEnabled: $checkedConvert('tsunami_enabled', (v) => v as bool?),
      trainingEnabled: $checkedConvert('training_enabled', (v) => v as bool?),
    );
    return val;
  },
  fieldKeyMap: const {
    'tsunamiEnabled': 'tsunami_enabled',
    'trainingEnabled': 'training_enabled',
  },
);

Map<String, dynamic> _$NotificationSettingsRequestToJson(
  _NotificationSettingsRequest instance,
) => <String, dynamic>{
  'tsunami_enabled': ?instance.tsunamiEnabled,
  'training_enabled': ?instance.trainingEnabled,
};
