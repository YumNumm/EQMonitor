import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

/// 電文発表時刻基準での静的PS波到達円レイヤー
class EewStaticPsWaveLayer extends HookConsumerWidget {
  const EewStaticPsWaveLayer({required this.eew, super.key});

  final EewTelegramItem? eew;

  static const _pWaveSourceId = 'eew-static-p-wave';
  static const _sWaveSourceId = 'eew-static-s-wave';
  static const _pWaveLayerId = 'eew-static-p-wave-line';
  static const _sWaveLayerId = 'eew-static-s-wave-line';
  static const _sWaveFillLayerId = 'eew-static-s-wave-fill';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final travelTimeMap = ref.watch(travelTimeDepthMapProvider);
    final isInitialized = useRef(false);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await _initializeLayers(styleController);
          isInitialized.value = true;
          await _updateLayers(styleController, eew, travelTimeMap);
        }());

        return () async {
          isInitialized.value = false;
          await _removeLayers(styleController);
        };
      },
      [styleController, eew, travelTimeMap],
    );

    useEffect(
      () {
        if (styleController == null || !isInitialized.value) {
          return null;
        }

        unawaited(_updateLayers(styleController, eew, travelTimeMap));

        return null;
      },
      [styleController, eew, travelTimeMap],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayers(StyleController styleController) async {
    await (
      styleController.addSource(
        GeoJsonSource(
          id: _pWaveSourceId,
          data: jsonEncode({
            'type': 'FeatureCollection',
            'features': <Map<String, dynamic>>[],
          }),
        ),
      ),
      styleController.addSource(
        GeoJsonSource(
          id: _sWaveSourceId,
          data: jsonEncode({
            'type': 'FeatureCollection',
            'features': <Map<String, dynamic>>[],
          }),
        ),
      ),
    ).wait;

    await (
      styleController.addLayer(
        const LineStyleLayer(
          id: _pWaveLayerId,
          sourceId: _pWaveSourceId,
          paint: {
            'line-color': '#0000FF',
            'line-width': 1,
          },
        ),
      ),
      styleController.addLayer(
        const LineStyleLayer(
          id: _sWaveLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'line-color': ['get', 'lineColor'],
            'line-width': 2,
          },
        ),
      ),
      styleController.addLayer(
        const FillStyleLayer(
          id: _sWaveFillLayerId,
          sourceId: _sWaveSourceId,
          paint: {
            'fill-color': ['get', 'fillColor'],
            'fill-opacity': 0.2,
          },
        ),
      ),
    ).wait;
  }

  Future<void> _removeLayers(StyleController styleController) async {
    await styleController.removeLayer(_pWaveLayerId);
    await styleController.removeLayer(_sWaveLayerId);
    await styleController.removeLayer(_sWaveFillLayerId);
    await styleController.removeSource(_pWaveSourceId);
    await styleController.removeSource(_sWaveSourceId);
  }

  Future<void> _updateLayers(
    StyleController styleController,
    EewTelegramItem? eew,
    TravelTimeDepthMap travelTimeMap,
  ) async {
    if (eew == null) {
      await _clearLayers(styleController);
      return;
    }

    final hypocenter = eew.hypocenter;
    if (hypocenter == null || !hypocenter.hasLatLng) {
      await _clearLayers(styleController);
      return;
    }

    final depth = hypocenter.depth;
    final originTime = eew.originTime;

    if (depth == null || originTime == null || eew.isPlum) {
      await _clearLayers(styleController);
      return;
    }

    final elapsed = eew.reportTime.difference(originTime).inMilliseconds / 1000;
    final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

    final lat = hypocenter.latitude!;
    final lng = hypocenter.longitude!;

    final isWarning = eew.isWarning ?? false;
    final lineColor = isWarning ? '#FF0000' : '#FFA500';
    final fillColor = isWarning ? '#FF0000' : '#FFA500';

    final pWaveFeatures = <Map<String, dynamic>>[];
    final sWaveFeatures = <Map<String, dynamic>>[];

    if (travelTime.pDistance != null && travelTime.pDistance! > 0) {
      pWaveFeatures.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            _generateCircleCoordinates(lat, lng, travelTime.pDistance!),
          ],
        },
        'properties': <String, dynamic>{},
      });
    }

    if (travelTime.sDistance != null && travelTime.sDistance! > 0) {
      sWaveFeatures.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Polygon',
          'coordinates': [
            _generateCircleCoordinates(lat, lng, travelTime.sDistance!),
          ],
        },
        'properties': {
          'lineColor': lineColor,
          'fillColor': fillColor,
        },
      });
    }

    await (
      styleController.updateGeoJsonSource(
        id: _pWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': pWaveFeatures,
        }),
      ),
      styleController.updateGeoJsonSource(
        id: _sWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': sWaveFeatures,
        }),
      ),
    ).wait;
  }

  Future<void> _clearLayers(StyleController styleController) async {
    await (
      styleController.updateGeoJsonSource(
        id: _pWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
      styleController.updateGeoJsonSource(
        id: _sWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    ).wait;
  }

  List<List<double>> _generateCircleCoordinates(
    double lat,
    double lng,
    double radiusKm,
  ) {
    const distance = latlong2.Distance();
    final center = latlong2.LatLng(lat, lng);
    final coordinates = <List<double>>[];

    for (var bearing = 0; bearing < 360; bearing += 4) {
      final point = distance.offset(center, radiusKm * 1000, bearing);
      coordinates.add([point.longitude, point.latitude]);
    }

    coordinates.add(coordinates.first);

    return coordinates;
  }
}
