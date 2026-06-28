import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
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

  static const _sourceId = 'earthquake-history-estimated-intensity';
  static const _fillLayerId = 'earthquake-history-estimated-intensity-fill';
  static const _lineLayerId = 'earthquake-history-estimated-intensity-line';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    if (styleController == null) {
      return const SizedBox.shrink();
    }

    final enqueue = useMapOperationQueue();

    useEffect(
      () {
        var disposed = false;

        unawaited(
          enqueue(() async {
            await styleController.addSource(
              VectorSource(
                id: _sourceId,
                url: 'pmtiles://$tileUrl',
                volatile: true,
              ),
            );

            if (disposed) {
              return;
            }

            await styleController.addLayer(
              const FillStyleLayer(
                id: _fillLayerId,
                sourceId: _sourceId,
                sourceLayerId: 'seismic_intensity',
                paint: {
                  'fill-opacity': 1,
                  'fill-color': ['get', 'fill'],
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );

            if (disposed) {
              return;
            }

            await styleController.addLayer(
              const LineStyleLayer(
                id: _lineLayerId,
                sourceId: _sourceId,
                sourceLayerId: 'seismic_intensity',
                paint: {
                  'line-opacity': 1,
                  'line-color': ['get', 'fill'],
                  'line-width': 0.5,
                },
              ),
              belowLayerId: BaseLayer.areaForecastLocalELine.name,
            );
          }),
        );

        return () {
          disposed = true;
          unawaited(
            enqueue(() async {
              try {
                await styleController.removeLayer(_lineLayerId);
              } on Exception catch (_) {}
              try {
                await styleController.removeLayer(_fillLayerId);
              } on Exception catch (_) {}
              try {
                await styleController.removeSource(_sourceId);
              } on Exception catch (_) {}
            }),
          );
        };
      },
      [styleController, tileUrl],
    );

    return const SizedBox.shrink();
  }
}
