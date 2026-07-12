import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/map/hypocenter_error_range_util.dart';
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

  static const _sourceId = 'eq-history-hypocenter-error';
  static const _layerId = 'eq-history-hypocenter-error-line';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            final coords = earthquake.hypocenter?.coordinates;
            if (coords is! CoordinateLatLng) {
              return;
            }

            final decimalPlaces =
                earthquake.telegramTypes.contains(EarthquakeTelegramType.vxse61)
                ? 3
                : 1;
            final polygon = hypocenterErrorPolygon(
              lat: coords.latitude,
              lon: coords.longitude,
              decimalPlaces: decimalPlaces,
            );

            await styleController.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': [
                    {
                      'type': 'Feature',
                      'geometry': {
                        'type': 'Polygon',
                        'coordinates': [polygon],
                      },
                      'properties': <String, dynamic>{},
                    },
                  ],
                }),
              ),
            );

            await styleController.addLayer(
              LineStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
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
    }, [styleController, earthquake, isDark, parameter]);

    return const SizedBox.shrink();
  }
}
