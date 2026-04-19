import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細の震度塗りつぶしレイヤー
///
/// zoom < 9 で一次細分化地域（areaForecastLocalE）、zoom >= 9 で市区町村
/// （areaInformationCity）をフェードして切り替える。
/// [showingLpgmIntensity] が true の場合は長周期地震動階級で塗り分ける。
class EarthquakeHistoryFillLayer extends HookConsumerWidget {
  const EarthquakeHistoryFillLayer({
    required this.intensity,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final EarthquakeIntensity? intensity;
  final bool showingLpgmIntensity;

  static const _regionFillId = 'eq-history-fill-region';
  static const _regionLineId = 'eq-history-fill-region-line';
  static const _cityFillId = 'eq-history-fill-city';
  static const _cityLineId = 'eq-history-fill-city-line';

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
            final regionColor = showingLpgmIntensity
                ? _buildLpgmRegionColorExpression(intensity, colorModel)
                : _buildRegionColorExpression(intensity, colorModel);
            final cityColor = showingLpgmIntensity
                ? _buildLpgmCityColorExpression(intensity, colorModel)
                : _buildCityColorExpression(intensity, colorModel);

            // 一次細分化地域: zoom 8 で不透明、zoom 9 で透明
            await styleController.addLayer(
              FillStyleLayer(
                id: _regionFillId,
                sourceId: 'japan',
                sourceLayerId: 'areaForecastLocalE',
                paint: {
                  'fill-color': regionColor,
                  'fill-opacity': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    8.0,
                    0.6,
                    9.0,
                    0.0,
                  ],
                },
              ),
            );

            await styleController.addLayer(
              LineStyleLayer(
                id: _regionLineId,
                sourceId: 'japan',
                sourceLayerId: 'areaForecastLocalE',
                paint: {
                  'line-color': '#ffffff',
                  'line-width': 0.5,
                  'line-opacity': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    8.0,
                    0.8,
                    9.0,
                    0.0,
                  ],
                },
              ),
            );

            // 市区町村: zoom 8 で透明、zoom 9 で不透明
            await styleController.addLayer(
              FillStyleLayer(
                id: _cityFillId,
                sourceId: 'japan',
                sourceLayerId: 'areaInformationCity',
                paint: {
                  'fill-color': cityColor,
                  'fill-opacity': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    8.0,
                    0.0,
                    9.0,
                    0.6,
                  ],
                },
              ),
            );

            await styleController.addLayer(
              LineStyleLayer(
                id: _cityLineId,
                sourceId: 'japan',
                sourceLayerId: 'areaInformationCity',
                paint: {
                  'line-color': '#ffffff',
                  'line-width': 0.3,
                  'line-opacity': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    8.0,
                    0.0,
                    9.0,
                    0.5,
                  ],
                },
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () async {
          try {
            await styleController.removeLayer(_cityLineId);
            await styleController.removeLayer(_cityFillId);
            await styleController.removeLayer(_regionLineId);
            await styleController.removeLayer(_regionFillId);
          } on Exception catch (e) {
            talker.log(e);
          }
        };
      },
      [styleController, intensity, colorModel, showingLpgmIntensity],
    );

    return const SizedBox.shrink();
  }

  List<Object> _buildRegionColorExpression(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    final args = <Object>[
      'match',
      <Object>['get', 'code'],
    ];
    for (final region in intensity?.regions ?? <IntensityRegion>[]) {
      final maxIntensity = region.maxIntensity;
      if (maxIntensity == null) continue;
      args
        ..add(region.region.code)
        ..add(colorModel.fromJmaIntensity(maxIntensity).background.toHexStringRGB());
    }
    args.add('rgba(0,0,0,0)');
    return args;
  }

  List<Object> _buildCityColorExpression(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    final args = <Object>[
      'match',
      <Object>['get', 'code'],
    ];
    for (final entry in intensity?.intensityTree.entries ??
        <MapEntry<JmaIntensity, List<RegionIntensityNode>>>[]) {
      final color = colorModel.fromJmaIntensity(entry.key).background.toHexStringRGB();
      for (final region in entry.value) {
        for (final city in region.cities) {
          final maxIntensity = city.maxIntensity;
          if (maxIntensity == null) continue;
          args
            ..add(city.city.code)
            ..add(color);
        }
      }
    }
    args.add('rgba(0,0,0,0)');
    return args;
  }

  List<Object> _buildLpgmRegionColorExpression(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    final args = <Object>[
      'match',
      <Object>['get', 'code'],
    ];
    for (final region in intensity?.lpgmRegions ?? <LpgmIntensityRegion>[]) {
      final maxIntensity = region.maxLpgmIntensity;
      if (maxIntensity == null) continue;
      args
        ..add(region.region.code)
        ..add(colorModel.fromJmaLpgmIntensity(maxIntensity).background.toHexStringRGB());
    }
    args.add('rgba(0,0,0,0)');
    return args;
  }

  List<Object> _buildLpgmCityColorExpression(
    EarthquakeIntensity? intensity,
    IntensityColorModel colorModel,
  ) {
    final args = <Object>[
      'match',
      <Object>['get', 'code'],
    ];
    for (final entry in intensity?.lpgmIntensityTree.entries ??
        <MapEntry<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>>[]) {
      final color = colorModel
          .fromJmaLpgmIntensity(entry.key)
          .background
          .toHexStringRGB();
      for (final region in entry.value) {
        for (final city in region.cities) {
          final maxIntensity = city.maxLpgmIntensity;
          if (maxIntensity == null) continue;
          args
            ..add(city.city.code)
            ..add(color);
        }
      }
    }
    args.add('rgba(0,0,0,0)');
    return args;
  }
}
