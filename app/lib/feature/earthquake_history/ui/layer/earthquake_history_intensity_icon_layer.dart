import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
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

  static const _regionSourceId = 'eq-history-icon-region';
  static const _regionLayerId = 'eq-history-icon-region-symbol';
  static const _citySourceId = 'eq-history-icon-city';
  static const _cityLayerId = 'eq-history-icon-city-symbol';

  static const _iconSize = 32;

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
    final colorModel = ref.watch(intensityColorProvider);
    final jmaMapAsync = ref.watch(jmaMapProvider);

    if (styleController == null) {
      return const SizedBox.shrink();
    }

    useEffect(
      () {
        final jmaMap = jmaMapAsync.value;
        if (jmaMap == null) {
          return null;
        }

        unawaited(() async {
          try {
            await _registerIcons(styleController, colorModel);

            if (modeResolver.showsRegionIcon(mode)) {
              final regionGeoJson = _buildRegionGeoJson(
                intensity,
                jmaMap,
                colorModel,
              );
              await styleController.addSource(
                GeoJsonSource(id: _regionSourceId, data: regionGeoJson),
              );
              await styleController.addLayer(
                SymbolStyleLayer(
                  id: _regionLayerId,
                  sourceId: _regionSourceId,
                  layout: const {
                    'icon-image': ['get', 'icon'],
                    'icon-allow-overlap': false,
                    'icon-size': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      4,
                      0.3,
                      8,
                      0.6,
                    ],
                  },
                  paint: {
                    'icon-opacity': modeResolver.regionIconOpacity(
                      mode: mode,
                      zoomThresholds: zoomThresholds,
                    ),
                  },
                ),
              );
            }

            if (modeResolver.showsCityIcon(mode)) {
              final cityGeoJson = _buildCityGeoJson(
                intensity,
                jmaMap,
                colorModel,
              );
              await styleController.addSource(
                GeoJsonSource(id: _citySourceId, data: cityGeoJson),
              );
              await styleController.addLayer(
                SymbolStyleLayer(
                  id: _cityLayerId,
                  sourceId: _citySourceId,
                  layout: const {
                    'icon-image': ['get', 'icon'],
                    'icon-allow-overlap': false,
                    'icon-size': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      8,
                      0.2,
                      12,
                      0.8,
                    ],
                  },
                  paint: {
                    'icon-opacity': modeResolver.cityIconOpacity(
                      mode: mode,
                      zoomThresholds: zoomThresholds,
                    ),
                  },
                ),
              );
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () async {
          try {
            if (modeResolver.showsCityIcon(mode)) {
              await styleController.removeLayer(_cityLayerId);
              await styleController.removeSource(_citySourceId);
            }
            if (modeResolver.showsRegionIcon(mode)) {
              await styleController.removeLayer(_regionLayerId);
              await styleController.removeSource(_regionSourceId);
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        jmaMapAsync,
        config.showingLpgmIntensity,
        mode,
        zoomThresholds,
        modeResolver,
      ],
    );

    return const SizedBox.shrink();
  }

  Future<void> _registerIcons(
    StyleController styleController,
    IntensityColorModel colorModel,
  ) async {
    if (config.showingLpgmIntensity) {
      for (final lpgm in JmaLpgmIntensity.values) {
        final iconId = _lpgmIconId(lpgm);
        final colorScheme = colorModel.fromJmaLpgmIntensity(lpgm);
        await styleController.addImageFromCanvas(
          id: iconId,
          painter: (canvas) => _paintIcon(
            canvas,
            bgColor: colorScheme.background,
            textColor: colorScheme.foreground,
            text: lpgm.label,
            size: _iconSize.toDouble(),
          ),
          width: _iconSize,
          height: _iconSize,
        );
      }
    } else {
      for (final intensity in JmaIntensity.values) {
        final iconId = _intensityIconId(intensity);
        final colorScheme = colorModel.fromJmaIntensity(intensity);
        await styleController.addImageFromCanvas(
          id: iconId,
          painter: (canvas) => _paintIcon(
            canvas,
            bgColor: colorScheme.background,
            textColor: colorScheme.foreground,
            text: intensity.label,
            size: _iconSize.toDouble(),
          ),
          width: _iconSize,
          height: _iconSize,
        );
      }
    }
  }

  static void _paintIcon(
    Canvas canvas, {
    required Color bgColor,
    required Color textColor,
    required String text,
    required double size,
  }) {
    final paint = Paint()..color = bgColor;
    final radius = size / 5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size, size),
        Radius.circular(radius),
      ),
      paint,
    );

    final paragraphBuilder =
        ui.ParagraphBuilder(
            ui.ParagraphStyle(
              textAlign: TextAlign.center,
              fontSize: size * 0.65,
              fontWeight: FontWeight.bold,
            ),
          )
          ..pushStyle(ui.TextStyle(color: textColor))
          ..addText(text);

    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size));

    canvas.drawParagraph(
      paragraph,
      Offset(0, (size - paragraph.height) / 2),
    );
  }

  String _buildRegionGeoJson(
    EarthquakeIntensity? intensity,
    Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    IntensityColorModel colorModel,
  ) {
    final features = <Map<String, dynamic>>[];
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': features});
    }

    final regionItems = jmaMap.areaForecastLocalE.data;
    final codeToPolylabel = <String, JmaMap_LatLng>{
      for (final item in regionItems)
        if (item.hasPolylabel()) item.property.code: item.polylabel,
    };

    if (config.showingLpgmIntensity) {
      for (final regions in intensity.lpgmIntensityTree.values) {
        for (final region in regions) {
          final lpgm = region.maxLpgmIntensity;
          if (lpgm == null) {
            continue;
          }
          final polylabel = codeToPolylabel[region.region.code];
          if (polylabel == null) {
            continue;
          }
          features.add({
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [polylabel.lng, polylabel.lat],
            },
            'properties': {'icon': _lpgmIconId(lpgm)},
          });
        }
      }
    } else {
      for (final entry in intensity.regions.entries) {
        for (final region in entry.value) {
          final maxIntensity = region.maxIntensity;
          if (maxIntensity == null) {
            continue;
          }
          final polylabel = codeToPolylabel[region.region.code];
          if (polylabel == null) {
            continue;
          }
          features.add({
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [polylabel.lng, polylabel.lat],
            },
            'properties': {'icon': _intensityIconId(maxIntensity)},
          });
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String _buildCityGeoJson(
    EarthquakeIntensity? intensity,
    Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    IntensityColorModel colorModel,
  ) {
    final features = <Map<String, dynamic>>[];
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': features});
    }

    final cityItems = jmaMap.areaInformationCity.data;
    final codeToPolylabel = <String, JmaMap_LatLng>{
      for (final item in cityItems)
        if (item.hasPolylabel()) item.property.code: item.polylabel,
    };

    if (config.showingLpgmIntensity) {
      for (final entry in intensity.lpgmIntensityTree.entries) {
        for (final region in entry.value) {
          for (final city in region.cities) {
            final lpgm = city.maxLpgmIntensity;
            if (lpgm == null) {
              continue;
            }
            final polylabel = codeToPolylabel[city.city.code];
            if (polylabel == null) {
              continue;
            }
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [polylabel.lng, polylabel.lat],
              },
              'properties': {'icon': _lpgmIconId(lpgm)},
            });
          }
        }
      }
    } else {
      for (final entry in intensity.intensityTree.entries) {
        for (final region in entry.value) {
          for (final city in region.cities) {
            final maxIntensity = city.maxIntensity;
            if (maxIntensity == null) {
              continue;
            }
            final polylabel = codeToPolylabel[city.city.code];
            if (polylabel == null) {
              continue;
            }
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [polylabel.lng, polylabel.lat],
              },
              'properties': {'icon': _intensityIconId(maxIntensity)},
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  static String _intensityIconId(JmaIntensity intensity) =>
      'eq-history-intensity-icon-${intensity.name}';

  static String _lpgmIconId(JmaLpgmIntensity lpgm) =>
      'eq-history-lpgm-icon-${lpgm.name}';
}
