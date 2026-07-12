import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震源マーカー
///
/// [displayMode] に応じて不透明度を制御する。
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

  static const _sourceId = 'earthquake-history-hypocenter';
  static const _layerId = 'earthquake-history-hypocenter-symbol';
  static const _iconId = 'earthquake-history-hypocenter-icon';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            await styleController.addImageFromAssets(
              id: _iconId,
              asset: Assets.images.map.normalHypocenter.path,
            );

            final hyp = earthquake.hypocenter;
            final coords = hyp?.coordinates;
            final features = <Map<String, dynamic>>[
              if (coords is CoordinateLatLng)
                {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [coords.longitude, coords.latitude],
                  },
                  'properties': <String, dynamic>{},
                },
            ];

            await styleController.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': features,
                }),
              ),
            );

            await styleController.addLayer(
              SymbolStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                layout: {
                  'icon-allow-overlap': true,
                  'icon-ignore-placement': true,
                  'icon-image': _iconId,
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
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(_layerId);
            } on Exception catch (e) {
              talker.log(e);
            }
            try {
              await styleController.removeSource(_sourceId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, earthquake, displayMode, parameter]);

    return const SizedBox.shrink();
  }
}
