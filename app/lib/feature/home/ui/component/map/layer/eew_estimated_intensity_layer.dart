import 'dart:async';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const EewEstimatedIntensityLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final intensityData = ref.watch(estimatedIntensityProvider);
    final colorModel = ref.watch(intensityColorProvider);

    final isInitialized = useRef(false);

    // レイヤーの初期化
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          final futures = JmaForecastIntensity.values.map((intensity) {
            final layerId = _getLayerId(intensity);
            final color = colorModel
                .fromJmaForecastIntensity(intensity)
                .background;

            return styleController.addLayer(
              FillStyleLayer(
                id: layerId,
                sourceId: 'eqmonitor_map',
                paint: {
                  'fill-color': color.toHexString(),
                },
              ),
            );
          });

          await Future.wait(futures);
          isInitialized.value = true;
        }());

        return () async {
          final futures = JmaForecastIntensity.values.map(
            (intensity) => styleController.removeLayer(_getLayerId(intensity)),
          );
          await Future.wait(futures);
        };
      },
      [styleController],
    );

    // データ更新
    useEffect(
      () {
        if (styleController == null ||
            !isInitialized.value ||
            intensityData.value == null) {
          return null;
        }

        unawaited(() async {
          final removeFutures = JmaForecastIntensity.values.map(
            (intensity) => styleController.removeLayer(_getLayerId(intensity)),
          );
          await Future.wait(removeFutures);

          final addFutures = JmaForecastIntensity.values.map((intensity) {
            final layerId = _getLayerId(intensity);
            final color = colorModel
                .fromJmaForecastIntensity(intensity)
                .background;

            return styleController.addLayer(
              FillStyleLayer(
                id: layerId,
                sourceId: 'eqmonitor_map',
                paint: {
                  'fill-color': color.toHexString(),
                },
              ),
            );
          });
          await Future.wait(addFutures);
        }());

        return null;
      },
      [styleController, intensityData, colorModel],
    );

    return const SizedBox.shrink();
  }
}

String _getLayerId(JmaForecastIntensity intensity) {
  final base = intensity.type
      .replaceAll('-', 'low')
      .replaceAll('+', 'high')
      .replaceAll('不明', 'unknown');
  return 'eew-estimated-intensity-fill-$base';
}
