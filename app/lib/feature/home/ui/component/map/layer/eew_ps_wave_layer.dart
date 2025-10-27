import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'package:maplibre/maplibre.dart';

class EewPsWaveLayer extends HookConsumerWidget {
  const EewPsWaveLayer({super.key});

  static const _pWaveSourceId = 'eew-p-wave';
  static const _sWaveSourceId = 'eew-s-wave';
  static const _pWaveLineLayerId = 'eew-p-wave-line';
  static const _sWaveLineLayerId = 'eew-s-wave-line';
  static const _sWaveFillLayerId = 'eew-s-wave-fill';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        _initializeLayer(styleController);

        return () => _cleanupLayer(styleController);
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        final timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (_) => _updateWaves(ref, styleController),
        );

        return timer.cancel;
      },
      [styleController],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayer(StyleController style) async {
    await style.addSource(
      GeoJsonSource(
        id: _pWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    );

    await style.addSource(
      GeoJsonSource(
        id: _sWaveSourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    );

    await style.addLayer(
      const LineStyleLayer(
        id: _pWaveLineLayerId,
        sourceId: _pWaveSourceId,
        paint: {
          'line-color': '#0000FF',
          'line-width': 1,
        },
      ),
    );

    await style.addLayer(
      const LineStyleLayer(
        id: _sWaveLineLayerId,
        sourceId: _sWaveSourceId,
        paint: {
          'line-color': ['get', 'lineColor'],
          'line-width': 2,
        },
      ),
    );

    await style.addLayer(
      const FillStyleLayer(
        id: _sWaveFillLayerId,
        sourceId: _sWaveSourceId,
        paint: {
          'fill-color': ['get', 'fillColor'],
          'fill-opacity': 0.2,
        },
      ),
    );
  }

  Future<void> _updateWaves(
    WidgetRef ref,
    StyleController style,
  ) async {
    final eews = ref.read(eewAliveNormalTelegramProvider);
    final now = ref.read(timeTickerProvider()).value ?? DateTime.now();
    final travelTimeMap = ref.read(travelTimeDepthMapProvider);

    final (pWaveGeojson, sWaveGeojson) =
        _calculateGeoJson(eews, now, travelTimeMap);

    await style.updateGeoJsonSource(id: _pWaveSourceId, data: pWaveGeojson);
    await style.updateGeoJsonSource(id: _sWaveSourceId, data: sWaveGeojson);
  }

  (String, String) _calculateGeoJson(
    List eews,
    DateTime now,
    TravelTimeDepthMap travelTimeMap,
  ) {
    final pWaveFeatures = <Map<String, dynamic>>[];
    final sWaveFeatures = <Map<String, dynamic>>[];

    for (final eew in eews) {
      final lat = eew.latitude as double?;
      final lng = eew.longitude as double?;
      final depth = eew.depth as int?;
      final originTime = eew.originTime as DateTime?;

      if (lat == null || lng == null || depth == null || originTime == null) {
        continue;
      }

      final elapsed = now.difference(originTime).inMilliseconds / 1000;
      final travelTime = travelTimeMap.getTravelTime(depth, elapsed);

      final isWarning =
          (eew.isWarning as bool?) ??
          ((eew.headline as String?)?.contains('強い揺れ') ?? false);
      final lineColor = isWarning ? '#FF0000' : '#FFA500';
      final fillColor = isWarning ? '#FF0000' : '#FFA500';

      if (travelTime.pDistance != null && travelTime.pDistance! > 0) {
        pWaveFeatures.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              _generateCircleCoordinates(
                lat,
                lng,
                travelTime.pDistance!,
              ),
            ],
          },
          'properties': {},
        });
      }

      if (travelTime.sDistance != null && travelTime.sDistance! > 0) {
        sWaveFeatures.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Polygon',
            'coordinates': [
              _generateCircleCoordinates(
                lat,
                lng,
                travelTime.sDistance!,
              ),
            ],
          },
          'properties': {
            'lineColor': lineColor,
            'fillColor': fillColor,
          },
        });
      }
    }

    final pWaveGeojson = jsonEncode({
      'type': 'FeatureCollection',
      'features': pWaveFeatures,
    });

    final sWaveGeojson = jsonEncode({
      'type': 'FeatureCollection',
      'features': sWaveFeatures,
    });

    return (pWaveGeojson, sWaveGeojson);
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

  Future<void> _cleanupLayer(StyleController style) async {
    await style.removeLayer(_pWaveLineLayerId);
    await style.removeLayer(_sWaveLineLayerId);
    await style.removeLayer(_sWaveFillLayerId);
    await style.removeSource(_pWaveSourceId);
    await style.removeSource(_sWaveSourceId);
  }
}

