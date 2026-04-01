import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/feature/home/data/provider/kyoshin_monitor_points_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class KyoshinMonitorObservationLayer extends HookConsumerWidget {
  const KyoshinMonitorObservationLayer({super.key});

  static const _sourceId = 'kyoshin-monitor-observations';
  static const _layerId = 'kyoshin-monitor-circles';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = MapController.of(context);
    final styleController = controller.style;
    final observationGeoJson = ref.watch(
      kyoshinMonitorObservationGeoJsonProvider,
    );
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select((v) => v.requireValue.useKmoni),
    );

    final eventProvider = MapLibreEventProvider.of(context);

    useEffect(
      () {
        if (styleController == null || !useKmoni) {
          return null;
        }

        unawaited(_initializeLayer(styleController));

        final stream = eventProvider.eventStream.listen((
          event,
        ) {
          // if (event is MapEventClick) {
          //   talker.debug('click: ${event.screenPoint}');
          //   final features = controller.queryLayers(event.screenPoint);
          //   talker.debug('features: $features');
          // }
        });

        return () {
          unawaited(_cleanupLayer(styleController));
          unawaited(stream.cancel());
        };
      },
      [styleController, useKmoni],
    );

    useEffect(
      () {
        if (styleController == null || !useKmoni) {
          return null;
        }

        unawaited(_updatePoints(styleController, observationGeoJson));

        return null;
      },
      [styleController, observationGeoJson, useKmoni],
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
    String geoJson,
  ) async {
    await style.updateGeoJsonSource(id: _sourceId, data: geoJson);
  }

  Future<void> _cleanupLayer(StyleController style) async {
    await style.removeLayer(_layerId);
    await style.removeSource(_sourceId);
  }
}
