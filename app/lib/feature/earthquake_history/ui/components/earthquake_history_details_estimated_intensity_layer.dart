import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';

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
            RasterSource(
              id: _sourceId,
              tiles: [tileUrl],
              tileSize: 512,
              minZoom: 0,
              maxZoom: 14,
            ),
          );

          await styleController.addLayer(
            const RasterStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              paint: {
                'raster-opacity': 0.75,
              },
            ),
            belowLayerId: BaseLayer.countriesFill.name,
          );
        }());

        return () async {
          await styleController.removeLayer(_layerId);
          await styleController.removeSource(_sourceId);
        };
      },
      [styleController],
    );

    return const SizedBox.shrink();
  }
}
