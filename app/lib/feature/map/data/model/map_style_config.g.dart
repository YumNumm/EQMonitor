// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'map_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MapStyleConfig _$MapStyleConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_MapStyleConfig', json, ($checkedConvert) {
      final val = _MapStyleConfig(
        theme: $checkedConvert(
          'theme',
          (v) => $enumDecode(_$MapStyleThemeEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$MapStyleConfigToJson(_MapStyleConfig instance) =>
    <String, dynamic>{'theme': _$MapStyleThemeEnumMap[instance.theme]!};

const _$MapStyleThemeEnumMap = {
  MapStyleTheme.light: 'light',
  MapStyleTheme.dark: 'dark',
  MapStyleTheme.system: 'system',
};

_MapStyleColorScheme _$MapStyleColorSchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_MapStyleColorScheme',
      json,
      ($checkedConvert) {
        final val = _MapStyleColorScheme(
          backgroundColor: $checkedConvert(
            'background_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          landColor: $checkedConvert(
            'land_color',
            (v) => const ColorConverter().fromJson(v as String),
          ),
          lineColor: $checkedConvert(
            'line_color',
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
        'landColor': 'land_color',
        'lineColor': 'line_color',
        'japanLandColor': 'japan_land_color',
        'japanLineColor': 'japan_line_color',
      },
    );

Map<String, dynamic> _$MapStyleColorSchemeToJson(
  _MapStyleColorScheme instance,
) => <String, dynamic>{
  'background_color': const ColorConverter().toJson(instance.backgroundColor),
  'land_color': const ColorConverter().toJson(instance.landColor),
  'line_color': const ColorConverter().toJson(instance.lineColor),
  'japan_land_color': const ColorConverter().toJson(instance.japanLandColor),
  'japan_line_color': const ColorConverter().toJson(instance.japanLineColor),
};
