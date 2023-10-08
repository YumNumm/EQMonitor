// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'map_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MapConfig _$$_MapConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_MapConfig',
      json,
      ($checkedConvert) {
        final val = _$_MapConfig(
          minScale: $checkedConvert(
              'minScale', (v) => (v as num?)?.toDouble() ?? 0.8),
          maxScale:
              $checkedConvert('maxScale', (v) => (v as num?)?.toDouble() ?? 20),
          colorScheme: $checkedConvert('colorScheme',
              (v) => MapColorScheme.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_MapConfigToJson(_$_MapConfig instance) =>
    <String, dynamic>{
      'minScale': instance.minScale,
      'maxScale': instance.maxScale,
      'colorScheme': instance.colorScheme,
    };

_$_MapColorScheme _$$_MapColorSchemeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_MapColorScheme',
      json,
      ($checkedConvert) {
        final val = _$_MapColorScheme(
          backgroundColor: $checkedConvert(
              'backgroundColor', (v) => colorFromJson(v as String)),
          worldLandColor: $checkedConvert(
              'worldLandColor', (v) => colorFromJson(v as String)),
          worldCoastlineColor: $checkedConvert(
              'worldCoastlineColor', (v) => colorFromJson(v as String)),
          worldBorderLineColor: $checkedConvert(
              'worldBorderLineColor', (v) => colorFromJson(v as String)),
          japanLandColor: $checkedConvert(
              'japanLandColor', (v) => colorFromJson(v as String)),
          japanCoastlineColor: $checkedConvert(
              'japanCoastlineColor', (v) => colorFromJson(v as String)),
          japanBorderLineColor: $checkedConvert(
              'japanBorderLineColor', (v) => colorFromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_MapColorSchemeToJson(_$_MapColorScheme instance) =>
    <String, dynamic>{
      'backgroundColor': colorToJson(instance.backgroundColor),
      'worldLandColor': colorToJson(instance.worldLandColor),
      'worldCoastlineColor': colorToJson(instance.worldCoastlineColor),
      'worldBorderLineColor': colorToJson(instance.worldBorderLineColor),
      'japanLandColor': colorToJson(instance.japanLandColor),
      'japanCoastlineColor': colorToJson(instance.japanCoastlineColor),
      'japanBorderLineColor': colorToJson(instance.japanBorderLineColor),
    };
