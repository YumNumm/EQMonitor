import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

part 'map_layer.freezed.dart';

abstract class MapLayer {
  const MapLayer();

  Map<String, dynamic> toGeoJsonSource();
  String get geoJsonSourceHash;
  LayerProperties toLayerProperties();
  String get layerPropertiesHash;

  String get id;
  String get sourceId;
  bool? get visible;
  double? get minZoom;
  double? get maxZoom;
  dynamic get filter;
}

@freezed
class CachedMapLayer with _$CachedMapLayer {
  const factory CachedMapLayer({
    required MapLayer layer,
    required String geoJsonSourceHash,
    required String layerPropertiesHash,
    required String? belowLayerId,
  }) = _CachedMapLayer;

  const CachedMapLayer._();

  factory CachedMapLayer.fromLayer({
    required MapLayer layer,
    String? belowLayerId,
  }) =>
      CachedMapLayer(
        layer: layer,
        geoJsonSourceHash: layer.geoJsonSourceHash,
        layerPropertiesHash: layer.layerPropertiesHash,
        belowLayerId: belowLayerId,
      );
}
