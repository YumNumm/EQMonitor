import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の地域・市区町村レベル震度アイコンレイヤー
///
/// `jma_map` の polylabel 座標に角丸四角の震度アイコンを表示する。
/// iconMode に応じて表示するレベルを制御する。
/// - auto: 細分化地域 → 市区町村 → 観測点
/// - region: 細分化地域のみ
/// - city: 市区町村のみ
/// - station / none: 表示なし
/// showingLpgmIntensity が true の場合は長周期地震動階級アイコンを表示する。
class EarthquakeHistoryIntensityIconLayer extends HookConsumerWidget {
  const EarthquakeHistoryIntensityIconLayer({
    required this.earthquake,
    required this.config,
    this.zoomThresholds = defaultEarthquakeHistoryMapLayerZoomThresholds,
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryDetailConfig config;
  final EarthquakeHistoryMapLayerZoomThresholds zoomThresholds;

  static const _regionSourceId = 'eq-history-icon-region-geojson';
  static const _regionLayerId = 'eq-history-icon-region-symbol';
  static const _citySourceId = 'eq-history-icon-city-geojson';
  static const _cityLayerId = 'eq-history-icon-city-symbol';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final modeResolver = useMemoized(
      () => const EarthquakeHistoryMapLayerModeResolver(),
    );
    final mode = modeResolver.resolveMapLayerMode(
      earthquake: earthquake,
      config: config,
    );
    if (mode == EarthquakeHistoryMapLayerMode.station ||
        mode == EarthquakeHistoryMapLayerMode.none) {
      return const SizedBox.shrink();
    }

    final styleController = MapController.maybeOf(context)?.style;
    final jmaMapAsync = ref.watch(jmaMapProvider);
    final cachedBytes = ref.watch(intensityIconProvider).value;

    if (styleController == null) {
      return const SizedBox.shrink();
    }

    useEffect(
      () {
        final jmaMap = jmaMapAsync.value;
        if (jmaMap == null || cachedBytes == null) {
          return null;
        }

        final addedSourceIds = <String>[];
        final addedLayerIds = <String>[];
        var disposed = false;

        unawaited(() async {
          try {
            await styleController.addImages(cachedBytes.toMapStyleImages);

            if (modeResolver.showsRegionIcon(mode)) {
              final regionGeoJson = _buildRegionGeoJson(jmaMap);
              if (regionGeoJson != null && !disposed) {
                await styleController.addSource(
                  GeoJsonSource(id: _regionSourceId, data: regionGeoJson),
                );
                addedSourceIds.add(_regionSourceId);

                if (!disposed) {
                  await styleController.addLayer(
                    SymbolStyleLayer(
                      id: _regionLayerId,
                      sourceId: _regionSourceId,
                      layout: {
                        'icon-image': ['get', 'iconImage'],
                        'icon-allow-overlap': false,
                        'icon-size': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          4,
                          0.18,
                          8,
                          0.35,
                        ],
                        'symbol-sort-key': ['get', 'sortKey'],
                      },
                      paint: {
                        'icon-opacity': modeResolver.regionIconOpacity(
                          mode: mode,
                          zoomThresholds: zoomThresholds,
                        ),
                      },
                    ),
                  );
                  addedLayerIds.add(_regionLayerId);
                }
              }
            }

            if (modeResolver.showsCityIcon(mode)) {
              final cityGeoJson = _buildCityGeoJson(jmaMap);
              if (cityGeoJson != null && !disposed) {
                await styleController.addSource(
                  GeoJsonSource(id: _citySourceId, data: cityGeoJson),
                );
                addedSourceIds.add(_citySourceId);

                if (!disposed) {
                  await styleController.addLayer(
                    SymbolStyleLayer(
                      id: _cityLayerId,
                      sourceId: _citySourceId,
                      layout: {
                        'icon-image': ['get', 'iconImage'],
                        'icon-allow-overlap': false,
                        'icon-size': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          8,
                          0.12,
                          12,
                          0.5,
                        ],
                        'symbol-sort-key': ['get', 'sortKey'],
                      },
                      paint: {
                        'icon-opacity': modeResolver.cityIconOpacity(
                          mode: mode,
                          zoomThresholds: zoomThresholds,
                        ),
                      },
                    ),
                  );
                  addedLayerIds.add(_cityLayerId);
                }
              }
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () {
          disposed = true;
          unawaited(() async {
            for (final id in addedLayerIds.reversed) {
              try {
                await styleController.removeLayer(id);
              } on Exception catch (e) {
                talker.log(e);
              }
            }
            for (final id in addedSourceIds.reversed) {
              try {
                await styleController.removeSource(id);
              } on Exception catch (e) {
                talker.log(e);
              }
            }
          }());
        };
      },
      [
        styleController,
        intensity,
        cachedBytes,
        jmaMapAsync,
        config.showingLpgmIntensity,
        mode,
        zoomThresholds,
        modeResolver,
      ],
    );

    return const SizedBox.shrink();
  }

  String? _buildRegionGeoJson(
    Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
  ) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return null;
    }

    final regionMapData = jmaMap.areaForecastLocalE;
    final polylabels = <String, JmaMap_LatLng>{};
    for (final item in regionMapData.data) {
      if (item.hasPolylabel()) {
        polylabels[item.property.code] = item.polylabel;
      }
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.regions.entries) {
      final jmaIntensity = entry.key;
      final iconImage =
          'JmaIntensity.${IntensityIconType.filled.name}.${jmaIntensity.name}';
      for (final region in entry.value) {
        final polylabel = polylabels[region.region.code];
        if (polylabel == null) {
          continue;
        }
        features.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [polylabel.lng, polylabel.lat],
          },
          'properties': {
            'iconImage': iconImage,
            'sortKey': jmaIntensity.orderIndex,
          },
        });
      }
    }

    if (features.isEmpty) {
      return null;
    }
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String? _buildCityGeoJson(
    Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
  ) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return null;
    }

    final cityMapData = jmaMap.areaInformationCity;
    final polylabels = <String, JmaMap_LatLng>{};
    for (final item in cityMapData.data) {
      if (item.hasPolylabel()) {
        polylabels[item.property.code] = item.polylabel;
      }
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.intensityTree.entries) {
      final jmaIntensity = entry.key;
      final iconImage =
          'JmaIntensity.${IntensityIconType.filled.name}.${jmaIntensity.name}';
      for (final prefecture in entry.value) {
        for (final city in prefecture.cities) {
          if (city.maxIntensity == null) {
            continue;
          }
          final polylabel = polylabels[city.city.code];
          if (polylabel == null) {
            continue;
          }
          features.add({
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [polylabel.lng, polylabel.lat],
            },
            'properties': {
              'iconImage': iconImage,
              'sortKey': jmaIntensity.orderIndex,
            },
          });
        }
      }
    }

    if (features.isEmpty) {
      return null;
    }
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
