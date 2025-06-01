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
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
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
    final controller = MapLibreInherited.of(context);

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

                final geoJsonData = _createGeoJson(
                  earthquake: earthquake.valueOrNull!,
                  jmaMap: jmaMap.areaForecastLocalE,
                );

                await controller.addSource(
                  sourceId,
                  GeojsonSourceProperties(data: jsonEncode(geoJsonData)),
                );

                await [
                  for (final intensity in allowedIntensities)
                    // レイヤーを追加
                    controller.addLayer(
                      _getLayerId(intensity),
                      sourceId,
                      const SymbolLayerProperties(
                        iconImage: MapUtility.lowPreciseHypocenterImage,
                        iconSize: [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          3,
                          0.3,
                          20,
                          1,
                        ],
                        iconAllowOverlap: true,
                      ),
                      filter: [
                        '==',
                        ['get', 'intensity'],
                        intensity.type,
                      ],
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
          final geoJsonData = _createGeoJson(
            earthquake: next.valueOrNull!,
            jmaMap: jmaMap.areaForecastLocalE,
          );

          await controller.setGeoJsonSource(sourceId, geoJsonData);
        }),
      );
    });

    useEffect(() {
      unawaited(
        controller.synchronized(
          () async =>
              JmaIntensity.values
                  .map(
                    (intensity) => controller.setLayerVisibility(
                      _getLayerId(intensity),
                      visible,
                    ),
                  )
                  .wait,
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

  // 地震履歴の震度地域のGeoJSON作成
  Map<String, dynamic> _createGeoJson({
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

    print('GeoJSON: ${features.length} features');
    return geoJson;
  }
}
