// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'notification_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsResponseImpl _$$NotificationSettingsResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$NotificationSettingsResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$NotificationSettingsResponseImpl(
          earthquake: $checkedConvert(
              'earthquake',
              (v) => (v as List<dynamic>)
                  .map((e) => DevicesEarthquakeSettings.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          eew: $checkedConvert(
              'eew',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      DevicesEewSettings.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$NotificationSettingsResponseImplToJson(
        _$NotificationSettingsResponseImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'eew': instance.eew,
    };
