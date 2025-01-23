// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'map_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapConfigImpl _$$MapConfigImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MapConfigImpl',
      json,
      ($checkedConvert) {
        final val = _$MapConfigImpl(
          colorScheme: $checkedConvert('color_scheme',
              (v) => MapColorScheme.fromJson(v as Map<String, dynamic>)),
          minScale: $checkedConvert(
              'min_scale', (v) => (v as num?)?.toDouble() ?? 0.8),
          maxScale: $checkedConvert(
              'max_scale', (v) => (v as num?)?.toDouble() ?? 20),
        );
        return val;
      },
      fieldKeyMap: const {
        'colorScheme': 'color_scheme',
        'minScale': 'min_scale',
        'maxScale': 'max_scale'
      },
    );

Map<String, dynamic> _$$MapConfigImplToJson(_$MapConfigImpl instance) =>
    <String, dynamic>{
      'color_scheme': instance.colorScheme,
      'min_scale': instance.minScale,
      'max_scale': instance.maxScale,
    };

_$MapColorSchemeImpl _$$MapColorSchemeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MapColorSchemeImpl',
      json,
      ($checkedConvert) {
        final val = _$MapColorSchemeImpl(
          backgroundColor: $checkedConvert(
              'background_color', (v) => colorFromJson(v as String)),
          worldLandColor: $checkedConvert(
              'world_land_color', (v) => colorFromJson(v as String)),
          worldLineColor: $checkedConvert(
              'world_line_color', (v) => colorFromJson(v as String)),
          japanLandColor: $checkedConvert(
              'japan_land_color', (v) => colorFromJson(v as String)),
          japanLineColor: $checkedConvert(
              'japan_line_color', (v) => colorFromJson(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'backgroundColor': 'background_color',
        'worldLandColor': 'world_land_color',
        'worldLineColor': 'world_line_color',
        'japanLandColor': 'japan_land_color',
        'japanLineColor': 'japan_line_color'
      },
    );

Map<String, dynamic> _$$MapColorSchemeImplToJson(
        _$MapColorSchemeImpl instance) =>
    <String, dynamic>{
      'background_color': colorToJson(instance.backgroundColor),
      'world_land_color': colorToJson(instance.worldLandColor),
      'world_line_color': colorToJson(instance.worldLineColor),
      'japan_land_color': colorToJson(instance.japanLandColor),
      'japan_line_color': colorToJson(instance.japanLineColor),
    };
