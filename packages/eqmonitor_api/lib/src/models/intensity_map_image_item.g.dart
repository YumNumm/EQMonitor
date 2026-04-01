// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_map_image_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IntensityMapImageItem _$IntensityMapImageItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_IntensityMapImageItem',
  json,
  ($checkedConvert) {
    final val = _IntensityMapImageItem(
      id: $checkedConvert('id', (v) => v as String),
      language: $checkedConvert(
        'language',
        (v) => $enumDecode(_$AppLocaleEnumMap, v),
      ),
      imageUrl: $checkedConvert('image_url', (v) => v as String),
      fileSize: $checkedConvert('file_size', (v) => v as num),
      size: $checkedConvert(
        'size',
        (v) => Size.fromJson(v as Map<String, dynamic>),
      ),
      generatorInstance: $checkedConvert(
        'generator_instance',
        (v) => v as String,
      ),
      renderDurationMs: $checkedConvert('render_duration_ms', (v) => v as num),
      uploadDurationMs: $checkedConvert('upload_duration_ms', (v) => v as num),
      totalDurationMs: $checkedConvert('total_duration_ms', (v) => v as num),
      generatedAt: $checkedConvert(
        'generated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'fileSize': 'file_size',
    'generatorInstance': 'generator_instance',
    'renderDurationMs': 'render_duration_ms',
    'uploadDurationMs': 'upload_duration_ms',
    'totalDurationMs': 'total_duration_ms',
    'generatedAt': 'generated_at',
  },
);

Map<String, dynamic> _$IntensityMapImageItemToJson(
  _IntensityMapImageItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'language': instance.language,
  'image_url': instance.imageUrl,
  'file_size': instance.fileSize,
  'size': instance.size,
  'generator_instance': instance.generatorInstance,
  'render_duration_ms': instance.renderDurationMs,
  'upload_duration_ms': instance.uploadDurationMs,
  'total_duration_ms': instance.totalDurationMs,
  'generated_at': instance.generatedAt.toIso8601String(),
};

const _$AppLocaleEnumMap = {
  AppLocale.ja: 'ja',
  AppLocale.en: 'en',
  AppLocale.zh: 'zh',
};
