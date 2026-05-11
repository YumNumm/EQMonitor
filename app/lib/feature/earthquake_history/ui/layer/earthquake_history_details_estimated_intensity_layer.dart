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

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }
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
                'fill-opacity': 0.65,
                'fill-color': ['get', 'fill'],
              },
            ),
            belowLayerId: BaseLayer.areaForecastLocalELine.name,
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
