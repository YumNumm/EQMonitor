// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppTheme _$AppThemeFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_AppTheme', json, ($checkedConvert) {
  final val = _AppTheme(
    name: $checkedConvert('name', (v) => v as String),
    version: $checkedConvert('version', (v) => (v as num).toInt()),
    author: $checkedConvert('author', (v) => v as String),
    modes: $checkedConvert(
      'modes',
      (v) => (v as List<dynamic>)
          .map((e) => $enumDecode(_$ThemeBrightnessModeEnumMap, e))
          .toList(),
    ),
    light: $checkedConvert(
      'light',
      (v) =>
          v == null ? null : ThemeColorSet.fromJson(v as Map<String, dynamic>),
    ),
    dark: $checkedConvert(
      'dark',
      (v) =>
          v == null ? null : ThemeColorSet.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AppThemeToJson(_AppTheme instance) => <String, dynamic>{
  'name': instance.name,
  'version': instance.version,
  'author': instance.author,
  'modes': instance.modes.map((e) => _$ThemeBrightnessModeEnumMap[e]!).toList(),
  'light': instance.light,
  'dark': instance.dark,
};

const _$ThemeBrightnessModeEnumMap = {
  ThemeBrightnessMode.light: 'light',
  ThemeBrightnessMode.dark: 'dark',
};
