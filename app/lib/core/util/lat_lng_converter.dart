import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class LatLngConverter
    implements JsonConverter<LatLng, List<double>> {
  const LatLngConverter();

  @override
  LatLng fromJson(List<double> json) =>
      LatLng(json[0], json[1]);

  @override
  List<double> toJson(LatLng object) => [
    object.longitude,
    object.latitude,
  ];
}
