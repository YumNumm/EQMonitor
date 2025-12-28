import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class ReplayMapLayer extends HookConsumerWidget {
  const ReplayMapLayer({super.key});

  static const _sourceId = 'replay-observations';
  static const _layerId = 'replay-circles';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final replayState = ref.watch(replayProvider);
    final points = replayState?.currentPoints ?? [];

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(_initializeLayer(styleController));

        return () => unawaited(_cleanupLayer(styleController));
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(_updatePoints(styleController, points));

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
      const CircleStyleLayer(
        id: _layerId,
        sourceId: _sourceId,
        paint: {
          'circle-radius': [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            1,
            10,
            10,
          ],
          'circle-color': ['get', 'color'],
          'circle-stroke-color': '#808080',
          'circle-stroke-width': [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.2,
            10,
            1,
          ],
        },
      ),
    );
  }

  Future<void> _updatePoints(
    StyleController style,
    List<KyoshinMonitorImageParseObservationPoint> points,
  ) async {
    final features = points.map((p) {
      final observation = p.observation;
      final point = p.point;

      final colorHex =
          '#${observation.r.toRadixString(16).padLeft(2, '0')}${observation.g.toRadixString(16).padLeft(2, '0')}${observation.b.toRadixString(16).padLeft(2, '0')}'
              .toUpperCase();

      return {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [point.location.longitude, point.location.latitude],
        },
        'properties': {
          'color': colorHex,
          'intensity': observation.scaleToIntensity,
          'name': point.name,
        },
      };
    }).toList();

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
