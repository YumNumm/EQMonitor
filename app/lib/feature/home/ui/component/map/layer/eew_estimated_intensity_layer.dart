import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const EewEstimatedIntensityLayer({required this.eewRegions, super.key});

  final List<EewForecastRegionInfo> eewRegions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel =
        ref.watch(intensityColorProvider).asData?.value ??
        IntensityColorModel.eqmonitor();

    final isInitialized = useRef(false);

    // regionごとの最大震度を取ったもの
    final regionMaxIntensities = useMemoized(() {
      return eewRegions
          .groupListsBy((element) => element.code)
          .map(
            (key, values) => MapEntry(
              key,
              values
                  .sortedBy(
                    // TODO(eqmonitor_api): intensity は codegen バグにより常に unknown
                    (e) => 0,
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
          await JmaIntensity.values.map((intensity) {
            final layerId = _getLayerId(intensity);
            final color = colorModel.fromJmaIntensity(intensity).background;

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
          final futures = JmaIntensity.values.map(
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

        // TODO(YumNumm): 予想震度レイヤー
        // unawaited(() async {
        //   await JmaIntensity.values
        //       .map(
        //         (intensity) => styleController.updateFilter(
        //           id: _getLayerId(intensity),
        //           filter: [
        //             'all',
        //             [
        //               'in',
        //               'region',
        //               regionMaxIntensities
        //                   .where(
        //                     (r) =>
        //                         // TODO(eqmonitor_api): intensity は codegen バグにより常に unknown
        //                         JmaIntensity.unknown ==
        //                         intensity,
        //                   )
        //                   .map((r) => r.code)
        //                   .toList(),
        //             ],
        //           ],
        //         ),
        //       )
        //       .wait;
        // }());

        return null;
      },
      [styleController, regionMaxIntensities, colorModel],
    );

    return const SizedBox.shrink();
  }
}

String _getLayerId(JmaIntensity intensity) {
  final base = intensity.label
      .replaceAll('-', 'low')
      .replaceAll('+', 'high')
      .replaceAll('不明', 'unknown');
  return 'eew-estimated-intensity-fill-$base';
}
