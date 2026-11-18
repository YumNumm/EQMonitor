// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_region_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShakeDetectionRegionCatalog _$ShakeDetectionRegionCatalogFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ShakeDetectionRegionCatalog',
  json,
  ($checkedConvert) {
    final val = _ShakeDetectionRegionCatalog(
      stations: $checkedConvert(
        'stations',
        (v) => (v as List<dynamic>)
            .map(
              (e) =>
                  KyoshinObservationPoint.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      ),
      prefectureNames: $checkedConvert(
        'prefecture_names',
        (v) => Map<String, String>.from(v as Map),
      ),
      regionNames: $checkedConvert(
        'region_names',
        (v) => Map<String, String>.from(v as Map),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'prefectureNames': 'prefecture_names',
    'regionNames': 'region_names',
  },
);

Map<String, dynamic> _$ShakeDetectionRegionCatalogToJson(
  _ShakeDetectionRegionCatalog instance,
) => <String, dynamic>{
  'stations': instance.stations.map((e) => e.toJson()).toList(),
  'prefecture_names': instance.prefectureNames,
  'region_names': instance.regionNames,
};
