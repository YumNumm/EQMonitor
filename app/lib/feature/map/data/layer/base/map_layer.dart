import 'package:maplibre_gl/maplibre_gl.dart';

abstract class MapLayer {
  const MapLayer();

  Map<String, dynamic> toGeoJsonSource();
  String get geoJsonSourceHash;
  LayerProperties toLayerProperties();
  String get layerPropertiesHash;

  String get id;
  String get sourceId;
  bool get visible;
  double? get minZoom;
  double? get maxZoom;
}

class CachedIMapLayer {
  const CachedIMapLayer({
    required this.layer,
    required this.geoJsonSourceHash,
    required this.layerPropertiesHash,
  });

  factory CachedIMapLayer.fromLayer(MapLayer layer) => CachedIMapLayer(
        layer: layer,
        geoJsonSourceHash: layer.geoJsonSourceHash,
        layerPropertiesHash: layer.layerPropertiesHash,
      );

  final MapLayer layer;
  final String geoJsonSourceHash;
  final String layerPropertiesHash;

  CachedIMapLayer copyWith({
    MapLayer? layer,
    String? geoJsonSourceHash,
    String? layerPropertiesHash,
  }) =>
      CachedIMapLayer(
        layer: layer ?? this.layer,
        geoJsonSourceHash: geoJsonSourceHash ?? this.geoJsonSourceHash,
        layerPropertiesHash: layerPropertiesHash ?? this.layerPropertiesHash,
      );
}
