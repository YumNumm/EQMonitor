// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'map_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapStyleConfigImpl _$$MapStyleConfigImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(r'_$MapStyleConfigImpl', json, ($checkedConvert) {
      final val = _$MapStyleConfigImpl(
        theme: $checkedConvert(
          'theme',
          (v) => $enumDecode(_$MapStyleThemeEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$$MapStyleConfigImplToJson(
  _$MapStyleConfigImpl instance,
) => <String, dynamic>{'theme': _$MapStyleThemeEnumMap[instance.theme]!};

const _$MapStyleThemeEnumMap = {
  MapStyleTheme.light: 'light',
  MapStyleTheme.dark: 'dark',
  MapStyleTheme.system: 'system',
};

_$MapStyleColorSchemeImpl _$$MapStyleColorSchemeImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$MapStyleColorSchemeImpl',
  json,
  ($checkedConvert) {
    final val = _$MapStyleColorSchemeImpl(
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

Map<String, dynamic> _$$MapStyleColorSchemeImplToJson(
  _$MapStyleColorSchemeImpl instance,
) => <String, dynamic>{
  'background_color': const ColorConverter().toJson(instance.backgroundColor),
  'land_color': const ColorConverter().toJson(instance.landColor),
  'line_color': const ColorConverter().toJson(instance.lineColor),
  'japan_land_color': const ColorConverter().toJson(instance.japanLandColor),
  'japan_line_color': const ColorConverter().toJson(instance.japanLineColor),
};
