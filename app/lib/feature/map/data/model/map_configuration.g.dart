// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapConfiguration _$MapConfigurationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MapConfiguration', json, ($checkedConvert) {
      final val = _MapConfiguration(
        theme: $checkedConvert(
          'theme',
          (v) => $enumDecode(_$MapThemeEnumMap, v),
        ),
        styleString: $checkedConvert('style_string', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'styleString': 'style_string'});

Map<String, dynamic> _$MapConfigurationToJson(_MapConfiguration instance) =>
    <String, dynamic>{
      'theme': _$MapThemeEnumMap[instance.theme]!,
      'style_string': instance.styleString,
    };

const _$MapThemeEnumMap = {
  MapTheme.light: 'light',
  MapTheme.dark: 'dark',
  MapTheme.system: 'system',
};
