import 'package:json_annotation/json_annotation.dart';

part 'region_map_metadata.g.dart';

@JsonSerializable(createToJson: false)
final class RegionMapMetadata {
  const new({required this.layers});

  factory fromJson(Map<String, dynamic> json) =>
      _$RegionMapMetadataFromJson(json);

  @JsonKey(name: 'vector_layers')
  final List<RegionMapSourceLayer> layers;
}

@JsonSerializable(createToJson: false)
final class RegionMapSourceLayer {
  const new({required this.id});

  factory fromJson(Map<String, dynamic> json) =>
      _$RegionMapSourceLayerFromJson(json);

  final String id;
}
