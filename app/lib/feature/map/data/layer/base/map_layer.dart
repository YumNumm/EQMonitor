import 'package:maplibre_gl/maplibre_gl.dart';

abstract class MapLayer {
  const MapLayer();

  Map<String, dynamic>? toGeoJsonSource();
  String get geoJsonSourceHash;
  LayerProperties? toLayerProperties();
  String get layerPropertiesHash;

  String get id;
  String get sourceId;
  bool? get visible;
  double? get minZoom;
  double? get maxZoom;
  dynamic get filter;
}
