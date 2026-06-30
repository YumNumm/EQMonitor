// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsResponse _$NotificationSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_NotificationSettingsResponse',
  json,
  ($checkedConvert) {
    final val = _NotificationSettingsResponse(
      notificationEnabled: $checkedConvert(
        'notification_enabled',
        (v) => v as bool,
      ),
      tsunamiEnabled: $checkedConvert('tsunami_enabled', (v) => v as bool),
      trainingEnabled: $checkedConvert('training_enabled', (v) => v as bool),
      nankaiExtraordinaryEnabled: $checkedConvert(
        'nankai_extraordinary_enabled',
        (v) => v as bool,
      ),
      nankaiRegularEnabled: $checkedConvert(
        'nankai_regular_enabled',
        (v) => v as bool,
      ),
      hokkaido3renOffshoreEnabled: $checkedConvert(
        'hokkaido3ren_offshore_enabled',
        (v) => v as bool,
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
    'hokkaido3renOffshoreEnabled': 'hokkaido3ren_offshore_enabled',
  },
);

Map<String, dynamic> _$NotificationSettingsResponseToJson(
  _NotificationSettingsResponse instance,
) => <String, dynamic>{
  'notification_enabled': instance.notificationEnabled,
  'tsunami_enabled': instance.tsunamiEnabled,
  'training_enabled': instance.trainingEnabled,
  'nankai_extraordinary_enabled': instance.nankaiExtraordinaryEnabled,
  'nankai_regular_enabled': instance.nankaiRegularEnabled,
  'hokkaido3ren_offshore_enabled': instance.hokkaido3renOffshoreEnabled,
};
