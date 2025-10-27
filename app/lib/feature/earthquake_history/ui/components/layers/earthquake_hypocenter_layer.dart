import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class EarthquakeHypocenterLayer extends HookConsumerWidget implements MapLayer {
  const EarthquakeHypocenterLayer({
    required this.isVisible,
    required this.hypocenterType,
    required this.latLng,
    super.key,
  });

  static const _layerId = 'earthquake_hypocenter_layer';
  static const _sourceId = 'earthquake_hypocenter_source';

  final bool isVisible;
  final HypocenterType hypocenterType;
  final Position latLng;

  @override
  String get layerId => _layerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapLibreInherited.of(context);
    final mapUtility = ref.watch(mapUtilityProvider);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async {
            final style = controller.style;
            if (style == null || isInitialized.value) return;
            
            await controller.synchronized(() async {
              await mapUtility.addHypocenterImages(style);

              // Remove source if it already exists to prevent duplicates
              try {
                await style.removeSource(_sourceId);
              } catch (_) {
                // Source doesn't exist yet, ignore
              }
              
              await style.addSource(
                GeoJsonSource(
                  id: _sourceId,
                  data: jsonEncode(_createGeoJson(latLng: latLng, hypocenterType: hypocenterType)),
                ),
              );

              await style.addLayer(
                SymbolStyleLayer(
                  id: _layerId,
                  sourceId: _sourceId,
                  layout: {
                    'icon-image': MapUtility.normalHypocenterImage,
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
                  },
                ),
              );
              isInitialized.value = true;
            });
          },
        ),
      );
      return null;
    }, [controller]);

    useEffect(() {
      if (!isInitialized.value) {
        return;
      }
      final style = controller.style;
      if (style == null) return;
      
      unawaited(
        controller.synchronized(() async {
          await style.updateGeoJsonSource(
            id: _sourceId,
            data: jsonEncode(_createGeoJson(latLng: latLng, hypocenterType: hypocenterType)),
          );
        }),
      );
      return null;
    }, [latLng, controller, isInitialized.value]);

    useEffect(() {
      if (!isInitialized.value) {
        return;
      }
      final style = controller.style;
      if (style == null) return;
      
      unawaited(
        controller.synchronized(() async {
          // Remove and re-add the layer with updated visibility
          await style.removeLayer(_layerId);
          await style.addLayer(
            SymbolStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              layout: {
                'icon-image': MapUtility.normalHypocenterImage,
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
                'visibility': isVisible ? 'visible' : 'none',
              },
            ),
          );
        }),
      );
      return null;
    }, [isVisible, controller, isInitialized.value]);

    return const SizedBox.shrink();
  }

  Map<String, dynamic> _createGeoJson({
    required Position latLng,
    required HypocenterType hypocenterType,
  }) => {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [latLng.lng, latLng.lat],
        },
        'properties': {'hypocenterType': hypocenterType.name},
      },
    ],
  };
}

enum HypocenterType {
  /// 地震
  earthquake,

  /// 火山
  volcano,
}
