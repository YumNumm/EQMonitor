import 'dart:async';
import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/eew/data/eew_telegram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class EewHypocenterSymbolLayer extends HookConsumerWidget {
  const EewHypocenterSymbolLayer({super.key});

  static const _layerId = 'eew_hypocenter_symbol_layer';
  static const _sourceId = 'eew_hypocenter_source';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final manager = useMemoized(_EewHypocenterPaintManager.new);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            final activeEews = ref.read(
              eewProvider.select((eews) => eews.valueOrNull ?? []),
            );
            await controller.style!.addSource(
              GeoJsonSource(
                id: _sourceId,
                data: _convertEewsToGeoJson(activeEews),
              ),
            );

            await controller.style!.addLayer(
              SymbolStyleLayer(
                id: _layerId,
                sourceId: _sourceId,
                paint: manager.json(),
              ),
            );
            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
        unawaited(
          controller.synchronized(() async {
            await controller.style!.removeLayer(_layerId);
            await controller.style!.removeSource(_sourceId);
          }),
        );
      };
    }, []);

    ref.listen(eewProvider, (_, eews) async {
      if (!isInitialized.value) {
        return;
      }
      final activeEews = eews.valueOrNull ?? [];
      final controller = MapController.of(context);
      unawaited(
        controller.synchronized(() async {
          await controller.style!.updateGeoJsonSource(
            id: _sourceId,
            data: _convertEewsToGeoJson(activeEews),
          );
        }),
      );
    });

    return const SizedBox.shrink();
  }

  static String _convertEewsToGeoJson(List<EewV1> eews) {
    return jsonEncode({
      'type': 'FeatureCollection',
      'features':
          eews
              .where(
                (eew) =>
                    eew.latitude != null &&
                    eew.longitude != null &&
                    !eew.isCanceled,
              )
              .map(
                (eew) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [eew.longitude!, eew.latitude!],
                  },
                  'properties': {
                    'magnitude': eew.magnitude ?? 0.0,
                    'isLowPrecise':
                        eew.isIpfOnePoint ||
                        eew.isLevelEew ||
                        (eew.isPlum ?? false),
                  },
                },
              )
              .toList(),
    });
  }
}

class _EewHypocenterPaintManager {
  Map<String, Object> json() {
    const normal = MapUtility.normalHypocenterImage;
    const lowPrecise = MapUtility.lowPreciseHypocenterImage;
    return {
      // 'icon-image': normal,
      'icon-image': ['get', 'isLowPrecise', lowPrecise, normal],
      'icon-size': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.3,
        20,
        2,
      ],
      'icon-allow-overlap': true,
    };
  }
}
