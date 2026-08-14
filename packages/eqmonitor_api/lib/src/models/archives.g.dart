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
      archiveRevision: $checkedConvert('archive_revision', (v) => v as String),
      url: $checkedConvert('url', (v) => v as String),
      featureCount: $checkedConvert('feature_count', (v) => (v as num).toInt()),
      sizeBytes: $checkedConvert('size_bytes', (v) => (v as num).toInt()),
      dataZoom: $checkedConvert('data_zoom', (v) => (v as num?)?.toInt()),
      bounds: $checkedConvert(
        'bounds',
        (v) => v == null ? null : Bounds.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'queryRevision': 'query_revision',
    'archiveRevision': 'archive_revision',
    'featureCount': 'feature_count',
    'sizeBytes': 'size_bytes',
    'dataZoom': 'data_zoom',
  },
);

Map<String, dynamic> _$ArchivesToJson(_Archives instance) => <String, dynamic>{
  'partition': instance.partition,
  'period': instance.period,
  'query_revision': instance.queryRevision,
  'archive_revision': instance.archiveRevision,
  'url': instance.url,
  'feature_count': instance.featureCount,
  'size_bytes': instance.sizeBytes,
  'data_zoom': ?instance.dataZoom,
  'bounds': ?instance.bounds,
};

const _$PartitionEnumMap = {Partition.year: 'YEAR', Partition.day: 'DAY'};
