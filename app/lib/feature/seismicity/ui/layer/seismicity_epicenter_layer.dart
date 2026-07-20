import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 震央分布図(MapLibre circle レイヤー、data-driven styling)。
///
/// [colorMode] に応じて `circle-color` の式を切り替える。円サイズは常に
/// マグニチュードへ連動する(`circle-radius`)。
class SeismicityEpicenterLayer extends HookConsumerWidget {
  const SeismicityEpicenterLayer({
    required this.events,
    required this.colorMode,
    super.key,
  });

  final List<SeismicityEvent> events;
  final SeismicityColorMode colorMode;

  static const sourceId = 'seismicity-epicenter';
  static const layerId = 'seismicity-epicenter-circle';
  static const _emptyGeoJson = '{"type":"FeatureCollection","features":[]}';

  /// 経過時間色分け時の再計算間隔。色スケールは日〜月単位のため十分な粒度。
  static const _elapsedTimeRefreshInterval = Duration(minutes: 10);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final tick = useState(0);
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final isLayerInitialized = useRef(false);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final geoJson = const SeismicityEpicenterGeoJsonBuilder().build(
      events: events,
      now: DateTime.now().toUtc(),
    );

    useEffect(() {
      if (colorMode != SeismicityColorMode.elapsedTime) {
        return null;
      }
      final timer = Timer.periodic(_elapsedTimeRefreshInterval, (_) {
        tick.value++;
      });
      return timer.cancel;
    }, [colorMode]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      isLayerInitialized.value = false;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(id: sourceId, data: _emptyGeoJson),
        );
      });

      return () {
        if (lifecycleToken.value == token) {
          lifecycleToken.value = null;
        }
        geoJsonUpdater.reset();
        unawaited(
          enqueue(
            () => removeMapStyleResources(
              styleController: styleController,
              layerIds: const [layerId],
              sourceIds: const [sourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      final initialized = initialization.value;
      if (styleController == null || token == null || initialized == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await initialized;
          if (lifecycleToken.value != token) {
            return;
          }
          if (isLayerInitialized.value) {
            await styleController.removeLayer(layerId);
          }
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            const SeismicityEpicenterStyleBuilder().build(colorMode: colorMode),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, colorMode]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: sourceId,
            geoJson: geoJson,
            initialization: initialization.value,
            isDisposed: () => lifecycleToken.value != token,
          ),
        ),
      );
      return null;
    }, [styleController, geoJson]);

    return const SizedBox.shrink();
  }

  static double elapsedHours({
    required DateTime originTime,
    required DateTime now,
  }) => SeismicityEpicenterGeoJsonBuilder.elapsedHours(
    originTime: originTime,
    now: now,
  );
}

class SeismicityEpicenterGeoJsonBuilder {
  const SeismicityEpicenterGeoJsonBuilder();

  String build({
    required List<SeismicityEvent> events,
    required DateTime now,
  }) => jsonEncode({
    'type': 'FeatureCollection',
    'features': [
      for (final event in events)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [event.longitude, event.latitude],
          },
          'properties': {
            'event_id': event.eventId,
            'magnitude': event.magnitude ?? 0.0,
            'elapsed_hours': SeismicityEpicenterGeoJsonBuilder.elapsedHours(
              originTime: event.originTime,
              now: now,
            ),
          },
        },
    ],
  });

  static double elapsedHours({
    required DateTime originTime,
    required DateTime now,
  }) => now.toUtc().difference(originTime.toUtc()).inHours.toDouble();
}

class SeismicityEpicenterStyleBuilder {
  const SeismicityEpicenterStyleBuilder();

  CircleStyleLayer build({required SeismicityColorMode colorMode}) =>
      CircleStyleLayer(
        id: SeismicityEpicenterLayer.layerId,
        sourceId: SeismicityEpicenterLayer.sourceId,
        paint: {
          'circle-color': switch (colorMode) {
            SeismicityColorMode.magnitude => [
              'interpolate',
              ['linear'],
              ['get', 'magnitude'],
              2,
              '#9e9e9e',
              4,
              '#ffca28',
              6,
              '#e53935',
            ],
            SeismicityColorMode.elapsedTime => [
              'interpolate',
              ['linear'],
              ['get', 'elapsed_hours'],
              0,
              '#e53935',
              24 * 30,
              '#9e9e9e',
            ],
          },
          'circle-radius': [
            'interpolate',
            ['linear'],
            ['get', 'magnitude'],
            2,
            3,
            7,
            18,
          ],
          'circle-opacity': 0.75,
          'circle-stroke-width': 0.5,
          'circle-stroke-color': '#00000080',
        },
      );
}
