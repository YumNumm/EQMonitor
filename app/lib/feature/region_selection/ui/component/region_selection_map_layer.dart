import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/region_map_layers.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class RegionSelectionMapLayer extends HookWidget {
  const new({
    required this.selected,
    required this.catalog,
    required this.kind,
    required this.hasEpicenter,
    required this.onReady,
    required this.onError,
    super.key,
  });

  final List<RegionOption> selected;
  final List<RegionOption> catalog;
  final RegionKind kind;
  final bool hasEpicenter;
  final VoidCallback onReady;
  final VoidCallback onError;

  @override
  Widget build(BuildContext context) {
    final style = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final color = Theme.of(context).colorScheme.primary.toHexStringRGB();
    final latest = useRef((selected: selected, catalog: catalog, kind: kind));
    latest.value = (selected: selected, catalog: catalog, kind: kind);
    final readyCallback = useRef(onReady)..value = onReady;
    final errorCallback = useRef(onError)..value = onError;
    const builder = RegionMapLayers();
    useEffect(() {
      if (style == null) {
        return null;
      }
      var mounted = true;
      final layers = builder.build(color: color, hasEpicenter: hasEpicenter);
      unawaited(
        enqueue(() async {
          try {
            for (final layer in layers) {
              if (!mounted) {
                return;
              }
              await style.addLayer(layer);
            }
            if (mounted) {
              readyCallback.value();
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
                await style.removeLayer(layer.id);
              } on Exception catch (error, stack) {
                talker.handle(error, stack);
              }
            }
          }),
        );
      };
    }, [style, enqueue, color, hasEpicenter, readyCallback, errorCallback]);

    useEffect(() {
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
              catalog: current.catalog,
            );
            await style.updateFilter(id: layer.id, filter: layer.filter);
            await style.updateFilter(
              id: 'region-selection-${type.name}-line',
              filter: layer.filter,
            );
          }
          if (mounted && hasEpicenter) {
            await style.updateFilter(
              id: RegionMapLayers.epicenterHit,
              filter: current.kind == .epicenter ? null : const ['==', 1, 0],
            );
          }
        }),
      );
      return () {
        mounted = false;
      };
    }, [style, enqueue, selected, catalog, kind, hasEpicenter, color]);
    return const SizedBox.shrink();
  }
}
