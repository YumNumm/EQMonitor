import 'package:maplibre_gl/maplibre_gl.dart';

abstract class IMapLayer {
  const IMapLayer({
    required this.id,
    required this.sourceId,
    required this.visible,
    this.minZoom,
    this.maxZoom,
  });

  Map<String, dynamic> toGeoJsonSource();
  String get geoJsonSourceHash;
  LayerProperties toLayerProperties();
  String get layerPropertiesHash;

  final String id;
  final String sourceId;
  final bool visible;
  final double? minZoom;
  final double? maxZoom;
}

class CachedIMapLayer {
  const CachedIMapLayer({
    required this.layer,
    required this.geoJsonSourceHash,
    required this.layerPropertiesHash,
  });

  factory CachedIMapLayer.fromLayer(IMapLayer layer) => CachedIMapLayer(
        layer: layer,
        geoJsonSourceHash: layer.geoJsonSourceHash,
        layerPropertiesHash: layer.layerPropertiesHash,
      );

  final IMapLayer layer;
  final String geoJsonSourceHash;
  final String layerPropertiesHash;
}
