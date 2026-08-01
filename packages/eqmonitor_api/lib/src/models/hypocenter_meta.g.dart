// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HypocenterMeta _$HypocenterMetaFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_HypocenterMeta',
      json,
      ($checkedConvert) {
        final val = _HypocenterMeta(
          datasetRevision: $checkedConvert(
            'dataset_revision',
            (v) => v as String,
          ),
          dataUpdatedAt: $checkedConvert(
            'data_updated_at',
            (v) => DateTime.parse(v as String),
          ),
          coverage: $checkedConvert(
            'coverage',
            (v) => HypocenterCoverage.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'datasetRevision': 'dataset_revision',
        'dataUpdatedAt': 'data_updated_at',
      },
    );

Map<String, dynamic> _$HypocenterMetaToJson(_HypocenterMeta instance) =>
    <String, dynamic>{
      'dataset_revision': instance.datasetRevision,
      'data_updated_at': instance.dataUpdatedAt.toIso8601String(),
      'coverage': instance.coverage,
    };
