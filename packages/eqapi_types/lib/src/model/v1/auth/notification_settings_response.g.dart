// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsResponse _$NotificationSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationSettingsResponse', json, ($checkedConvert) {
  final val = _NotificationSettingsResponse(
    earthquake: $checkedConvert(
      'earthquake',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                DevicesEarthquakeSettings.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
    eew: $checkedConvert(
      'eew',
      (v) => (v as List<dynamic>)
          .map((e) => DevicesEewSettings.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$NotificationSettingsResponseToJson(
  _NotificationSettingsResponse instance,
) => <String, dynamic>{'earthquake': instance.earthquake, 'eew': instance.eew};
