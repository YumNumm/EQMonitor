import 'dart:async';
import 'dart:convert';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class EewHypocenterSymbolLayer extends HookConsumerWidget implements MapLayer {
  const EewHypocenterSymbolLayer({super.key});

  static const _sourceId = 'eew_hypocenter_source';

  String _layerId(bool isLowPrecise) =>
      'eew_hypocenter_symbol_layer_${isLowPrecise ? 'low' : 'normal'}';

  @override
  String get layerId => _layerId(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapLibreInherited.of(context);
    final manager = useMemoized(_EewHypocenterPaintManager.new);

    final isVisible = useState(true);
    final timer = useRef<Timer?>(null);

    useEffect(() {
      timer.value = Timer.periodic(const Duration(milliseconds: 500), (_) {
        isVisible.value = !isVisible.value;
      });

      return () {
        timer.value?.cancel();
        timer.value = null;
      };
    }, const []);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async {
            final style = controller.style;
            if (style == null) return;
            
            await controller.synchronized(() async {
              await ref.read(mapUtilityProvider).addHypocenterImages(style);
              final activeEews = ref.read(eewAliveTelegramProvider) ?? [];
              
              try {
                await style.removeSource(_sourceId);
              } catch (_) {}
              
              await style.addSource(
                GeoJsonSource(
                  id: _sourceId,
                  data: jsonEncode(_convertEewsToGeoJson(activeEews)),
                ),
              );

              await style.addLayer(
                SymbolStyleLayer(
                  id: _layerId(false),
                  sourceId: _sourceId,
                  layout: {
                    'icon-image': manager.json(isLowPrecise: false)['icon-image']!,
                    'icon-size': manager.json(isLowPrecise: false)['icon-size']!,
                    'icon-allow-overlap': true,
                  },
                ),
              );

              await style.addLayer(
                SymbolStyleLayer(
                  id: _layerId(true),
                  sourceId: _sourceId,
                  layout: {
                    'icon-image': manager.json(isLowPrecise: true)['icon-image']!,
                    'icon-size': manager.json(isLowPrecise: true)['icon-size']!,
                    'icon-allow-overlap': true,
                  },
                ),
              );
              isInitialized.value = true;
            });
          },
        ),
      );
      return null;
    }, []);

    ref.listen(eewAliveTelegramProvider, (_, eews) async {
      if (!isInitialized.value) {
        return;
      }
      final activeEews = eews ?? [];
      final controller = MapLibreInherited.of(context);
      final style = controller.style;
      if (style == null) return;
      
      unawaited(
        controller.synchronized(() async {
          final geojson = _convertEewsToGeoJson(activeEews);
          await style.updateGeoJsonSource(
            id: _sourceId,
            data: jsonEncode(geojson),
          );
        }),
      );
    });

    useEffect(() {
      final hasEew = ref.read(eewAliveTelegramProvider)?.isNotEmpty ?? false;
      final style = controller.style;
      if (hasEew && style != null) {
        unawaited(
          controller.synchronized(() async {
            await [
              () async {
                try {
                  await style.removeLayer(_layerId(false));
                } catch (_) {}
                await style.addLayer(
                  SymbolStyleLayer(
                    id: _layerId(false),
                    sourceId: _sourceId,
                    layout: {
                      'icon-image': manager.json(isLowPrecise: false)['icon-image']!,
                      'icon-size': manager.json(isLowPrecise: false)['icon-size']!,
                      'icon-allow-overlap': true,
                    },
                    paint: {
                      'icon-opacity': isVisible.value ? 1.0 : 0.5,
                    },
                  ),
                );
              }(),
              () async {
                try {
                  await style.removeLayer(_layerId(true));
                } catch (_) {}
                await style.addLayer(
                  SymbolStyleLayer(
                    id: _layerId(true),
                    sourceId: _sourceId,
                    layout: {
                      'icon-image': manager.json(isLowPrecise: true)['icon-image']!,
                      'icon-size': manager.json(isLowPrecise: true)['icon-size']!,
                      'icon-allow-overlap': true,
                    },
                    paint: {
                      'icon-opacity': isVisible.value ? 1.0 : 0.5,
                    },
                  ),
                );
              }(),
            ].wait;
          }),
        );
      }
      return null;
    }, [isVisible.value]);

    return const SizedBox.shrink();
  }

  static Map<String, dynamic> _convertEewsToGeoJson(List<EewV1> eews) {
    return {
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
    };
  }
}

class _EewHypocenterPaintManager {
  Map<String, Object> json({required bool isLowPrecise}) {
    const normal = MapUtility.normalHypocenterImage;
    const lowPrecise = MapUtility.lowPreciseHypocenterImage;
    return {
      'icon-image': isLowPrecise ? lowPrecise : normal,
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
