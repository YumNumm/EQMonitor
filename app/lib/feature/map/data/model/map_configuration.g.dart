// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'map_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapConfigurationImpl _$$MapConfigurationImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$MapConfigurationImpl', json, (
  $checkedConvert,
) {
  final val = _$MapConfigurationImpl(
    theme: $checkedConvert(
      'theme',
      (v) => $enumDecode(_$MapThemeEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$$MapConfigurationImplToJson(
  _$MapConfigurationImpl instance,
) => <String, dynamic>{
  'theme': _$MapThemeEnumMap[instance.theme]!,
};

const _$MapThemeEnumMap = {
  MapTheme.light: 'light',
  MapTheme.dark: 'dark',
  MapTheme.system: 'system',
};

_$MapColorSchemeImpl _$$MapColorSchemeImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$MapColorSchemeImpl',
  json,
  ($checkedConvert) {
    final val = _$MapColorSchemeImpl(
      backgroundColor: $checkedConvert(
        'background_color',
        (v) => colorFromJson(v as String),
      ),
      worldLandColor: $checkedConvert(
        'world_land_color',
        (v) => colorFromJson(v as String),
      ),
      worldLineColor: $checkedConvert(
        'world_line_color',
        (v) => colorFromJson(v as String),
      ),
      japanLandColor: $checkedConvert(
        'japan_land_color',
        (v) => colorFromJson(v as String),
      ),
      japanLineColor: $checkedConvert(
        'japan_line_color',
        (v) => colorFromJson(v as String),
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

Map<String, dynamic> _$$MapColorSchemeImplToJson(
  _$MapColorSchemeImpl instance,
) => <String, dynamic>{
  'background_color': colorToJson(instance.backgroundColor),
  'world_land_color': colorToJson(instance.worldLandColor),
  'world_line_color': colorToJson(instance.worldLineColor),
  'japan_land_color': colorToJson(instance.japanLandColor),
  'japan_line_color': colorToJson(instance.japanLineColor),
};
