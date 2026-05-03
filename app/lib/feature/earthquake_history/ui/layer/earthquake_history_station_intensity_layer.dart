import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/station_intensity_icon_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の観測点震度レイヤー
///
/// [stationDisplayMode] に応じて観測点サイズを変更する。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級で色分けする。
/// [showLabel] が true の場合は観測点名ラベルを表示する。
/// [iconMode] に応じて観測点アイコンの表示方法を制御する。
/// - [EarthquakeHistoryIconMode.auto]: zoom 10→11 でフェードイン
/// - [EarthquakeHistoryIconMode.station]: minZoom 8 から常時表示
/// - それ以外: アイコン非表示（ドットのみ）
class EarthquakeHistoryStationIntensityLayer extends HookConsumerWidget {
  const EarthquakeHistoryStationIntensityLayer({
    required this.intensity,
    required this.iconMode,
    this.stationDisplayMode = StationDisplayMode.maxFocused,
    this.showLabel = false,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final EarthquakeIntensity intensity;
  final EarthquakeHistoryIconMode iconMode;
  final StationDisplayMode stationDisplayMode;

  final bool showLabel;
  final bool showingLpgmIntensity;

  static const _sourceId = 'eq-history-station-intensity';
  static const _circleLayerId = 'eq-history-station-intensity-circle';
  static const _iconLayerId = 'eq-history-station-intensity-icon';
  static const _labelLayerId = 'eq-history-station-intensity-label';

  // アイコン画像 ID（region icon の eq-history-intensity-icon- と衝突しない prefix）
  static const _iconSmallPrefix = 'eq-station-sm-';
  static const _iconSmallNoTextPrefix = 'eq-station-sm-nt-';
  static const _lpgmIconSmallPrefix = 'eq-station-lpgm-sm-';
  static const _lpgmIconSmallNoTextPrefix = 'eq-station-lpgm-sm-nt-';

  bool get _showIcon =>
      iconMode == EarthquakeHistoryIconMode.auto ||
      iconMode == EarthquakeHistoryIconMode.station;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);
    final cachedBytes = ref.watch(stationIntensityIconBytesProvider);

    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        var disposed = false;

        unawaited(() async {
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
            await styleController.addLayer(
              CircleStyleLayer(
                id: _circleLayerId,
                sourceId: _sourceId,
                minZoom: 8,
                layout: const {
                  'circle-sort-key': ['get', 'sortKey'],
                },
                paint: {
                  'circle-radius': switch (stationDisplayMode) {
                    .allMinimized => [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      4,
                      4,
                      10,
                      10,
                    ],
                    .normal => [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      4,
                      2,
                      10,
                      8,
                    ],
                    .maxFocused => [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      4,
                      [
                        'case',
                        ['get', 'isFocused'],
                        3,
                        1,
                      ],
                      10,
                      [
                        'case',
                        ['get', 'isFocused'],
                        10,
                        7,
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
            if (_showIcon) {
              // auto モードはズームに応じてフェードイン、station モードは minZoom 8 から常時表示
              final iconOpacity = iconMode == EarthquakeHistoryIconMode.auto
                  ? <Object>[
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      10.0,
                      0.0,
                      11.0,
                      1.0,
                    ]
                  : 1.0;
              await styleController.addLayer(
                SymbolStyleLayer(
                  id: _iconLayerId,
                  sourceId: _sourceId,
                  minZoom: 8,
                  layout: const {
                    'icon-image': ['get', 'iconId'],
                    'icon-allow-overlap': true,
                    'icon-ignore-placement': true,
                    'symbol-sort-key': ['get', 'sortKey'],
                    'icon-size': [
                      'interpolate',
                      ['linear'],
                      ['zoom'],
                      3,
                      0.04,
                      7,
                      0.3,
                      20,
                      1.0,
                    ],
                  },
                  paint: {'icon-opacity': iconOpacity},
                ),
              );
            }

            if (disposed) {
              return;
            }
            if (showLabel) {
              await styleController.addLayer(
                const SymbolStyleLayer(
                  id: _labelLayerId,
                  sourceId: _sourceId,
                  minZoom: 9,
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
        }());

        return () {
          disposed = true;
          unawaited(() async {
            try {
              if (showLabel) {
                await styleController.removeLayer(_labelLayerId);
              }
              if (_showIcon) {
                await styleController.removeLayer(_iconLayerId);
              }
              await styleController.removeLayer(_circleLayerId);
              await styleController.removeSource(_sourceId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }());
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        stationDisplayMode,
        showLabel,
        showingLpgmIntensity,
        iconMode,
        pixelRatio,
      ],
    );

    // cachedBytes を別 effect で監視し、画像が揃ったタイミングで追加する。
    // メインの effect とは分離することで、アイコンキャッシュの更新が
    // source/layer の再構築を引き起こす race condition を防ぐ。
    useEffect(() {
      if (styleController == null || cachedBytes.isEmpty) {
        return null;
      }
      unawaited(() async {
        try {
          await styleController.addImages(cachedBytes);
        } on Exception catch (e) {
          talker.log(e);
        }
      }());
      return null;
    }, [styleController, cachedBytes]);

    return const SizedBox.shrink();
  }

  /// [stationDisplayMode] と [isFocused] に応じてアイコン ID を返す。
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
    IntensityColorModel colorModel,
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
            if (!station.hasLatitude() || !station.hasLongitude()) {
              continue;
            }

            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.longitude, station.latitude],
              },
              'properties': {
                'color': color,
                'name': station.name,
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
    IntensityColorModel colorModel,
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
            if (!station.hasLatitude() || !station.hasLongitude()) {
              continue;
            }

            features.add({
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [station.longitude, station.latitude],
              },
              'properties': {
                'color': color,
                'name': station.name,
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
