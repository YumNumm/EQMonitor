import 'package:maplibre_gl/maplibre_gl.dart';

abstract class IMapLayer {
  const IMapLayer();

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

  factory CachedIMapLayer.fromLayer(IMapLayer layer) => CachedIMapLayer(
        layer: layer,
        geoJsonSourceHash: layer.geoJsonSourceHash,
        layerPropertiesHash: layer.layerPropertiesHash,
      );

  final IMapLayer layer;
  final String geoJsonSourceHash;
  final String layerPropertiesHash;
}
