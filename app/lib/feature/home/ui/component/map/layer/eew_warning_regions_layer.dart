import 'dart:async';

import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 警報発表区域の塗りつぶし（府県予報区 `eqmonitor_map`）
class EewWarningRegionsLayer extends HookConsumerWidget {
  const EewWarningRegionsLayer({required this.eews, super.key});

  final List<EewTelegramItem> eews;

  static const _layerId = 'eew-warning-regions-fill';

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

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          await styleController.addLayer(
            const FillStyleLayer(
              id: _layerId,
              sourceId: 'eqmonitor_map',
              paint: {
                'fill-color': '#FF0000',
                'fill-opacity': 0.25,
              },
            ),
          );
          isInitialized.value = true;
        }());

        return () async {
          await styleController.removeLayer(_layerId);
        };
      },
      [styleController],
    );

    useEffect(
      () {
        if (styleController == null || !isInitialized.value) {
          return null;
        }
        final filter = codes.isEmpty
            ? <Object>['==', '1', '2']
            : <Object>[
                'in',
                ['get', 'code'],
                ['literal', codes],
              ];
        unawaited(styleController.updateFilter(id: _layerId, filter: filter));
        return null;
      },
      [styleController, codes],
    );

    return const SizedBox.shrink();
  }
}
