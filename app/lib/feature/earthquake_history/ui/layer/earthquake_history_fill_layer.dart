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
///
/// 震度（階級）ごとに Fill / Line レイヤーを分け、地物の `code` に対する `in` フィルタで描画対象を絞る。
class EarthquakeHistoryFillLayer extends HookConsumerWidget {
  const EarthquakeHistoryFillLayer({
    required this.intensity,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final EarthquakeIntensity intensity;
  final bool showingLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);

    useEffect(
      () {
        if (styleController == null) {
          return null;
        }

        final addedLayerIds = <String>[];
        var disposed = false;

        Future<void> removeAdded() async {
          for (final id in addedLayerIds.reversed) {
            try {
              await styleController.removeLayer(id);
            } on Exception catch (e) {
              talker.log(e);
            }
          }
        }

        unawaited(() async {
          try {
            final specs = showingLpgmIntensity
                ? _buildLpgmLayerSpecs(intensity, colorModel)
                : _buildJmaLayerSpecs(intensity, colorModel);
            for (final spec in specs) {
              if (disposed) {
                return;
              }
              await styleController.addLayer(spec.layer);
              addedLayerIds.add(spec.id);
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }());

        return () {
          disposed = true;
          unawaited(removeAdded());
        };
      },
      [styleController, intensity, colorModel, showingLpgmIntensity],
    );

    return const SizedBox.shrink();
  }
}

List<Object> _codeInFilter(List<String> codes) => <Object>[
  'in',
  <Object>['get', 'code'],
  <Object>['literal', codes],
];

List<JmaIntensity> _sortedJmaLevels(EarthquakeIntensity? intensity) {
  final set = <JmaIntensity>{};
  for (final r in intensity?.regions ?? const <IntensityRegion>[]) {
    final m = r.maxIntensity;
    if (m != null) {
      set.add(m);
    }
  }
  for (final e
      in intensity?.intensityTree.entries ??
          const <MapEntry<JmaIntensity, List<RegionIntensityNode>>>[]) {
    for (final region in e.value) {
      for (final city in region.cities) {
        if (city.maxIntensity != null) {
          set.add(e.key);
          break;
        }
      }
    }
  }
  final list = set.toList()
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  return list;
}

List<String> _jmaRegionCodes(EarthquakeIntensity? intensity, JmaIntensity j) {
  final out = <String>[];
  for (final r in intensity?.regions ?? const <IntensityRegion>[]) {
    if (r.maxIntensity == j) {
      out.add(r.region.code);
    }
  }
  return out;
}

List<String> _jmaCityCodes(EarthquakeIntensity? intensity, JmaIntensity j) {
  final out = <String>[];
  final nodes = intensity?.intensityTree[j];
  if (nodes == null) {
    return out;
  }
  for (final region in nodes) {
    for (final city in region.cities) {
      if (city.maxIntensity != null) {
        out.add(city.city.code);
      }
    }
  }
  return out;
}

List<JmaLpgmIntensity> _sortedLpgmLevels(EarthquakeIntensity? intensity) {
  final set = <JmaLpgmIntensity>{};
  for (final r in intensity?.lpgmRegions ?? const <LpgmIntensityRegion>[]) {
    final m = r.maxLpgmIntensity;
    if (m != null) {
      set.add(m);
    }
  }
  for (final e
      in intensity?.lpgmIntensityTree.entries ??
          const <MapEntry<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>>[]) {
    for (final region in e.value) {
      for (final city in region.cities) {
        if (city.maxLpgmIntensity != null) {
          set.add(e.key);
          break;
        }
      }
    }
  }
  final list = set.toList()
    ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  return list;
}

List<String> _lpgmRegionCodes(
  EarthquakeIntensity? intensity,
  JmaLpgmIntensity j,
) {
  final out = <String>[];
  for (final r in intensity?.lpgmRegions ?? const <LpgmIntensityRegion>[]) {
    if (r.maxLpgmIntensity == j) {
      out.add(r.region.code);
    }
  }
  return out;
}

List<String> _lpgmCityCodes(
  EarthquakeIntensity? intensity,
  JmaLpgmIntensity j,
) {
  final out = <String>[];
  final nodes = intensity?.lpgmIntensityTree[j];
  if (nodes == null) {
    return out;
  }
  for (final region in nodes) {
    for (final city in region.cities) {
      if (city.maxLpgmIntensity != null) {
        out.add(city.city.code);
      }
    }
  }
  return out;
}

class _LayerSpec {
  const _LayerSpec({required this.id, required this.layer});

  final String id;
  final StyleLayer layer;
}

List<_LayerSpec> _buildJmaLayerSpecs(
  EarthquakeIntensity? intensity,
  IntensityColorModel colorModel,
) {
  final specs = <_LayerSpec>[];
  final levels = _sortedJmaLevels(intensity);
  for (final j in levels) {
    final regionCodes = _jmaRegionCodes(intensity, j);
    if (regionCodes.isEmpty) {
      continue;
    }
    final filter = _codeInFilter(regionCodes);
    final color = colorModel.fromJmaIntensity(j).background.toHexStringRGB();
    final fillId = 'eq-history-jma-${j.name}-region-fill';
    final lineId = 'eq-history-jma-${j.name}-region-line';
    specs.add(
      _LayerSpec(
        id: fillId,
        layer: FillStyleLayer(
          id: fillId,
          sourceId: 'japan',
          sourceLayerId: 'areaForecastLocalE',
          filter: filter,
          paint: {
            'fill-color': color,
            'fill-opacity': [
              'step',
              ['zoom'],
              8,
              0.6,
              9,
              0.0,
            ],
          },
        ),
      ),
    );
    specs.add(
      _LayerSpec(
        id: lineId,
        layer: LineStyleLayer(
          id: lineId,
          sourceId: 'japan',
          sourceLayerId: 'areaForecastLocalE',
          filter: filter,
          paint: {
            'line-color': '#ffffff',
            'line-width': 0.5,
            'line-opacity': <Object>[
              'interpolate',
              <Object>['linear'],
              <Object>['zoom'],
              8.0,
              0.8,
              9.0,
              0.0,
            ],
          },
        ),
      ),
    );
  }
  for (final j in levels) {
    final cityCodes = _jmaCityCodes(intensity, j);
    if (cityCodes.isEmpty) {
      continue;
    }
    final filter = _codeInFilter(cityCodes);
    final color = colorModel.fromJmaIntensity(j).background.toHexStringRGB();
    final fillId = 'eq-history-jma-${j.name}-city-fill';
    specs.add(
      _LayerSpec(
        id: fillId,
        layer: FillStyleLayer(
          id: fillId,
          sourceId: 'japan',
          sourceLayerId: 'areaInformationCity',
          filter: filter,
          paint: {
            'fill-color': color,
            'fill-opacity': [
              'step',
              ['zoom'],
              8,
              0.0,
              9,
              0.6,
            ],
          },
        ),
      ),
    );
  }
  return specs;
}

List<_LayerSpec> _buildLpgmLayerSpecs(
  EarthquakeIntensity? intensity,
  IntensityColorModel colorModel,
) {
  final specs = <_LayerSpec>[];
  final levels = _sortedLpgmLevels(intensity);
  for (final j in levels) {
    final regionCodes = _lpgmRegionCodes(intensity, j);
    if (regionCodes.isEmpty) {
      continue;
    }
    final filter = _codeInFilter(regionCodes);
    final color = colorModel
        .fromJmaLpgmIntensity(j)
        .background
        .toHexStringRGB();
    final fillId = 'eq-history-lpgm-${j.name}-region-fill';
    final lineId = 'eq-history-lpgm-${j.name}-region-line';
    specs.add(
      _LayerSpec(
        id: fillId,
        layer: FillStyleLayer(
          id: fillId,
          sourceId: 'japan',
          sourceLayerId: 'areaForecastLocalE',
          filter: filter,
          paint: {
            'fill-color': color,
            'fill-opacity': <Object>[
              'interpolate',
              <Object>['linear'],
              <Object>['zoom'],
              8.0,
              0.6,
              9.0,
              0.0,
            ],
          },
        ),
      ),
    );
    specs.add(
      _LayerSpec(
        id: lineId,
        layer: LineStyleLayer(
          id: lineId,
          sourceId: 'japan',
          sourceLayerId: 'areaForecastLocalE',
          filter: filter,
          paint: {
            'line-color': '#ffffff',
            'line-width': 0.5,
            'line-opacity': <Object>[
              'interpolate',
              <Object>['linear'],
              <Object>['zoom'],
              8.0,
              0.8,
              9.0,
              0.0,
            ],
          },
        ),
      ),
    );
  }
  for (final j in levels) {
    final cityCodes = _lpgmCityCodes(intensity, j);
    if (cityCodes.isEmpty) {
      continue;
    }
    final filter = _codeInFilter(cityCodes);
    final color = colorModel
        .fromJmaLpgmIntensity(j)
        .background
        .toHexStringRGB();
    final fillId = 'eq-history-lpgm-${j.name}-city-fill';
    specs.add(
      _LayerSpec(
        id: fillId,
        layer: FillStyleLayer(
          id: fillId,
          sourceId: 'japan',
          sourceLayerId: 'areaInformationCity',
          filter: filter,
          paint: {
            'fill-color': color,
            'fill-opacity': [
              'step',
              ['zoom'],
              8,
              0.0,
              9,
              0.6,
            ],
          },
        ),
      ),
    );
  }
  return specs;
}
