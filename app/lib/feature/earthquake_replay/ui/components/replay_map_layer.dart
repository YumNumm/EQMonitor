import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
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
    final geoJson = ref.watch(
      replayProvider.select((s) => s?.kyoshinMonitorGeoJson),
    );

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

        unawaited(_updateGeoJson(styleController, geoJson));

        return null;
      },
      [styleController, geoJson],
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

  Future<void> _updateGeoJson(StyleController style, String? geoJson) async {
    final data = geoJson ??
        jsonEncode({
          'type': 'FeatureCollection',
          'features': <Map<String, dynamic>>[],
        });
    await style.updateGeoJsonSource(id: _sourceId, data: data);
  }

  Future<void> _cleanupLayer(StyleController style) async {
    await style.removeLayer(_layerId);
    await style.removeSource(_sourceId);
  }
}
