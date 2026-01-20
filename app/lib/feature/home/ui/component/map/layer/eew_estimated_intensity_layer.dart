import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/intensity_value_ext.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const EewEstimatedIntensityLayer({required this.eewRegions, super.key});

  final List<EewIntensityItem> eewRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    final isInitialized = useRef(false);

    // regionごとの最大震度を取ったもの
    final regionMaxIntensities = useMemoized(() {
      return eewRegions
          .groupListsBy((element) => element.value.code)
          .map(
            (key, values) => MapEntry(
              key,
              values
                  .sortedBy(
                    (e) => e.intensity.value.index,
                  )
                  .last,
            ),
          )
          .values
          .toList();
    }, [eewRegions]);

    // レイヤーの初期化
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await JmaForecastIntensity.values.map((intensity) {
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
          }).wait;

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
        if (styleController == null || !isInitialized.value) {
          return null;
        }

        unawaited(() async {
          await JmaForecastIntensity.values
              .map(
                (intensity) => styleController.updateFilter(
                  id: _getLayerId(intensity),
                  filter: [
                    'all',
                    [
                      'in',
                      'region',
                      regionMaxIntensities
                          .where(
                            (r) =>
                                r.intensity.value.toJmaForecastIntensity ==
                                intensity,
                          )
                          .map((r) => r.value.code)
                          .toList(),
                    ],
                  ],
                ),
              )
              .wait;
        }());

        return null;
      },
      [styleController, regionMaxIntensities, colorModel],
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
