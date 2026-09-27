// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_tile_archive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstimatedIntensityTileArchive _$EstimatedIntensityTileArchiveFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_EstimatedIntensityTileArchive', json, ($checkedConvert) {
  final val = _EstimatedIntensityTileArchive(
    url: $checkedConvert('url', (v) => v as String),
    sizeBytes: $checkedConvert('size_bytes', (v) => (v as num).toInt()),
    sha256: $checkedConvert('sha256', (v) => v as String),
  );
  return val;
}, fieldKeyMap: const {'sizeBytes': 'size_bytes'});

Map<String, dynamic> _$EstimatedIntensityTileArchiveToJson(
  _EstimatedIntensityTileArchive instance,
) => <String, dynamic>{
  'url': instance.url,
  'size_bytes': instance.sizeBytes,
  'sha256': instance.sha256,
};
