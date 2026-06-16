import 'dart:async';

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
  static const _layerId = 'earthquake-history-estimated-intensity-raster';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    if (styleController == null) {
      return const SizedBox.shrink();
    }

    useEffect(
      () {
        unawaited(() async {
          await styleController.addSource(
            VectorSource(
              id: _sourceId,
              url: 'pmtiles://$tileUrl',
              volatile: true,
            ),
          );

          await styleController.addLayer(
            const FillStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              sourceLayerId: 'seismic_intensity',
              paint: {
                'fill-opacity': 1,
                'fill-color': ['get', 'fill'],
              },
            ),
            belowLayerId: BaseLayer.areaForecastLocalELine.name,
          );
          await styleController.addLayer(
            const LineStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              sourceLayerId: 'seismic_intensity',
              paint: {
                'line-opacity': 1,
                'line-color': ['get', 'fill'],
                'line-blur': [
                  'interpolate',
                  ['linear'],
                  ['zoom'],
                  3,
                  0,
                  5,
                  100,
                ],
              },
            ),
          );
        }());

        return () async {
          await styleController.removeLayer(_layerId);
          await styleController.removeSource(_sourceId);
        };
      },
      [styleController, tileUrl],
    );

    return const SizedBox.shrink();
  }
}
