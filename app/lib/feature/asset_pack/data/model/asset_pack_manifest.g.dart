// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'asset_pack_manifest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AssetPackManifestToJson(AssetPackManifest instance) =>
    <String, dynamic>{
      'pack_version': instance.packVersion,
      'schema_version': instance.schemaVersion,
      'generated_at': instance.generatedAt,
      'assets': instance.assets,
    };

Map<String, dynamic> _$AssetPackManifestItemToJson(
  AssetPackManifestItem instance,
) => <String, dynamic>{
  'id': _$AssetPackAssetIdEnumMap[instance.id]!,
  'kind': _$AssetPackAssetKindEnumMap[instance.kind]!,
  'path': instance.path,
  'schema_version': instance.schemaVersion,
  'source_version': instance.sourceVersion,
  'source_updated_at': instance.sourceUpdatedAt,
  'source_urls': instance.sourceUrls,
  'sha256': instance.sha256,
  'size_bytes': instance.sizeBytes,
};

const _$AssetPackAssetIdEnumMap = {
  AssetPackAssetId.baseMapPmtiles: 'BASE_MAP_PMTILES',
  AssetPackAssetId.jmaCodeTable: 'JMA_CODE_TABLE',
  AssetPackAssetId.kyoshinObservationPoints: 'KYOSHIN_OBSERVATION_POINTS',
  AssetPackAssetId.earthquakeStations: 'EARTHQUAKE_STATIONS',
  AssetPackAssetId.tsunamiStations: 'TSUNAMI_STATIONS',
  AssetPackAssetId.shindoDbStations: 'SHINDO_DB_STATIONS',
};

const _$AssetPackAssetKindEnumMap = {
  AssetPackAssetKind.pmtiles: 'pmtiles',
  AssetPackAssetKind.json: 'json',
};
