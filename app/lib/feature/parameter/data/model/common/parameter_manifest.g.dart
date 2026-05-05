// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterManifest _$ParameterManifestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ParameterManifest', json, ($checkedConvert) {
      final val = _ParameterManifest(
        parameters: $checkedConvert(
          'parameters',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    ParameterManifestItem.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ParameterManifestToJson(_ParameterManifest instance) =>
    <String, dynamic>{'parameters': instance.parameters};

_ParameterManifestItem _$ParameterManifestItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ParameterManifestItem',
  json,
  ($checkedConvert) {
    final val = _ParameterManifestItem(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ParameterTypeEnumMap, v),
      ),
      schemaVersion: $checkedConvert(
        'schema_version',
        (v) => (v as num).toInt(),
      ),
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
      sizeBytes: $checkedConvert('size_bytes', (v) => (v as num).toInt()),
      url: $checkedConvert('url', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'schemaVersion': 'schema_version',
    'sourceVersion': 'source_version',
    'sourceUpdatedAt': 'source_updated_at',
    'generatedAt': 'generated_at',
    'sourceUrls': 'source_urls',
    'sizeBytes': 'size_bytes',
  },
);

Map<String, dynamic> _$ParameterManifestItemToJson(
  _ParameterManifestItem instance,
) => <String, dynamic>{
  'type': _$ParameterTypeEnumMap[instance.type]!,
  'schema_version': instance.schemaVersion,
  'source_version': instance.sourceVersion,
  'source_updated_at': instance.sourceUpdatedAt,
  'generated_at': instance.generatedAt,
  'source_urls': instance.sourceUrls,
  'sha256': instance.sha256,
  'size_bytes': instance.sizeBytes,
  'url': instance.url,
};

const _$ParameterTypeEnumMap = {
  ParameterType.jmaCodeTable: 'jma_code_table',
  ParameterType.kyoshinObservationPoints: 'kyoshin_observation_points',
  ParameterType.earthquakeStations: 'earthquake_stations',
  ParameterType.tsunamiStations: 'tsunami_stations',
};
