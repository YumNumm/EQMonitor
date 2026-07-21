import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/hypocenter_error_range_util.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震源誤差矩形レイヤー
///
/// 震源座標の精度から誤差範囲を計算し、白い点線の矩形で表示する。
class EarthquakeHistoryHypocenterErrorLayer extends HookConsumerWidget {
  const EarthquakeHistoryHypocenterErrorLayer({
    required this.earthquake,
    this.parameter = const EarthquakeHistoryMapLayerParameter(),
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryMapLayerParameter parameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final enqueue = useMapOperationQueue();
    final layerBuilder = useMemoized(
      EarthquakeHistoryHypocenterErrorLayerBuilder.new,
    );

    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final isLayerInitialized = useRef(false);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final geoJson = const EarthquakeHistoryHypocenterErrorGeoJsonBuilder()
        .build(
          coordinates: earthquake.hypocenter?.coordinates,
          decimalPlaces:
              earthquake.telegramTypes.contains(EarthquakeTelegramType.vxse61)
              ? 3
              : 1,
        );

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
          const GeoJsonSource(
            id: EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId,
            data: '{"type":"FeatureCollection","features":[]}',
          ),
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
              layerIds: const [
                EarthquakeHistoryHypocenterErrorLayerBuilder.layerId,
              ],
              sourceIds: const [
                EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId,
              ],
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
            await styleController.removeLayer(
              EarthquakeHistoryHypocenterErrorLayerBuilder.layerId,
            );
          }
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            layerBuilder.buildLineLayer(parameter: parameter, isDark: isDark),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, parameter, isDark]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId,
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
}

class EarthquakeHistoryHypocenterErrorGeoJsonBuilder {
  const EarthquakeHistoryHypocenterErrorGeoJsonBuilder();

  String build({required Coordinate? coordinates, required int decimalPlaces}) {
    final polygon = switch (coordinates) {
      CoordinateLatLng() => hypocenterErrorPolygon(
        lat: coordinates.latitude,
        lon: coordinates.longitude,
        decimalPlaces: decimalPlaces,
      ),
      _ => null,
    };
    return jsonEncode({
      'type': 'FeatureCollection',
      'features': <Map<String, dynamic>>[
        if (polygon != null)
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Polygon',
              'coordinates': [polygon],
            },
            'properties': <String, dynamic>{},
          },
      ],
    });
  }
}

class EarthquakeHistoryHypocenterErrorLayerBuilder {
  const EarthquakeHistoryHypocenterErrorLayerBuilder();

  static const sourceId = 'eq-history-hypocenter-error';
  static const layerId = 'eq-history-hypocenter-error-line';

  LineStyleLayer buildLineLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
    required bool isDark,
  }) {
    return LineStyleLayer(
      id: layerId,
      sourceId: sourceId,
      paint: {
        'line-color': isDark ? '#ffffff' : '#000000',
        'line-cap': 'round',
        'line-join': 'round',
        'line-width': 1.5,
        'line-blur': 0.2,
        'line-dasharray': [4, 2],
        'line-opacity': [
          'step',
          ['zoom'],
          0.0,
          parameter.hypocenterErrorMinZoom,
          1.0,
        ],
      },
    );
  }
}
