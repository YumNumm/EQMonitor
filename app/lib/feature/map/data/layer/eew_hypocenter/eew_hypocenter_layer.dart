import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/ui/declarative_map.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

part 'eew_hypocenter_layer.freezed.dart';

@freezed
class EewHypocenter with _$EewHypocenter {
  const factory EewHypocenter({
    required double latitude,
    required double longitude,
  }) = _EewHypocenter;
}

@freezed
class EewHypocenterLayer extends MapLayer with _$EewHypocenterLayer {
  factory EewHypocenterLayer({
    required String id,
    required String sourceId,
    required bool visible,
    required List<EewHypocenter> hypocenters,
    required String iconImage,
    @Default(null) double? minZoom,
    @Default(null) double? maxZoom,
    dynamic filter,
  }) = _EewHypocenterLayer;

  const EewHypocenterLayer._();

  @override
  Map<String, dynamic> toGeoJsonSource() {
    return {
      'type': 'FeatureCollection',
      'features':
          hypocenters
              .map(
                (e) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [e.longitude, e.latitude],
                  },
                  'properties': {
                    'iconImage': iconImage,
                    'latitude': e.latitude,
                    'longitude': e.longitude,
                  },
                },
              )
              .toList(),
    };
  }

  @override
  String get geoJsonSourceHash =>
      hypocenters.map((e) => '${e.latitude},${e.longitude}').join(',');

  @override
  LayerProperties toLayerProperties() {
    return SymbolLayerProperties(
      iconOpacity: visible ? 1.0 : 0.5,
      iconImage: iconImage,
      iconAllowOverlap: true,
      iconSize: [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.3,
        20,
        2,
      ],
      textField: ['get', 'properties'],
    );
  }

  @override
  String get layerPropertiesHash =>
      'eew-hypocenter-${visible ? 'visible' : 'invisible'}';
}

enum EewHypocenterIcon {
  normal,
  lowPrecise;

  DeclarativeAssets get asset => switch (this) {
    normal => DeclarativeAssets.normalHypocenter,
    lowPrecise => DeclarativeAssets.lowPreciseHypocenter,
  };
}
