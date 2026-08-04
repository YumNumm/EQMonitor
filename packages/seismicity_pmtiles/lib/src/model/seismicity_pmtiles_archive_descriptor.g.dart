// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seismicity_pmtiles_archive_descriptor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityPmTilesArchiveDescriptor
_$SeismicityPmTilesArchiveDescriptorFromJson(Map<String, dynamic> json) =>
    _SeismicityPmTilesArchiveDescriptor(
      source: SeismicityPmTilesSource.fromJson(
        json['source'] as Map<String, dynamic>,
      ),
      schemaVersion: (json['schemaVersion'] as num).toInt(),
      dataZoom: (json['dataZoom'] as num).toInt(),
      expectedSizeBytes: (json['expectedSizeBytes'] as num).toInt(),
      expectedFeatureCount: (json['expectedFeatureCount'] as num).toInt(),
      archiveRevision: json['archiveRevision'] as String,
      periodFrom: DateTime.parse(json['periodFrom'] as String),
      periodTo: DateTime.parse(json['periodTo'] as String),
    );

Map<String, dynamic> _$SeismicityPmTilesArchiveDescriptorToJson(
  _SeismicityPmTilesArchiveDescriptor instance,
) => <String, dynamic>{
  'source': instance.source.toJson(),
  'schemaVersion': instance.schemaVersion,
  'dataZoom': instance.dataZoom,
  'expectedSizeBytes': instance.expectedSizeBytes,
  'expectedFeatureCount': instance.expectedFeatureCount,
  'archiveRevision': instance.archiveRevision,
  'periodFrom': instance.periodFrom.toIso8601String(),
  'periodTo': instance.periodTo.toIso8601String(),
};
