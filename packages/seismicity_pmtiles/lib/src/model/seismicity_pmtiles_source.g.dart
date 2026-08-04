// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seismicity_pmtiles_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeismicityPmTilesNetworkSource _$SeismicityPmTilesNetworkSourceFromJson(
  Map<String, dynamic> json,
) => SeismicityPmTilesNetworkSource(
  archiveUri: Uri.parse(json['archiveUri'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SeismicityPmTilesNetworkSourceToJson(
  SeismicityPmTilesNetworkSource instance,
) => <String, dynamic>{
  'archiveUri': instance.archiveUri.toString(),
  'runtimeType': instance.$type,
};

SeismicityPmTilesFileSource _$SeismicityPmTilesFileSourceFromJson(
  Map<String, dynamic> json,
) => SeismicityPmTilesFileSource(
  path: json['path'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SeismicityPmTilesFileSourceToJson(
  SeismicityPmTilesFileSource instance,
) => <String, dynamic>{'path': instance.path, 'runtimeType': instance.$type};

SeismicityPmTilesAssetSource _$SeismicityPmTilesAssetSourceFromJson(
  Map<String, dynamic> json,
) => SeismicityPmTilesAssetSource(
  assetKey: json['assetKey'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SeismicityPmTilesAssetSourceToJson(
  SeismicityPmTilesAssetSource instance,
) => <String, dynamic>{
  'assetKey': instance.assetKey,
  'runtimeType': instance.$type,
};
