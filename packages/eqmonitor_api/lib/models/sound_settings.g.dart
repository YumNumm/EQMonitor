// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'sound_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SoundSettings _$SoundSettingsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_SoundSettings', json, ($checkedConvert) {
      final val = _SoundSettings(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecode(_$SoundSettingsModeEnumMap, v),
        ),
        map: $checkedConvert(
          'map',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SoundSettingsToJson(_SoundSettings instance) =>
    <String, dynamic>{'mode': instance.mode, 'map': ?instance.map};

const _$SoundSettingsModeEnumMap = {
  SoundSettingsMode.maxIntensity: 'max_intensity',
  SoundSettingsMode.locationIntensity: 'location_intensity',
  SoundSettingsMode.registeredMax: 'registered_max',
};
