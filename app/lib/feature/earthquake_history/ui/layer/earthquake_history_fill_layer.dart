import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryFillLayer extends HookWidget {
  const EarthquakeHistoryFillLayer({
    required this.earthquake,
    required this.config,
    this.zoomThresholds = defaultEarthquakeHistoryMapLayerZoomThresholds,
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryDetailConfig config;
  final EarthquakeHistoryMapLayerZoomThresholds zoomThresholds;

  @override
  Widget build(BuildContext context) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    final modeResolver = useMemoized(
      () => const EarthquakeHistoryMapLayerModeResolver(),
    );
    final mode = modeResolver.resolveFillLayerMode(
      earthquake: earthquake,
      config: config,
    );
    if (mode == EarthquakeHistoryMapLayerMode.none ||
        mode == EarthquakeHistoryMapLayerMode.station) {
      return const SizedBox.shrink();
    }

    return _ResolvedEarthquakeHistoryFillLayer(
      intensity: intensity,
      mode: mode,
      showingLpgmIntensity: config.showingLpgmIntensity,
      zoomThresholds: zoomThresholds,
      modeResolver: modeResolver,
    );
  }
}

class _ResolvedEarthquakeHistoryFillLayer extends HookConsumerWidget {
  const _ResolvedEarthquakeHistoryFillLayer({
    required this.intensity,
    required this.mode,
    required this.showingLpgmIntensity,
    required this.zoomThresholds,
    required this.modeResolver,
  });

  final EarthquakeIntensity intensity;
  final EarthquakeHistoryMapLayerMode mode;
  final bool showingLpgmIntensity;
  final EarthquakeHistoryMapLayerZoomThresholds zoomThresholds;
  final EarthquakeHistoryMapLayerModeResolver modeResolver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(intensityColorProvider);
    final fillLayerBuilder = useMemoized(
      () => EarthquakeHistoryFillLayerBuilder(modeResolver: modeResolver),
      [modeResolver],
    );
    if (styleController == null) {
      return const SizedBox.shrink();
    }

    useEffect(
      () {
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
            final layers = fillLayerBuilder.build(
              intensity: intensity,
              colorModel: colorModel,
              mode: mode,
              showingLpgmIntensity: showingLpgmIntensity,
              zoomThresholds: zoomThresholds,
            );
            for (final layer in layers) {
              if (disposed) {
                return;
              }
              await styleController.addLayer(layer);
              addedLayerIds.add(layer.id);
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
      [
        styleController,
        intensity,
        colorModel,
        mode,
        showingLpgmIntensity,
        zoomThresholds,
        fillLayerBuilder,
      ],
    );

    return const SizedBox.shrink();
  }
}

const _regionSourceLayerId = 'areaForecastLocalE';
const _citySourceLayerId = 'areaInformationCityQuake';
const _regionFillOpacity = 0.6;
const _regionLineOpacity = 0.8;
const _cityFillOpacity = 0.6;

class EarthquakeHistoryFillLayerBuilder {
  const EarthquakeHistoryFillLayerBuilder({required this.modeResolver});

  final EarthquakeHistoryMapLayerModeResolver modeResolver;

  List<StyleLayer> build({
    required EarthquakeIntensity intensity,
    required IntensityColorModel colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required bool showingLpgmIntensity,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    if (mode == EarthquakeHistoryMapLayerMode.none ||
        mode == EarthquakeHistoryMapLayerMode.station) {
      return const [];
    }
    return showingLpgmIntensity
        ? buildLpgmLayers(
            intensity: intensity,
            colorModel: colorModel,
            mode: mode,
            zoomThresholds: zoomThresholds,
          )
        : buildJmaLayers(
            intensity: intensity,
            colorModel: colorModel,
            mode: mode,
            zoomThresholds: zoomThresholds,
          );
  }

  List<StyleLayer> buildJmaLayers({
    required EarthquakeIntensity intensity,
    required IntensityColorModel colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    final layers = <StyleLayer>[];
    final levels = sortedJmaLevels(intensity);
    if (modeResolver.showsRegionFill(mode)) {
      for (final level in levels) {
        final codes = jmaRegionCodes(intensity, level);
        if (codes.isEmpty) {
          continue;
        }
        final color = colorModel
            .fromJmaIntensity(level)
            .background
            .toHexStringRGB();
        layers.addAll(
          buildRegionLayers(
            idPrefix: 'eq-history-jma-${level.name}',
            codes: codes,
            color: color,
            mode: mode,
            zoomThresholds: zoomThresholds,
          ),
        );
      }
    }

    if (modeResolver.showsCityFill(mode)) {
      for (final level in levels) {
        final codes = jmaCityCodes(intensity, level);
        if (codes.isEmpty) {
          continue;
        }
        final color = colorModel
            .fromJmaIntensity(level)
            .background
            .toHexStringRGB();
        layers.add(
          buildCityLayer(
            idPrefix: 'eq-history-jma-${level.name}',
            codes: codes,
            color: color,
            mode: mode,
            zoomThresholds: zoomThresholds,
          ),
        );
      }
    }
    return layers;
  }

  List<StyleLayer> buildLpgmLayers({
    required EarthquakeIntensity intensity,
    required IntensityColorModel colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    final layers = <StyleLayer>[];
    final levels = sortedLpgmLevels(intensity);
    if (modeResolver.showsRegionFill(mode)) {
      for (final level in levels) {
        final codes = lpgmRegionCodes(intensity, level);
        if (codes.isEmpty) {
          continue;
        }
        final color = colorModel
            .fromJmaLpgmIntensity(level)
            .background
            .toHexStringRGB();
        layers.addAll(
          buildRegionLayers(
            idPrefix: 'eq-history-lpgm-${level.name}',
            codes: codes,
            color: color,
            mode: mode,
            zoomThresholds: zoomThresholds,
          ),
        );
      }
    }

    if (modeResolver.showsCityFill(mode)) {
      for (final level in levels) {
        final codes = lpgmCityCodes(intensity, level);
        if (codes.isEmpty) {
          continue;
        }
        final color = colorModel
            .fromJmaLpgmIntensity(level)
            .background
            .toHexStringRGB();
        layers.add(
          buildCityLayer(
            idPrefix: 'eq-history-lpgm-${level.name}',
            codes: codes,
            color: color,
            mode: mode,
            zoomThresholds: zoomThresholds,
          ),
        );
      }
    }
    return layers;
  }

  List<StyleLayer> buildRegionLayers({
    required String idPrefix,
    required List<String> codes,
    required String color,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    final fillId = '$idPrefix-region-fill';
    final lineId = '$idPrefix-region-line';
    final filter = codeFilter(codes);
    return [
      FillStyleLayer(
        id: fillId,
        sourceId: 'japan',
        sourceLayerId: _regionSourceLayerId,
        filter: filter,
        paint: {
          'fill-color': color,
          'fill-opacity': modeResolver.regionFillOpacity(
            mode: mode,
            zoomThresholds: zoomThresholds,
            visibleOpacity: _regionFillOpacity,
          ),
        },
      ),
      LineStyleLayer(
        id: lineId,
        sourceId: 'japan',
        sourceLayerId: _regionSourceLayerId,
        filter: filter,
        paint: {
          'line-color': '#ffffff',
          'line-width': 0.5,
          'line-opacity': modeResolver.regionFillOpacity(
            mode: mode,
            zoomThresholds: zoomThresholds,
            visibleOpacity: _regionLineOpacity,
          ),
        },
      ),
    ];
  }

  StyleLayer buildCityLayer({
    required String idPrefix,
    required List<String> codes,
    required String color,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerZoomThresholds zoomThresholds,
  }) {
    return FillStyleLayer(
      id: '$idPrefix-city-fill',
      sourceId: 'japan',
      sourceLayerId: _citySourceLayerId,
      filter: codeFilter(codes),
      paint: {
        'fill-color': color,
        'fill-opacity': modeResolver.cityFillOpacity(
          mode: mode,
          zoomThresholds: zoomThresholds,
          visibleOpacity: _cityFillOpacity,
        ),
      },
    );
  }

  List<Object> codeFilter(List<String> codes) => [
    'in',
    ['get', 'code'],
    ['literal', codes],
  ];

  List<JmaIntensity> sortedJmaLevels(EarthquakeIntensity intensity) {
    final levels = <JmaIntensity>{};
    for (final entry in intensity.regions.entries) {
      for (final region in entry.value) {
        if (region.maxIntensity != null) {
          levels.add(entry.key);
          break;
        }
      }
    }
    for (final entry in intensity.intensityTree.entries) {
      for (final prefecture in entry.value) {
        for (final city in prefecture.cities) {
          if (city.maxIntensity != null) {
            levels.add(entry.key);
            break;
          }
        }
      }
    }
    return levels.toList()
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  }

  List<String> jmaRegionCodes(
    EarthquakeIntensity intensity,
    JmaIntensity intensityLevel,
  ) {
    final codes = <String>[];
    final nodes = intensity.regions[intensityLevel];
    if (nodes == null) {
      return codes;
    }
    for (final region in nodes) {
      if (region.maxIntensity == intensityLevel) {
        codes.add(region.region.code);
      }
    }
    return codes;
  }

  List<String> jmaCityCodes(
    EarthquakeIntensity intensity,
    JmaIntensity intensityLevel,
  ) {
    final codes = <String>[];
    final nodes = intensity.intensityTree[intensityLevel];
    if (nodes == null) {
      return codes;
    }
    for (final region in nodes) {
      for (final city in region.cities) {
        if (city.maxIntensity != null) {
          codes.add(city.city.code);
        }
      }
    }
    return codes;
  }

  List<JmaLpgmIntensity> sortedLpgmLevels(EarthquakeIntensity intensity) {
    final levels = <JmaLpgmIntensity>{};
    for (final entry in intensity.lpgmIntensityTree.entries) {
      for (final region in entry.value) {
        final maxIntensity = region.maxLpgmIntensity;
        if (maxIntensity != null) {
          levels.add(maxIntensity);
        }
        for (final city in region.cities) {
          if (city.maxLpgmIntensity != null) {
            levels.add(entry.key);
            break;
          }
        }
      }
    }
    return levels.toList()
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
  }

  List<String> lpgmRegionCodes(
    EarthquakeIntensity intensity,
    JmaLpgmIntensity intensityLevel,
  ) {
    final codes = <String>[];
    final nodes = intensity.lpgmIntensityTree[intensityLevel];
    if (nodes == null) {
      return codes;
    }
    for (final region in nodes) {
      if (region.maxLpgmIntensity == intensityLevel) {
        codes.add(region.region.code);
      }
    }
    return codes;
  }

  List<String> lpgmCityCodes(
    EarthquakeIntensity intensity,
    JmaLpgmIntensity intensityLevel,
  ) {
    final codes = <String>[];
    final nodes = intensity.lpgmIntensityTree[intensityLevel];
    if (nodes == null) {
      return codes;
    }
    for (final region in nodes) {
      for (final city in region.cities) {
        if (city.maxLpgmIntensity != null) {
          codes.add(city.city.code);
        }
      }
    }
    return codes;
  }
}
