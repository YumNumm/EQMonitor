import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
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
  final LatLng latLng;

  @override
  String get layerId => _layerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useRef(false);
    final controller = MapController.of(context);
    final styleController = controller.style;
    final mapUtility = ref.watch(mapUtilityProvider);

    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            if (styleController == null) {
              return;
            }
            if (!isInitialized.value) {
              await mapUtility.addHypocenterImages(controller);

              await controller.style!.addSource(
                GeoJsonSource(
                  id: _sourceId,
                  data: _createGeoJson(
                    latLng: latLng,
                    hypocenterType: hypocenterType,
                  ),
                ),
              );

              await controller.style!.addLayer(
                const SymbolStyleLayer(
                  id: _layerId,
                  sourceId: _sourceId,
                  paint: {
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
            }
          }),
        ),
      );
      return null;
    }, [styleController]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      unawaited(
        controller.synchronized(() async {
          await styleController.updateGeoJsonSource(
            id: _sourceId,
            data: _createGeoJson(
              latLng: latLng,
              hypocenterType: hypocenterType,
            ),
          );
        }),
      );
      return null;
    }, [latLng, styleController]);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      unawaited(
        controller.synchronized(() async {
          await styleController.updateLayer(
            SymbolStyleLayer(
              id: _layerId,
              sourceId: _sourceId,
              layout: {'visibility': isVisible ? 'visible' : 'none'},
            ),
          );
        }),
      );
      return null;
    }, [isVisible, styleController]);

    return const SizedBox.shrink();
  }

  String _createGeoJson({
    required LatLng latLng,
    required HypocenterType hypocenterType,
  }) => jsonEncode({
    'type': 'FeatureCollection',
    'features': [
      {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [latLng.lon, latLng.lat],
        },
        'properties': {'hypocenterType': hypocenterType.name},
      },
    ],
  });
}

enum HypocenterType {
  /// 地震
  earthquake,

  /// 火山
  volcano,
}
