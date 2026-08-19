import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/theme/model/estimated_intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer_filter_updater.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewEstimatedIntensityLayer extends HookConsumerWidget {
  const new({required this.eewRegions, super.key});

  final List<EewForecastRegionInfo> eewRegions;

  static const _areaFilterBuilder = EewAreaFilterBuilder();
  static const _filterUpdater = EewEstimatedIntensityLayerFilterUpdater();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).estimatedIntensity;

    final isInitialized = useRef(false);
    final latestRegionMaxIntensities = useRef<List<EewForecastRegionInfo>>([]);
    final enqueue = useMapOperationQueue();

    // regionごとの最大震度を取ったもの
    final regionMaxIntensities = useMemoized(() {
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
      // 'e' は sortedBy のクロージャ引数であり外部の値ではない。
      // eewRegions は先頭で実際に参照している。
      // ignore_keys: e, eewRegions
    }, [eewRegions]);
    latestRegionMaxIntensities.value = regionMaxIntensities;

    // レイヤーの初期化
    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await JmaIntensity.values
              .where((intensity) => intensity != JmaIntensity.unknown)
              .map((intensity) {
                final layerId = intensity.layerId;
                final color = colorModel.fromJmaIntensity(intensity).background;

                final codes = regionMaxIntensities
                    .where((r) => r.intensity == intensity)
                    .map((r) => r.code)
                    .toList();

                return styleController.addLayer(
                  FillStyleLayer(
                    id: layerId,
                    sourceId: 'eqmonitor_map',
                    sourceLayerId: 'areaForecastLocalE',
                    filter: _areaFilterBuilder.build(codes),
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
          await _filterUpdater.update(
            styleController: styleController,
            regionMaxIntensities: latestRegionMaxIntensities.value,
          );
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            isInitialized.value = false;
            final futures = JmaIntensity.values
                .where((intensity) => intensity != JmaIntensity.unknown)
                .map(
                  (intensity) => styleController.removeLayer(intensity.layerId),
                );
            await Future.wait(futures);
          }),
        );
      };
      // BaseLayer は静的メンバ参照であり変数ではない。
      // colorModel は addLayer の paint 生成に使っているため keys から外せない
      // (プラグインがネストしたクロージャ内の参照を拾えず誤検出する)。
      // ignore_keys: BaseLayer, colorModel
    }, [styleController, colorModel]);

    // データ更新
    useEffect(() {
      if (styleController == null || !isInitialized.value) {
        return null;
      }

      unawaited(
        enqueue(
          () => _filterUpdater.update(
            styleController: styleController,
            regionMaxIntensities: regionMaxIntensities,
          ),
        ),
      );

      return null;
    }, [styleController, regionMaxIntensities]);

    return const SizedBox.shrink();
  }
}
