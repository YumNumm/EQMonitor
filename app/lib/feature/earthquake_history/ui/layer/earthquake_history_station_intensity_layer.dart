import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の観測点震度レイヤー
///
/// stationDisplayMode に応じて観測点サイズを変更する。
/// showingLpgmIntensity が true の場合は長周期地震動階級で色分けする。
/// showStationLabel が true の場合は観測点名ラベルを表示する。
class EarthquakeHistoryStationIntensityLayer extends HookConsumerWidget {
  const EarthquakeHistoryStationIntensityLayer({
    required this.earthquake,
    required this.parameter,
    this.stationDisplayMode = StationDisplayMode.maxFocused,
    this.showStationLabel = false,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryMapLayerParameter parameter;
  final StationDisplayMode stationDisplayMode;
  final bool showStationLabel;
  final bool showingLpgmIntensity;

  static const _sourceId = 'eq-history-station-intensity';
  static const _circleLayerId = 'eq-history-station-intensity-circle';
  static const _iconLayerId = 'eq-history-station-intensity-icon';
  static const _labelLayerId = 'eq-history-station-intensity-label';

  static const _iconSmallPrefix = 'JmaIntensity.small.';
  static const _iconSmallNoTextPrefix = 'JmaIntensity.smallWithoutText.';
  static const _lpgmIconSmallPrefix = 'JmaLpgmIntensity.small.';
  static const _lpgmIconSmallNoTextPrefix =
      'JmaLpgmIntensity.smallWithoutText.';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final iconData = ref.watch(intensityIconProvider).value;
    final enqueue = useMapOperationQueue();

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        var disposed = false;
        var iconLayerAdded = false;

        unawaited(
          enqueue(() async {
            try {
              final geoJson = showingLpgmIntensity
                  ? _buildLpgmGeoJson(intensity, colorModel)
                  : _buildGeoJson(intensity, colorModel);

              if (disposed) {
                return;
              }
              await styleController.addSource(
                GeoJsonSource(id: _sourceId, data: geoJson),
              );

              if (disposed) {
                return;
              }

              // アイコン画像が揃っている場合はレイヤー追加前に登録する
              final cachedBytes = iconData?.toMapStyleImages;
              if (cachedBytes != null) {
                await styleController.addImages(cachedBytes);
              }

              if (disposed) {
                return;
              }
              await styleController.addLayer(
                CircleStyleLayer(
                  id: _circleLayerId,
                  sourceId: _sourceId,
                  minZoom: parameter.stationMinZoom,
                  layout: const {
                    'circle-sort-key': ['get', 'sortKey'],
                  },
                  paint: {
                    'circle-radius': switch (stationDisplayMode) {
                      StationDisplayMode.allMinimized => [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        4,
                        parameter.stationCircleRadiusMin * 2,
                        10,
                        parameter.stationCircleRadiusMax * 1.25,
                      ],
                      StationDisplayMode.normal => [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        4,
                        parameter.stationCircleRadiusMin,
                        10,
                        parameter.stationCircleRadiusMax,
                      ],
                      StationDisplayMode.maxFocused => [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        4,
                        [
                          'case',
                          ['get', 'isFocused'],
                          parameter.stationCircleRadiusMin * 1.5,
                          parameter.stationCircleRadiusMin * 0.5,
                        ],
                        10,
                        [
                          'case',
                          ['get', 'isFocused'],
                          parameter.stationCircleRadiusMax * 1.25,
                          parameter.stationCircleRadiusMax * 0.875,
                        ],
                      ],
                    },
                    'circle-color': ['get', 'color'],
                    'circle-stroke-color': '#ffffff',
                    'circle-stroke-width': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      4,
                      0.3,
                      10,
                      1.5,
                    ],
                  },
                ),
              );

              if (disposed) {
                return;
              }
              if (iconData != null) {
                await styleController.addLayer(
                  SymbolStyleLayer(
                    id: _iconLayerId,
                    sourceId: _sourceId,
                    minZoom: parameter.stationMinZoom,
                    layout: {
                      'icon-image': ['get', 'iconId'],
                      'icon-allow-overlap': true,
                      'icon-ignore-placement': true,
                      'symbol-sort-key': ['get', 'sortKey'],
                      'icon-size': [
                        'interpolate',
                        ['linear'],
                        ['zoom'],
                        3,
                        parameter.stationIconSizeMin,
                        7,
                        parameter.stationIconSizeMid,
                        20,
                        parameter.stationIconSizeMax,
                      ],
                    },
                  ),
                );
                iconLayerAdded = true;
              }

              if (disposed) {
                return;
              }
              if (showStationLabel) {
                await styleController.addLayer(
                  SymbolStyleLayer(
                    id: _labelLayerId,
                    sourceId: _sourceId,
                    minZoom: parameter.stationLabelMinZoom,
                    layout: {
                      'text-field': ['get', 'name'],
                      'text-size': 10,
                      'text-offset': [0, 1.2],
                      'text-anchor': 'top',
                      'text-allow-overlap': false,
                      'text-ignore-placement': true,
                    },
                    paint: {
                      'text-color': '#ffffff',
                      'text-halo-color': '#000000',
                      'text-halo-width': 1,
                    },
                  ),
                );
              }
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          disposed = true;
          unawaited(
            enqueue(() async {
              try {
                if (showStationLabel) {
                  await styleController.removeLayer(_labelLayerId);
                }
                if (iconLayerAdded) {
                  await styleController.removeLayer(_iconLayerId);
                }
                await styleController.removeLayer(_circleLayerId);
                await styleController.removeSource(_sourceId);
              } on Exception catch (e) {
                talker.log(e);
              }
            }),
          );
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        stationDisplayMode,
        showStationLabel,
        showingLpgmIntensity,
        parameter,
        iconData,
      ],
    );

    return const SizedBox.shrink();
  }

  /// stationDisplayMode と isFocused に応じてアイコン ID を返す。
  String _iconIdForStation(String intensityName, bool isFocused) {
    final useSmall = switch (stationDisplayMode) {
      StationDisplayMode.normal => true,
      StationDisplayMode.maxFocused => isFocused,
      StationDisplayMode.allMinimized => false,
    };
    final prefix = useSmall ? _iconSmallPrefix : _iconSmallNoTextPrefix;
    return '$prefix$intensityName';
  }

  String _lpgmIconIdForStation(String lpgmName) {
    final useSmall = stationDisplayMode != StationDisplayMode.allMinimized;
    final prefix = useSmall ? _lpgmIconSmallPrefix : _lpgmIconSmallNoTextPrefix;
    return '$prefix$lpgmName';
  }

  String _buildGeoJson(
    EarthquakeIntensity? intensity,
    IntensityColors colorModel,
  ) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final jmaIntensity = stationNode.intensity?.maxIntensity;
            if (jmaIntensity == null) {
              continue;
            }
            final color = colorModel
                .fromJmaIntensity(jmaIntensity)
                .background
                .toHexStringRGB();
            final isFocused = intensity.maxIntensity == jmaIntensity;
            final iconId = _iconIdForStation(jmaIntensity.name, isFocused);
            final station = stationNode.station;
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.location.lon, station.location.lat],
              },
              'properties': {
                'color': color,
                'name': station.name.ja,
                'isFocused': isFocused,
                'iconId': iconId,
                // 高震度が上に描画されるよう index をソートキーに使用
                'sortKey': jmaIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String _buildLpgmGeoJson(
    EarthquakeIntensity? intensity,
    IntensityColors colorModel,
  ) {
    if (intensity == null) {
      return jsonEncode({'type': 'FeatureCollection', 'features': <dynamic>[]});
    }

    final features = <Map<String, dynamic>>[];
    for (final entry in intensity.lpgmIntensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final lpgmIntensity = stationNode.intensity?.maxLpgmIntensity;
            if (lpgmIntensity == null) {
              continue;
            }
            final color = colorModel
                .fromJmaLpgmIntensity(lpgmIntensity)
                .background
                .toHexStringRGB();
            final iconId = _lpgmIconIdForStation(lpgmIntensity.name);
            final station = stationNode.station;
            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.location.lon, station.location.lat],
              },
              'properties': {
                'color': color,
                'name': station.name.ja,
                'isFocused': false,
                'iconId': iconId,
                // 高階級が上に描画されるよう index をソートキーに使用
                'sortKey': lpgmIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
