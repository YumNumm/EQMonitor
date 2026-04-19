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
      );
      return val;
    });

Map<String, dynamic> _$MapConfigurationToJson(_MapConfiguration instance) =>
    <String, dynamic>{'theme': _$MapThemeEnumMap[instance.theme]!};

const _$MapThemeEnumMap = {
  MapTheme.light: 'light',
  MapTheme.dark: 'dark',
  MapTheme.system: 'system',
};

_MapColorScheme _$MapColorSchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_MapColorScheme',
      json,
      ($checkedConvert) {
        final val = _MapColorScheme(
          backgroundColor: $checkedConvert(
            'background_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          worldLandColor: $checkedConvert(
            'world_land_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          worldLineColor: $checkedConvert(
            'world_line_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          japanLandColor: $checkedConvert(
            'japan_land_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          japanLineColor: $checkedConvert(
            'japan_line_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'backgroundColor': 'background_color',
        'worldLandColor': 'world_land_color',
        'worldLineColor': 'world_line_color',
        'japanLandColor': 'japan_land_color',
        'japanLineColor': 'japan_line_color',
      },
    );

Map<String, dynamic> _$MapColorSchemeToJson(
  _MapColorScheme instance,
) => <String, dynamic>{
  'background_color': const ColorConverter().toJson(instance.backgroundColor),
  'world_land_color': const ColorConverter().toJson(instance.worldLandColor),
  'world_line_color': const ColorConverter().toJson(instance.worldLineColor),
  'japan_land_color': const ColorConverter().toJson(instance.japanLandColor),
  'japan_line_color': const ColorConverter().toJson(instance.japanLineColor),
};
