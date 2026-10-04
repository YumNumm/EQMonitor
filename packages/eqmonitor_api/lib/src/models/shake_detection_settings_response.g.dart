// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionSettingsResponse _$ShakeDetectionSettingsResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_ShakeDetectionSettingsResponse', json, ($checkedConvert) {
  final val = _ShakeDetectionSettingsResponse(
    settings: $checkedConvert(
      'settings',
      (v) => (v as List<dynamic>)
          .map(
            (e) => ShakeDetectionSettingResponse.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
    requiresReconfiguration: $checkedConvert(
      'requires_reconfiguration',
      (v) => v as bool,
    ),
  );
  return val;
}, fieldKeyMap: const {'requiresReconfiguration': 'requires_reconfiguration'});

Map<String, dynamic> _$ShakeDetectionSettingsResponseToJson(
  _ShakeDetectionSettingsResponse instance,
) => <String, dynamic>{
  'settings': instance.settings,
  'requires_reconfiguration': instance.requiresReconfiguration,
};
