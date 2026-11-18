import 'package:json_annotation/json_annotation.dart';

part 'region_map_metadata.g.dart';

@JsonSerializable(createToJson: false)
final class const RegionMapMetadata({
  @JsonKey(name: 'vector_layers')
  required final List<RegionMapSourceLayer> layers,
}) {
  factory fromJson(Map<String, dynamic> json) =>
      _$RegionMapMetadataFromJson(json);
}

@JsonSerializable(createToJson: false)
final class const RegionMapSourceLayer({required final String id}) {
  factory fromJson(Map<String, dynamic> json) =>
      _$RegionMapSourceLayerFromJson(json);
}
