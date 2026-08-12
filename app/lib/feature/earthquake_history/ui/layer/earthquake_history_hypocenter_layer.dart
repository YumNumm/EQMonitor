import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震源マーカー
///
/// [displayMode] に応じて不透明度を制御する。
/// [HypocenterDisplayMode.belowStations] の z 順制御は呼び出し側で行う。
class EarthquakeHistoryHypocenterLayer extends HookConsumerWidget {
  const EarthquakeHistoryHypocenterLayer({
    required this.earthquake,
    this.displayMode = HypocenterDisplayMode.zoomFade,
    this.parameter = const EarthquakeHistoryMapLayerParameter(),
    super.key,
  });

  final Earthquake earthquake;
  final HypocenterDisplayMode displayMode;
  final EarthquakeHistoryMapLayerParameter parameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final layerBuilder = useMemoized(
      EarthquakeHistoryHypocenterLayerBuilder.new,
    );
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final isLayerInitialized = useRef(false);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final geoJson = const EarthquakeHistoryHypocenterGeoJsonBuilder().build(
      coordinates: earthquake.hypocenter?.coordinates,
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
        await styleController.addImageFromAssets(
          id: EarthquakeHistoryHypocenterLayerBuilder.iconId,
          asset: Assets.images.map.normalHypocenter.path,
        );
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: EarthquakeHistoryHypocenterLayerBuilder.sourceId,
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
              layerIds: const [EarthquakeHistoryHypocenterLayerBuilder.layerId],
              sourceIds: const [
                EarthquakeHistoryHypocenterLayerBuilder.sourceId,
              ],
              imageIds: const [EarthquakeHistoryHypocenterLayerBuilder.iconId],
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
              EarthquakeHistoryHypocenterLayerBuilder.layerId,
            );
          }
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            layerBuilder.buildSymbolLayer(
              parameter: parameter,
              displayMode: displayMode,
            ),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, parameter, displayMode]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: EarthquakeHistoryHypocenterLayerBuilder.sourceId,
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

class EarthquakeHistoryHypocenterGeoJsonBuilder {
  const EarthquakeHistoryHypocenterGeoJsonBuilder();

  String build({required Coordinate? coordinates}) => jsonEncode({
    'type': 'FeatureCollection',
    'features': <Map<String, dynamic>>[
      if (coordinates is CoordinateLatLng)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [coordinates.longitude, coordinates.latitude],
          },
          'properties': <String, dynamic>{},
        },
    ],
  });
}

class EarthquakeHistoryHypocenterLayerBuilder {
  const EarthquakeHistoryHypocenterLayerBuilder();

  static const sourceId = 'earthquake-history-hypocenter';
  static const layerId = 'earthquake-history-hypocenter-symbol';
  static const iconId = 'earthquake-history-hypocenter-icon';

  SymbolStyleLayer buildSymbolLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
    required HypocenterDisplayMode displayMode,
  }) {
    return SymbolStyleLayer(
      id: layerId,
      sourceId: sourceId,
      layout: {
        'icon-allow-overlap': true,
        'icon-ignore-placement': true,
        'icon-image': iconId,
        'icon-size': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          parameter.hypocenterIconSizeMin,
          20,
          parameter.hypocenterIconSizeMax,
        ],
      },
      paint: {
        'icon-opacity': switch (displayMode) {
          .zoomFade => [
            'step',
            ['zoom'],
            1.0,
            parameter.hypocenterFadeZoom,
            parameter.hypocenterFadeOpacity,
          ],
          .alwaysOpaque || .belowStations => 1.0,
        },
      },
    );
  }
}
