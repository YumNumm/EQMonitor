import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_hypocenter_point.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震源マーカー
///
/// [points] の震源をすべて描き、番号を持つ震源にはマーカーの上へ番号を添える。
/// [displayMode] に応じて不透明度を制御する。
/// [HypocenterDisplayMode.belowStations] の z 順制御は呼び出し側で行う。
class EarthquakeHistoryHypocenterLayer extends HookConsumerWidget {
  const new({
    required this.points,
    this.displayMode = HypocenterDisplayMode.zoomFade,
    this.parameter = const EarthquakeHistoryMapLayerParameter(),
    this.belowLayerId,
    super.key,
  });

  final List<EarthquakeHistoryHypocenterPoint> points;
  final HypocenterDisplayMode displayMode;
  final EarthquakeHistoryMapLayerParameter parameter;

  final String? belowLayerId;

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
      points: points,
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
            () => MapStyleResourceRemover.remove(
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
            belowLayerId: belowLayerId,
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, belowLayerId, parameter, displayMode]);

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

class const EarthquakeHistoryHypocenterGeoJsonBuilder() {
  String build({required List<EarthquakeHistoryHypocenterPoint> points}) =>
      jsonEncode({
        'type': 'FeatureCollection',
        'features': <Map<String, dynamic>>[
          for (final point in points)
            {
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [point.longitude, point.latitude],
              },
              'properties': <String, dynamic>{
                EarthquakeHistoryHypocenterLayerBuilder.indexLabelProperty:
                    point.index?.toString() ?? '',
              },
            },
        ],
      });
}

class const EarthquakeHistoryHypocenterLayerBuilder() {
  static const sourceId = 'earthquake-history-hypocenter';
  static const layerId = 'earthquake-history-hypocenter-symbol';
  static const iconId = 'earthquake-history-hypocenter-icon';
  static const indexLabelProperty = 'indexLabel';

  /// 番号の文字サイズを決める、アイコン倍率に対する比。
  ///
  /// アイコンと同じ zoom の区切りで補間し、どの倍率でも番号がマーカーの
  /// すぐ上に収まるようにする。
  static const _indexTextSizePerIconSize = 70.0;

  SymbolStyleLayer buildSymbolLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
    required HypocenterDisplayMode displayMode,
  }) {
    final opacity = switch (displayMode) {
      .zoomFade => [
        'step',
        ['zoom'],
        1.0,
        parameter.hypocenterFadeZoom,
        parameter.hypocenterFadeOpacity,
      ],
      .alwaysOpaque || .belowStations => 1.0,
    };
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
        'text-field': ['get', indexLabelProperty],
        // 地図 style の glyph 配信元は既定の fontstack を返さないため明示する。
        'text-font': ['Noto Sans CJK JP Bold'],
        'text-size': [
          'interpolate',
          ['linear'],
          ['zoom'],
          3,
          parameter.hypocenterIconSizeMin * _indexTextSizePerIconSize,
          20,
          parameter.hypocenterIconSizeMax * _indexTextSizePerIconSize,
        ],
        'text-anchor': 'bottom',
        'text-offset': [0, -1.65],
        // 近接した震源でも番号が衝突判定で消えないようにする。
        'text-allow-overlap': true,
        'text-ignore-placement': true,
      },
      paint: {
        'icon-opacity': opacity,
        'text-opacity': opacity,
        'text-color': '#ffffff',
        'text-halo-color': '#000000',
        'text-halo-width': 1.5,
      },
    );
  }
}
