// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParameterMetadata _$ParameterMetadataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_ParameterMetadata',
      json,
      ($checkedConvert) {
        final val = _ParameterMetadata(
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
        'sourceUrls': 'source_urls',
      },
    );

Map<String, dynamic> _$ParameterMetadataToJson(_ParameterMetadata instance) =>
    <String, dynamic>{
      'type': _$ParameterTypeEnumMap[instance.type]!,
      'schema_version': instance.schemaVersion,
      'source_version': instance.sourceVersion,
      'source_updated_at': instance.sourceUpdatedAt,
      'source_urls': instance.sourceUrls,
      'sha256': instance.sha256,
    };

const _$ParameterTypeEnumMap = {
  ParameterType.jmaCodeTable: 'JMA_CODE_TABLE',
  ParameterType.kyoshinObservationPoints: 'KYOSHIN_OBSERVATION_POINTS',
  ParameterType.earthquakeStations: 'EARTHQUAKE_STATIONS',
  ParameterType.tsunamiStations: 'TSUNAMI_STATIONS',
};
