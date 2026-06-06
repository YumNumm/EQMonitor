import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
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

        unawaited(() async {
          try {
            await styleController.addImages(cachedBytes.toMapStyleImages);

            if (modeResolver.showsRegionIcon(mode)) {
              for (final intensity in JmaIntensity.values) {
                final codes =
                    earthquake.intensity?.regions[intensity]
                        ?.map((e) => e.region.code)
                        .toList() ??
                    const <String>[];
                final filter = codes.isEmpty
                    ? const ['==', '1', '2']
                    : [
                        'in',
                        ['get', 'code'],
                        ['literal', codes],
                      ];
                final iconImage =
                    'JmaIntensity.${IntensityIconType.filled.name}.${intensity.name}';
                await styleController.addLayer(
                  SymbolStyleLayer(
                    id: _regionLayerId(intensity),
                    sourceLayerId: 'areaForecastLocalE',
                    sourceId: 'eqmonitor_map',
                    filter: filter,
                    layout: {
                      'icon-image': iconImage,
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
            }

            if (modeResolver.showsCityIcon(mode)) {
              for (final intensity in JmaIntensity.values) {
                final codes =
                    earthquake.intensity?.intensityTree[intensity]
                        ?.expand((e) => e.cities)
                        .map((e) => e.city.code)
                        .toList() ??
                    const <String>[];
                final filter = codes.isEmpty
                    ? const ['==', '1', '2']
                    : [
                        'in',
                        ['get', 'regioncode'],
                        ['literal', codes],
                      ];
                final iconImage =
                    'JmaIntensity.${IntensityIconType.filled.name}.${intensity.name}';
                await styleController.addLayer(
                  SymbolStyleLayer(
                    id: _cityLayerId(intensity),
                    sourceLayerId: 'areaInformationCityQuake',
                    sourceId: 'eqmonitor_map',
                    filter: filter,
                    layout: {
                      'icon-image': iconImage,
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
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () async {
          for (final intensity in JmaIntensity.values) {
            try {
              await styleController.removeLayer(_cityLayerId(intensity));
            } on Exception catch (e) {
              talker.log(e);
            }
            try {
              await styleController.removeLayer(_regionLayerId(intensity));
            } on Exception catch (e) {
              talker.log(e);
            }
          }
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

  static String _regionLayerId(JmaIntensity intensity) =>
      'eq-history-icon-region-symbol-${intensity.name}';
  static String _cityLayerId(JmaIntensity intensity) =>
      'eq-history-icon-city-symbol-${intensity.name}';
}
