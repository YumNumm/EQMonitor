import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_area_filter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 警報発表区域の塗りつぶし（府県予報区 `eqmonitor_map`）
class EewWarningRegionsLayer extends HookConsumerWidget {
  const EewWarningRegionsLayer({required this.eews, super.key});

  final List<EewTelegramItem> eews;

  static const _layerId = 'eew-warning-regions-fill';
  static const _areaFilterBuilder = EewAreaFilterBuilder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final codes = useMemoized(() {
      final out = <String>{};
      for (final e in eews) {
        final zones = e.warning?.regions;
        if (zones == null) {
          continue;
        }
        for (final z in zones) {
          if (z.hadWarning) {
            out.add(z.code);
          }
        }
      }
      return out.toList();
    }, [eews]);

    final isInitialized = useRef(false);
    final latestCodes = useRef<List<String>>(codes);
    latestCodes.value = codes;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await styleController.addLayer(
            FillStyleLayer(
              id: _layerId,
              sourceId: 'eqmonitor_map',
              sourceLayerId: 'areaForecastLocalEew',
              filter: _areaFilterBuilder.build(codes),
              paint: const {'fill-color': '#FF0000', 'fill-opacity': 0.25},
            ),
          );
          isInitialized.value = true;
          await styleController.updateFilter(
            id: _layerId,
            filter: _areaFilterBuilder.build(latestCodes.value),
          );
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            isInitialized.value = false;
            await styleController.removeLayer(_layerId);
          }),
        );
      };
    }, [styleController]);

    useEffect(() {
      if (styleController == null || !isInitialized.value) {
        return null;
      }
      unawaited(
        enqueue(
          () => styleController.updateFilter(
            id: _layerId,
            filter: _areaFilterBuilder.build(codes),
          ),
        ),
      );
      return null;
    }, [styleController, codes]);

    return const SizedBox.shrink();
  }
}
