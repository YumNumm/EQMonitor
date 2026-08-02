// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'archives.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Archives _$ArchivesFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Archives',
  json,
  ($checkedConvert) {
    final val = _Archives(
      partition: $checkedConvert(
        'partition',
        (v) => $enumDecode(_$PartitionEnumMap, v),
      ),
      period: $checkedConvert(
        'period',
        (v) => HypocenterCoverage.fromJson(v as Map<String, dynamic>),
      ),
      queryRevision: $checkedConvert('query_revision', (v) => v as String),
      url: $checkedConvert('url', (v) => v as String),
      featureCount: $checkedConvert('feature_count', (v) => (v as num).toInt()),
      sizeBytes: $checkedConvert('size_bytes', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'queryRevision': 'query_revision',
    'featureCount': 'feature_count',
    'sizeBytes': 'size_bytes',
  },
);

Map<String, dynamic> _$ArchivesToJson(_Archives instance) => <String, dynamic>{
  'partition': instance.partition,
  'period': instance.period,
  'query_revision': instance.queryRevision,
  'url': instance.url,
  'feature_count': instance.featureCount,
  'size_bytes': instance.sizeBytes,
};

const _$PartitionEnumMap = {Partition.year: 'YEAR', Partition.day: 'DAY'};
