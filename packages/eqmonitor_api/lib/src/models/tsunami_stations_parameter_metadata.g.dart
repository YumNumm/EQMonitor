// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'tsunami_stations_parameter_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TsunamiStationsParameterMetadata _$TsunamiStationsParameterMetadataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_TsunamiStationsParameterMetadata',
  json,
  ($checkedConvert) {
    final val = _TsunamiStationsParameterMetadata(
      type: $checkedConvert('type', (v) => v),
      schemaVersion: $checkedConvert('schema_version', (v) => v),
      sourceVersion: $checkedConvert('source_version', (v) => v as String),
      sourceUpdatedAt: $checkedConvert(
        'source_updated_at',
        (v) => v as String?,
      ),
      generatedAt: $checkedConvert('generated_at', (v) => v as String),
      sourceUrls: $checkedConvert(
        'source_urls',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      sha256: $checkedConvert('sha256', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemaVersion': 'schema_version',
    'sourceVersion': 'source_version',
    'sourceUpdatedAt': 'source_updated_at',
    'generatedAt': 'generated_at',
    'sourceUrls': 'source_urls',
  },
);

Map<String, dynamic> _$TsunamiStationsParameterMetadataToJson(
  _TsunamiStationsParameterMetadata instance,
) => <String, dynamic>{
  'type': instance.type,
  'schema_version': instance.schemaVersion,
  'source_version': instance.sourceVersion,
  'source_updated_at': instance.sourceUpdatedAt,
  'generated_at': instance.generatedAt,
  'source_urls': instance.sourceUrls,
  'sha256': instance.sha256,
};
