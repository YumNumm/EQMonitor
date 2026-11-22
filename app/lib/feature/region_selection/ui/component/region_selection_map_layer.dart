import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_layers.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class const RegionSelectionMapLayer({
  required final List<RegionOption> selected,
  required final String prefectureGeoJson,
  required final RegionKind kind,
  required final bool hasEpicenter,
  required final VoidCallback onReady,
  required final VoidCallback onError,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final style = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final color = Theme.of(context).colorScheme.primary.withValues(alpha: 1);
    final latest = useRef((selected: selected, kind: kind));
    latest.value = (selected: selected, kind: kind);
    final readyCallback = useRef(onReady)..value = onReady;
    final errorCallback = useRef(onError)..value = onError;
    const builder = RegionMapLayers();
    useEffect(
      () {
        if (style == null) {
          return null;
        }
        var mounted = true;
        final layers = builder.build(color: color, hasEpicenter: hasEpicenter);
        unawaited(
          enqueue(() async {
            try {
              await style.sources.add(
                GeoJsonSource.data(
                  id: RegionMapLayers.prefectureSource,
                  data: .text(prefectureGeoJson),
                ),
              );
              for (final layer in layers) {
                if (!mounted) {
                  return;
                }
                await style.layers.add(layer);
              }
              if (mounted) {
                readyCallback.value();
              }
              // maplibre は ID 重複や source 未登録を ArgumentError で拒否する。
              // ignore: avoid_catching_errors
            } on ArgumentError catch (error, stack) {
              talker.handle(error, stack);
              if (mounted) {
                errorCallback.value();
              }
            } on Exception catch (error, stack) {
              talker.handle(error, stack);
              if (mounted) {
                errorCallback.value();
              }
            }
          }),
        );
        return () {
          mounted = false;
          unawaited(
            enqueue(() async {
              for (final layer in layers.reversed) {
                try {
                  await style.layers.remove(layer.id);
                } on Exception catch (error, stack) {
                  talker.handle(error, stack);
                }
              }
              try {
                await style.sources.remove(RegionMapLayers.prefectureSource);
              } on Exception catch (error, stack) {
                talker.handle(error, stack);
              }
            }),
          );
        };
      },
      [
        style,
        enqueue,
        color,
        hasEpicenter,
        prefectureGeoJson,
        readyCallback,
        errorCallback,
      ],
    );

    useEffect(
      () {
        if (style == null) {
          return null;
        }
        var mounted = true;
        unawaited(
          enqueue(() async {
            if (!mounted) {
              return;
            }
            final current = latest.value;
            for (final type in RegionMapLayers.layers.keys) {
              if (!mounted) {
                return;
              }
              if (type == .epicenter && !hasEpicenter) {
                continue;
              }
              final layer = builder.selectionLayer(
                kind: type,
                selected: current.selected,
              );
              style.layers[layer.id]?.filter = layer.filter;
              style.layers['region-selection-${type.name}-line']?.filter =
                  layer.filter;
            }
            if (mounted && hasEpicenter) {
              style.layers[RegionMapLayers.epicenterHit]?.filter =
                  current.kind == .epicenter
                  ? null
                  : const .raw(RegionMapLayers.hiddenFilter);
            }
          }),
        );
        return () {
          mounted = false;
        };
      },
      [style, enqueue, selected, kind, hasEpicenter, color, prefectureGeoJson],
    );
    return const SizedBox.shrink();
  }
}
