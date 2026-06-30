import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/estimated_intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
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
    final colorModel = ref.watch(estimatedIntensityColorProvider);

    final isInitialized = useRef(false);
    final latestRegionMaxIntensities = useRef<List<EewForecastRegionInfo>>([]);
    final enqueue = useMapOperationQueue();

    // regionごとの最大震度を取ったもの
    final regionMaxIntensities = useMemoized(
      () {
        return eewRegions
            .groupListsBy((element) => element.code)
            .map(
              (key, values) => MapEntry(
                key,
                values.sortedBy((e) => e.intensity.orderIndex).last,
              ),
            )
            .values
            .toList();
      },
      [eewRegions],
    );
    latestRegionMaxIntensities.value = regionMaxIntensities;

    // レイヤーの初期化
    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(
          enqueue(() async {
            await JmaIntensity.values
                .where((intensity) => intensity != JmaIntensity.unknown)
                .map((intensity) {
                  final layerId = intensity.layerId;
                  final color = colorModel
                      .fromJmaIntensity(intensity)
                      .background;

                  final codes = regionMaxIntensities
                      .where((r) => r.intensity == intensity)
                      .map((r) => r.code)
                      .toList();

                  return styleController.addLayer(
                    FillStyleLayer(
                      id: layerId,
                      sourceId: 'eqmonitor_map',
                      sourceLayerId: 'areaForecastLocalE',
                      filter: buildEewAreaCodeFilter(codes),
                      paint: {
                        'fill-color': color.toHexString(),
                        'fill-opacity': 1,
                      },
                    ),
                    belowLayerId: BaseLayer.areaForecastLocalELine.name,
                  );
                })
                .wait;

            isInitialized.value = true;
            await _updateEewEstimatedIntensityFilters(
              styleController: styleController,
              regionMaxIntensities: latestRegionMaxIntensities.value,
            );
          }),
        );

        return () {
          unawaited(
            enqueue(() async {
              final futures = JmaIntensity.values
                  .where((intensity) => intensity != JmaIntensity.unknown)
                  .map(
                    (intensity) =>
                        styleController.removeLayer(intensity.layerId),
                  );
              await Future.wait(futures);
            }),
          );
        };
      },
      [styleController, colorModel],
    );

    // データ更新
    useEffect(
      () {
        if (styleController == null || !isInitialized.value) {
          return null;
        }

        unawaited(
          _updateEewEstimatedIntensityFilters(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          ),
        );

        return null;
      },
      [styleController, regionMaxIntensities],
    );

    return const SizedBox.shrink();
  }
}

Future<void> _updateEewEstimatedIntensityFilters({
  required StyleController styleController,
  required List<EewForecastRegionInfo> regionMaxIntensities,
}) async {
  await JmaIntensity.values
      .where((intensity) => intensity != JmaIntensity.unknown)
      .map((intensity) {
        final codes = regionMaxIntensities
            .where((r) => r.intensity == intensity)
            .map((r) => r.code)
            .toList();
        return styleController.updateFilter(
          id: intensity.layerId,
          filter: buildEewAreaCodeFilter(codes),
        );
      })
      .wait;
}

extension on JmaIntensity {
  String get layerId => 'eew-estimated-intensity-fill-$name';
}
