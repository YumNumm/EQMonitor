import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/core/util/map_utility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_intensity_region_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';
import 'package:synchronized/extension.dart';

class EarthquakeIntensityRegionSymbolLayer extends HookConsumerWidget
    implements MapLayer {
  const EarthquakeIntensityRegionSymbolLayer({
    required this.eventId,
    this.visible = true,
    super.key,
  });

  final int eventId;
  final bool visible;

  @override
  String get layerId => _getLayerId(JmaIntensity.values.first);

  static const sourceId = 'earthquake-intensity-region';

  Iterable<JmaIntensity> get allowedIntensities =>
      JmaIntensity.values.where((e) => e != JmaIntensity.fiveUpperNoInput);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaMap = ref.watch(jmaMapProvider).valueOrNull;
    if (jmaMap == null) {
      return const SizedBox.shrink();
    }

    final isInitialized = useRef(false);
    final controller = MapController.of(context);

    final earthquake = ref.watch(
      earthquakeHistoryDetailsNotifierProvider(eventId),
    );

    // レイヤーの初期化
    useEffect(() {
      unawaited(
        WidgetsBinding.instance.endOfFrame.then(
          (_) async => controller.synchronized(() async {
            if (earthquake.valueOrNull == null) {
              return;
            }

            unawaited(
              controller.synchronized(() async {
                await Future<void>.delayed(const Duration(milliseconds: 1000));
                await controller.style!.addSource(
                  GeoJsonSource(
                    id: sourceId,
                    data: _createGeoJson(
                      earthquake: earthquake.valueOrNull!,
                      jmaMap: jmaMap.areaForecastLocalE,
                    ),
                  ),
                );
                await [
                  for (final intensity in allowedIntensities)
                    // レイヤーを追加
                    controller.style!.addLayer(
                      SymbolStyleLayer(
                        id: _getLayerId(intensity),
                        sourceId: 'eqmonitor_map',
                        paint: {
                          'icon-image': MapUtility.lowPreciseHypocenterImage,
                          'icon-size': [
                            'interpolate',
                            ['linear'],
                            ['zoom'],
                            3,
                            0.3,
                            20,
                            1,
                          ],
                          'icon-allow-overlap': true,
                        },
                        // layout: {
                        //   'filter': [
                        //     '==',
                        //     ['get', 'intensity'],
                        //     intensity.type,
                        //   ],
                        // },
                      ),
                      sourceLayer: sourceId,
                      belowLayerId:
                          const EarthquakeIntensityRegionLayer(
                            eventId: 0,
                          ).layerId,
                    ),
                ].wait;
              }),
            );
            isInitialized.value = true;
          }),
        ),
      );
      return () {
        isInitialized.value = false;
      };
    }, []);

    // 地震情報の状態が変更されたときの処理
    ref.listen(earthquakeHistoryDetailsNotifierProvider(eventId), (
      _,
      next,
    ) async {
      if (!isInitialized.value || next.valueOrNull == null) {
        return;
      }

      unawaited(
        controller.synchronized(() async {
          await controller.style!.updateGeoJsonSource(
            id: sourceId,
            data: _createGeoJson(
              earthquake: earthquake.valueOrNull!,
              jmaMap: jmaMap.areaForecastLocalE,
            ),
          );
        }),
      );
    });

    useEffect(() {
      unawaited(
        controller.synchronized(
          () async => controller.style!.updateLayer(
            FillStyleLayer(
              id: _getLayerId(JmaIntensity.values.first),
              sourceId: 'eqmonitor_map',
              layout: {'visibility': visible ? 'visible' : 'none'},
            ),
          ),
        ),
      );
      return null;
    }, [visible]);

    return const SizedBox.shrink();
  }

  // 各震度ごとのレイヤーID
  static String _getLayerId(JmaIntensity intensity) {
    final base = intensity.type
        .replaceAll('-', 'low')
        .replaceAll('+', 'high')
        .replaceAll('!5-', 'unknown');
    return 'earthquake-intensity-symbol-$base';
  }

  String _createGeoJson({
    required EarthquakeV1Extended earthquake,
    required JmaMap_JmaMapData jmaMap,
  }) {
    final features = <Map<String, dynamic>>[];
    for (final region
        in earthquake.intensityRegions ?? <ObservedRegionIntensity>[]) {
      final matchedJmaRegion = jmaMap.data.firstWhereOrNull(
        (v) => v.property.code == region.code,
      );
      if (matchedJmaRegion == null) {
        continue;
      }

      final feature = <String, dynamic>{
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [
            matchedJmaRegion.polylabel.lng,
            matchedJmaRegion.polylabel.lat,
          ],
        },
        'properties': {
          'code': matchedJmaRegion.property.code,
          'name': matchedJmaRegion.property.name,
          'intensity': region.intensity?.type,
        },
      };
      features.add(feature);
    }

    final geoJson = <String, dynamic>{
      'type': 'FeatureCollection',
      'features': features,
    };

    final encoded = jsonEncode(geoJson);
    print(encoded);
    return encoded;
  }
}
