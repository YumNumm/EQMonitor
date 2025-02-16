import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/map/data/layer/base/map_layer.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart' as lat_long;
import 'package:maplibre_gl/maplibre_gl.dart';

part 'eew_ps_wave_layer.freezed.dart';

@freezed
class EewPsWaveSourceLayer extends MapLayer
    with _$EewPsWaveSourceLayer {
  const factory EewPsWaveSourceLayer({
    required String id,
    required List<EewPsWaveLayerItem> items,
    @Default(true) bool visible,
    @Default('eew_ps_wave_source') String sourceId,
    @Default(null) double? minZoom,
    @Default(null) double? maxZoom,
    dynamic filter,
  }) = _EewPsWaveSourceLayer;

  const EewPsWaveSourceLayer._();

  @override
  Map<String, dynamic> toGeoJsonSource() {
    final json = {
      'type': 'FeatureCollection',
      'features':
          items
              .map((e) => e.toGeoJsonFeatures())
              .flattened
              .toList(),
    };
    return json;
  }

  @override
  LayerProperties? toLayerProperties() => null;

  @override
  String get geoJsonSourceHash => items.hashCode.toString();

  @override
  String get layerPropertiesHash => '';
}

@freezed
class EewPsWaveLayerItem with _$EewPsWaveLayerItem {
  const factory EewPsWaveLayerItem({
    required double latitude,
    required double longitude,
    required TravelTimeResult travelTime,
    required bool isWarning,
  }) = _EewPsWaveLayerItem;

  const EewPsWaveLayerItem._();

  List<Map<String, dynamic>> toGeoJsonFeatures() {
    final sTravel = this.travelTime.sDistance;
    final pTravel = this.travelTime.pDistance;
    const distance = lat_long.Distance();

    return [
      if (sTravel != null)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              [
                for (final bearing in List<int>.generate(
                  91,
                  (index) => index * 4,
                ))
                  () {
                    final latLng = distance.offset(
                      lat_long.LatLng(latitude, longitude),
                      sTravel * 1000,
                      bearing,
                    );
                    return [
                      latLng.longitude,
                      latLng.latitude,
                    ];
                  }(),
              ],
            ],
          },
          'properties': {
            'type': 's',
            'is_warning': isWarning,
          },
        },
      if (pTravel != null)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              [
                for (final bearing in List<int>.generate(
                  91,
                  (index) => index * 4,
                ))
                  () {
                    final latLng = distance.offset(
                      lat_long.LatLng(latitude, longitude),
                      pTravel * 1000,
                      bearing,
                    );
                    return [
                      latLng.longitude,
                      latLng.latitude,
                    ];
                  }(),
              ],
            ],
          },
          'properties': {
            'type': 'p',
            'is_warning': isWarning,
          },
        },
    ];
  }
}

@freezed
class EewWaveFillLayer extends MapLayer
    with _$EewWaveFillLayer {
  const factory EewWaveFillLayer({
    required String id,
    required Color color,
    required dynamic filter,
    @Default(true) bool visible,
    @Default('eew_ps_wave_source') String sourceId,
    @Default(null) double? minZoom,
    @Default(null) double? maxZoom,
  }) = _EewWaveFillLayer;

  const EewWaveFillLayer._();

  factory EewWaveFillLayer.pWave({required Color color}) =>
      EewWaveFillLayer(
        id: 'eew_wave_fill_p',
        color: color,
        filter: ['==', 'type', 'p'],
      );

  factory EewWaveFillLayer.sWaveWarning({
    required Color color,
  }) => EewWaveFillLayer(
    id: 'eew_wave_fill_s_warning',
    color: color,
    filter: [
      'all',
      ['==', 'type', 's'],
      ['==', 'is_warning', true],
    ],
  );

  factory EewWaveFillLayer.sWaveNotWarning({
    required Color color,
  }) => EewWaveFillLayer(
    id: 'eew_wave_fill_s_not_warning',
    color: color,
    filter: [
      'all',
      ['==', 'type', 's'],
      ['==', 'is_warning', false],
    ],
  );

  @override
  Map<String, dynamic>? toGeoJsonSource() => null;

  @override
  LayerProperties toLayerProperties() =>
      FillLayerProperties(
        fillColor: color.toHexStringRGB(),
      );

  @override
  String get geoJsonSourceHash => '';

  @override
  String get layerPropertiesHash => '${color.hex}';
}

@freezed
class EewWaveLineLayer extends MapLayer
    with _$EewWaveLineLayer {
  const factory EewWaveLineLayer({
    required String id,
    required Color color,
    required dynamic filter,
    @Default(true) bool visible,
    @Default('eew_ps_wave_source') String sourceId,
    @Default(null) double? minZoom,
    @Default(null) double? maxZoom,
  }) = _EewWaveLineLayer;

  const EewWaveLineLayer._();

  factory EewWaveLineLayer.pWave({required Color color}) =>
      EewWaveLineLayer(
        id: 'eew_wave_line_p',
        color: color,
        filter: ['==', 'type', 'p'],
      );

  factory EewWaveLineLayer.sWaveWarning({
    required Color color,
  }) => EewWaveLineLayer(
    id: 'eew_wave_line_s',
    color: color,
    filter: [
      'all',
      ['==', 'type', 's'],
      ['==', 'is_warning', true],
    ],
  );

  factory EewWaveLineLayer.sWaveNotWarning({
    required Color color,
  }) => EewWaveLineLayer(
    id: 'eew_wave_line_s_not_warning',
    color: color,
    filter: [
      'all',
      ['==', 'type', 's'],
      ['==', 'is_warning', false],
    ],
  );

  @override
  Map<String, dynamic>? toGeoJsonSource() => null;

  @override
  LayerProperties toLayerProperties() =>
      LineLayerProperties(
        lineColor: color.toHexStringRGB(),
        lineCap: 'round',
      );

  @override
  String get geoJsonSourceHash => '';

  @override
  String get layerPropertiesHash => '${color.hex}';
}
