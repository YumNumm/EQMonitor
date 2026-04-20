import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

class LatLngBoundaryJsonConverter
    extends JsonConverter<LatLngBoundary, Map<String, dynamic>> {
  const LatLngBoundaryJsonConverter();

  @override
  LatLngBoundary fromJson(Map<String, dynamic> json) => LatLngBoundary.fromTwo(
    LatLng.fromJson(json['northEast'] as Map<String, dynamic>),
    LatLng.fromJson(json['southWest'] as Map<String, dynamic>),
  );

  @override
  Map<String, dynamic> toJson(LatLngBoundary object) => {
    'northEast': object.northEast.toJson(),
    'southWest': object.southWest.toJson(),
  };
}

class LatLngJsonConverter extends JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngJsonConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) => LatLng.fromJson(json);

  @override
  Map<String, dynamic> toJson(LatLng object) => object.toJson();
}
