import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/util/map/replace_map_style_layers.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の推計震度（PMTiles ラスタ）レイヤー
class EarthquakeHistoryDetailsEstimatedIntensityLayer
    extends HookConsumerWidget {
  const EarthquakeHistoryDetailsEstimatedIntensityLayer({
    required this.tileUrl,
    super.key,
  });

  final String tileUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    const style = EarthquakeHistoryEstimatedIntensityStyle();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      var disposed = false;

      unawaited(
        enqueue(
          () => style.replace(
            styleController: styleController,
            tileUrl: tileUrl,
            isDisposed: () => disposed,
          ),
        ),
      );

      return () {
        disposed = true;
        unawaited(
          enqueue(() => style.remove(styleController: styleController)),
        );
      };
    }, [styleController, tileUrl]);

    return const SizedBox.shrink();
  }
}

class EarthquakeHistoryEstimatedIntensityStyle {
  const EarthquakeHistoryEstimatedIntensityStyle();

  static const sourceId = 'earthquake-history-estimated-intensity';
  static const fillLayerId = 'earthquake-history-estimated-intensity-fill';
  static const lineLayerId = 'earthquake-history-estimated-intensity-line';

  Future<void> replace({
    required StyleController styleController,
    required String tileUrl,
    required bool Function() isDisposed,
  }) async {
    await remove(styleController: styleController);
    if (isDisposed()) {
      return;
    }
    await styleController.addSource(
      VectorSource(id: sourceId, url: 'pmtiles://$tileUrl', volatile: true),
    );
    if (isDisposed()) {
      return;
    }
    await replaceMapStyleLayers(
      styleController: styleController,
      layerIds: const [lineLayerId, fillLayerId],
      layers: [
        (
          layer: const FillStyleLayer(
            id: fillLayerId,
            sourceId: sourceId,
            sourceLayerId: 'seismic_intensity',
            paint: {
              'fill-opacity': 1,
              'fill-color': ['get', 'fill'],
            },
          ),
          belowLayerId: BaseLayer.areaForecastLocalELine.name,
          aboveLayerId: null,
          atIndex: null,
        ),
        (
          layer: const LineStyleLayer(
            id: lineLayerId,
            sourceId: sourceId,
            sourceLayerId: 'seismic_intensity',
            paint: {
              'line-opacity': 1,
              'line-color': ['get', 'fill'],
              'line-width': 0.5,
            },
          ),
          belowLayerId: BaseLayer.areaForecastLocalELine.name,
          aboveLayerId: null,
          atIndex: null,
        ),
      ],
    );
  }

  Future<void> remove({required StyleController styleController}) =>
      removeMapStyleResources(
        styleController: styleController,
        layerIds: const [lineLayerId, fillLayerId],
        sourceIds: const [sourceId],
      );
}
