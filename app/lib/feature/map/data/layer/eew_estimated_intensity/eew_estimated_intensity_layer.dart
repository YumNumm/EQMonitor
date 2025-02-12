import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

part 'eew_estimated_intensity_layer.freezed.dart';

@freezed
class EewEstimatedIntensityLayer extends MapLayer
    with _$EewEstimatedIntensityLayer {
  const factory EewEstimatedIntensityLayer({
    required String id,
    required Color color,
    required dynamic filter,
    @Default(true) bool visible,
    @Default('areaForecastLocalE') String sourceId,
    @Default(null) double? minZoom,
    @Default(null) double? maxZoom,
  }) = _EewEstimatedIntensityLayer;

  const EewEstimatedIntensityLayer._();

  factory EewEstimatedIntensityLayer.fromJmaForecastIntensity({
    required JmaForecastIntensity intensity,
    required Color color,
    required List<String> regionCodes,
  }) =>
      EewEstimatedIntensityLayer(
        id: 'eew_estimated_intensity_layer_${intensity.name}',
        color: color,
        sourceId: BaseLayer.areaForecastLocalEFill.name,
        filter: [
          'in',
          ['get', 'code'],
          'literal',
          regionCodes,
        ],
      );

  @override
  Map<String, dynamic>? toGeoJsonSource() => null;

  @override
  LayerProperties toLayerProperties() => FillLayerProperties(
        fillColor: color.toHexStringRGB(),
      );

  @override
  String get geoJsonSourceHash => '';

  @override
  String get layerPropertiesHash => '${color.hex}';
}
