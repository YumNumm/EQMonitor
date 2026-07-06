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
    required this.enqueue,
    this.parameter = const EarthquakeHistoryMapLayerParameter(),
    super.key,
  });

  final Earthquake earthquake;
  final MapOperationScheduler enqueue;
  final EarthquakeHistoryMapLayerParameter parameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final layerBuilder = useMemoized(
      EarthquakeHistoryHypocenterErrorLayerBuilder.new,
    );

    final isInitialized = useRef(false);
    final latestParameter = useRef(parameter);
    latestParameter.value = parameter;
    final latestEarthquake = useRef(earthquake);
    latestEarthquake.value = earthquake;
    final latestIsDark = useRef(isDark);
    latestIsDark.value = isDark;

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            final coords = latestEarthquake.value.hypocenter?.coordinates;
            if (coords is! CoordinateLatLng) {
              return;
            }

            final decimalPlaces =
                latestEarthquake.value.telegramTypes.contains(
                  EarthquakeTelegramType.vxse61,
                )
                ? 3
                : 1;
            final polygon = hypocenterErrorPolygon(
              lat: coords.latitude,
              lon: coords.longitude,
              decimalPlaces: decimalPlaces,
            );

            await styleController.addSource(
              GeoJsonSource(
                id: EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId,
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
              layerBuilder.buildLineLayer(
                parameter: latestParameter.value,
                isDark: latestIsDark.value,
              ),
            );

            isInitialized.value = true;
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        isInitialized.value = false;
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(
                EarthquakeHistoryHypocenterErrorLayerBuilder.layerId,
              );
              await styleController.removeSource(
                EarthquakeHistoryHypocenterErrorLayerBuilder.sourceId,
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, earthquake, isDark, enqueue, layerBuilder]);

    useEffect(() {
      if (styleController == null || !isInitialized.value) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            await styleController.removeLayer(
              EarthquakeHistoryHypocenterErrorLayerBuilder.layerId,
            );
            await styleController.addLayer(
              layerBuilder.buildLineLayer(
                parameter: parameter,
                isDark: latestIsDark.value,
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return null;
    }, [styleController, parameter, enqueue, layerBuilder]);

    return const SizedBox.shrink();
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
