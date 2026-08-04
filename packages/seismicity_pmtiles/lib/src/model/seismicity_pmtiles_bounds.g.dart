// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seismicity_pmtiles_bounds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeismicityPmTilesBounds _$SeismicityPmTilesBoundsFromJson(
  Map<String, dynamic> json,
) => _SeismicityPmTilesBounds(
  minLongitude: (json['minLongitude'] as num).toDouble(),
  minLatitude: (json['minLatitude'] as num).toDouble(),
  maxLongitude: (json['maxLongitude'] as num).toDouble(),
  maxLatitude: (json['maxLatitude'] as num).toDouble(),
);

Map<String, dynamic> _$SeismicityPmTilesBoundsToJson(
  _SeismicityPmTilesBounds instance,
) => <String, dynamic>{
  'minLongitude': instance.minLongitude,
  'minLatitude': instance.minLatitude,
  'maxLongitude': instance.maxLongitude,
  'maxLatitude': instance.maxLatitude,
};
