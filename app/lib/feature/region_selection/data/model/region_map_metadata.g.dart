// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_map_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionMapMetadata _$RegionMapMetadataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RegionMapMetadata', json, ($checkedConvert) {
      final val = RegionMapMetadata(
        layers: $checkedConvert(
          'vector_layers',
          (v) => (v as List<dynamic>)
              .map(
                (e) => RegionMapSourceLayer.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'layers': 'vector_layers'});

RegionMapSourceLayer _$RegionMapSourceLayerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RegionMapSourceLayer', json, ($checkedConvert) {
  final val = RegionMapSourceLayer(
    id: $checkedConvert('id', (v) => v as String),
  );
  return val;
});
