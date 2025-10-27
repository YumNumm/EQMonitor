import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/home/data/provider/eew_hypocenter_points_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewHypocenterLayer extends HookConsumerWidget {
  const EewHypocenterLayer({super.key});

  static const _sourceId = 'eew-hypocenter';
  static const _layerId = 'eew-hypocenter-circles';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final points = ref.watch(eewHypocenterPointsProvider);

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

        _updatePoints(styleController, points);

        return null;
      },
      [styleController, points],
    );

    return const SizedBox.shrink();
  }

  Future<void> _initializeLayer(StyleController style) async {
    await style.addSource(
      GeoJsonSource(
        id: _sourceId,
        data: jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        }),
      ),
    );

    await style.addLayer(
      CircleStyleLayer(
        id: _layerId,
        sourceId: _sourceId,
        paint: {
          'circle-radius': 10,
          'circle-color': '#FF0000',
          'circle-stroke-color': '#FFFFFF',
          'circle-stroke-width': 2,
        },
      ),
    );
  }

  Future<void> _updatePoints(
    StyleController style,
    List<Feature<Point>> points,
  ) async {
    final features = points.map((p) {
      final coords = p.geometry?.position;
      if (coords == null) {
        return null;
      }
      return {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [coords.x, coords.y],
        },
        'properties': p.properties,
      };
    }).whereType<Map<String, dynamic>>().toList();

    final geojson = jsonEncode({
      'type': 'FeatureCollection',
      'features': features,
    });

    await style.updateGeoJsonSource(id: _sourceId, data: geojson);
  }

  Future<void> _cleanupLayer(StyleController style) async {
    await style.removeLayer(_layerId);
    await style.removeSource(_sourceId);
  }
}



