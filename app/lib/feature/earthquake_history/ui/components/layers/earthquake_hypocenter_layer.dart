import 'dart:async';

import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:synchronized/extension.dart';

// ignore: avoid_implementing_value_types
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
  final LatLng latLng;

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
          (_) async => controller.synchronized(() async {
            if (!isInitialized.value) {
              await mapUtility.addHypocenterImages(controller);

              // Remove source if it already exists to prevent duplicates
              await controller.removeSource(_sourceId);
              await controller.addGeoJsonSource(
                _sourceId,
                _createGeoJson(latLng: latLng, hypocenterType: hypocenterType),
              );

              await controller.addLayer(
                _layerId,
                _sourceId,
                const SymbolLayerProperties(
                  iconImage: MapUtility.normalHypocenterImage,
                  iconSize: [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    3,
                    0.3,
                    20,
                    2,
                  ],
                  iconAllowOverlap: true,
                ),
              );
              isInitialized.value = true;
            }
          }),
        ),
      );
      return null;
    }, [controller]);

    useEffect(() {
      if (!isInitialized.value) {
        return;
      }
      unawaited(
        controller.synchronized(() async {
          await controller.setGeoJsonSource(
            _sourceId,
            _createGeoJson(latLng: latLng, hypocenterType: hypocenterType),
          );
        }),
      );
      return null;
    }, [latLng, controller, isInitialized.value]);

    useEffect(() {
      if (!isInitialized.value) {
        return;
      }
      unawaited(
        controller.synchronized(() async {
          await controller.setLayerProperties(
            _layerId,
            SymbolLayerProperties(visibility: isVisible ? 'visible' : 'none'),
          );
        }),
      );
      return null;
    }, [isVisible, controller, isInitialized.value]);

    return const SizedBox.shrink();
  }

  Map<String, dynamic> _createGeoJson({
    required LatLng latLng,
    required HypocenterType hypocenterType,
  }) => {
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [latLng.longitude, latLng.latitude],
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
