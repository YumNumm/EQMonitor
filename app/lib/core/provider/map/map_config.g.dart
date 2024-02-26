// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

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

Map<String, dynamic> _$$MapConfigImplToJson(_$MapConfigImpl instance) =>
    <String, dynamic>{
      'minScale': instance.minScale,
      'maxScale': instance.maxScale,
      'colorScheme': instance.colorScheme,
    };

_$MapColorSchemeImpl _$$MapColorSchemeImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MapColorSchemeImpl',
      json,
      ($checkedConvert) {
        final val = _$MapColorSchemeImpl(
          backgroundColor: $checkedConvert(
              'backgroundColor', (v) => colorFromJson(v as String)),
          worldLandColor: $checkedConvert(
              'worldLandColor', (v) => colorFromJson(v as String)),
          worldLineColor: $checkedConvert(
              'worldLineColor', (v) => colorFromJson(v as String)),
          japanLandColor: $checkedConvert(
              'japanLandColor', (v) => colorFromJson(v as String)),
          japanLineColor: $checkedConvert(
              'japanLineColor', (v) => colorFromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$MapColorSchemeImplToJson(
        _$MapColorSchemeImpl instance) =>
    <String, dynamic>{
      'backgroundColor': colorToJson(instance.backgroundColor),
      'worldLandColor': colorToJson(instance.worldLandColor),
      'worldLineColor': colorToJson(instance.worldLineColor),
      'japanLandColor': colorToJson(instance.japanLandColor),
      'japanLineColor': colorToJson(instance.japanLineColor),
    };
