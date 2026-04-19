import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の観測点震度レイヤー
///
/// [stationDisplayMode] に応じて観測点サイズを変更する。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級で色分けする。
/// [showLabel] が true の場合は観測点名ラベルを表示する。
class EarthquakeHistoryStationIntensityLayer extends HookConsumerWidget {
  const EarthquakeHistoryStationIntensityLayer({
    required this.intensity,
    this.stationDisplayMode = StationDisplayMode.maxFocused,
    this.maxIntensity,
    this.showLabel = false,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final StationDisplayMode stationDisplayMode;

  /// 全観測点中の最大震度（maxFocused モードで比較に使用）
  final JmaIntensity? maxIntensity;
  final bool showLabel;
  final bool showingLpgmIntensity;

  static const _sourceId = 'eq-history-station-intensity';
  static const _circleLayerId = 'eq-history-station-intensity-circle';
  static const _labelLayerId = 'eq-history-station-intensity-label';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        unawaited(() async {
          try {
            final geoJson = showingLpgmIntensity
                ? _buildLpgmGeoJson(intensity, colorModel)
                : _buildGeoJson(intensity, colorModel);

            await styleController.addSource(
              GeoJsonSource(id: _sourceId, data: geoJson),
            );

            await styleController.addLayer(
              CircleStyleLayer(
                id: _circleLayerId,
                sourceId: _sourceId,
                paint: {
                  'circle-radius': _buildRadiusExpression(),
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

            if (showLabel) {
              await styleController.addLayer(
                const SymbolStyleLayer(
                  id: _labelLayerId,
                  sourceId: _sourceId,
                  layout: {
                    'text-field': ['get', 'name'],
                    'text-size': 10,
                    'text-offset': [0, 1.2],
                    'text-anchor': 'top',
                    'text-allow-overlap': false,
                    'icon-allow-overlap': true,
                    'icon-ignore-placement': true,
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

        return () async {
          try {
            if (showLabel) {
              await styleController.removeLayer(_labelLayerId);
            }
            await styleController.removeLayer(_circleLayerId);
            await styleController.removeSource(_sourceId);
          } on Exception catch (e) {
            talker.log(e);
          }
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        stationDisplayMode,
        maxIntensity,
        showLabel,
        showingLpgmIntensity,
      ],
    );

    return const SizedBox.shrink();
  }

  List<Object> _buildRadiusExpression() {
    // maxFocused: focused なら大, それ以外は縮小
    // normal: すべて同サイズ
    // allMinimized: すべて縮小
    final smallRadius = [4, 1, 10, 3];
    final normalRadius = [4, 2, 10, 8];
    final largeRadius = [4, 3, 10, 10];

    switch (stationDisplayMode) {
      case StationDisplayMode.allMinimized:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          smallRadius[1],
          10,
          smallRadius[3],
        ];
      case StationDisplayMode.normal:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          normalRadius[1],
          10,
          normalRadius[3],
        ];
      case StationDisplayMode.maxFocused:
        return [
          'interpolate',
          ['linear'],
          ['zoom'],
          4,
          [
            'case',
            ['get', 'isFocused'],
            largeRadius[1],
            smallRadius[1],
          ],
          10,
          [
            'case',
            ['get', 'isFocused'],
            largeRadius[3],
            smallRadius[3],
          ],
        ];
    }
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
      final jmaIntensity = entry.key;
      final color = colorModel
          .fromJmaIntensity(jmaIntensity)
          .background
          .toHexStringRGB();
      final isFocused = maxIntensity != null && jmaIntensity == maxIntensity;

      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
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
      final lpgmIntensity = entry.key;
      final color = colorModel
          .fromJmaLpgmIntensity(lpgmIntensity)
          .background
          .toHexStringRGB();

      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
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
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
