import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/data/provider/map_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryFillLayer extends HookConsumerWidget {
  const EarthquakeHistoryFillLayer({
    required this.earthquake,
    required this.parameter,
    required this.enqueue,
    this.fillMode = EarthquakeHistoryFillMode.auto,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryMapLayerParameter parameter;
  final MapOperationScheduler enqueue;
  final EarthquakeHistoryFillMode fillMode;
  final bool showingLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;

    final modeResolver = useMemoized(
      () => const EarthquakeHistoryMapLayerModeResolver(),
    );
    final mode = modeResolver.resolveFillLayerMode(
      earthquake: earthquake,
      fillMode: fillMode,
      showingLpgmIntensity: showingLpgmIntensity,
    );

    final styleController = MapController.maybeOf(context)?.style;
    final colorSet = ref.watch(activeColorSetProvider);
    final colorModel = colorSet.intensity;
    final fillLayerBuilder = useMemoized(
      () => EarthquakeHistoryFillLayerBuilder(modeResolver: modeResolver),
      [modeResolver],
    );

    final isInitialized = useRef(false);
    final addedLayerIds = useRef(<String>[]);
    final latestParameter = useRef(parameter);
    latestParameter.value = parameter;
    final latestIntensity = useRef(intensity);
    latestIntensity.value = intensity;
    final latestColorModel = useRef(colorModel);
    latestColorModel.value = colorModel;
    final latestMode = useRef(mode);
    latestMode.value = mode;
    final latestShowingLpgmIntensity = useRef(showingLpgmIntensity);
    latestShowingLpgmIntensity.value = showingLpgmIntensity;

    final shouldShowLayers =
        intensity != null &&
        mode != EarthquakeHistoryMapLayerMode.none &&
        mode != EarthquakeHistoryMapLayerMode.station;

    useEffect(
      () {
        if (styleController == null ||
            intensity == null ||
            mode == EarthquakeHistoryMapLayerMode.none ||
            mode == EarthquakeHistoryMapLayerMode.station) {
          return null;
        }

        unawaited(
          enqueue(() async {
            try {
              final layers = fillLayerBuilder.build(
                intensity: intensity,
                colorModel: colorModel,
                mode: mode,
                showingLpgmIntensity: showingLpgmIntensity,
                parameter: latestParameter.value,
              );
              final newIds = <String>[];
              for (final layer in layers) {
                await styleController.addLayer(
                  layer,
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
                newIds.add(layer.id);
              }
              addedLayerIds.value = newIds;
              isInitialized.value = true;
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          isInitialized.value = false;
          unawaited(
            enqueue(() async {
              for (final id in addedLayerIds.value.reversed) {
                try {
                  await styleController.removeLayer(id);
                } on Exception catch (e) {
                  talker.log(e);
                }
              }
              addedLayerIds.value = [];
            }),
          );
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        mode,
        showingLpgmIntensity,
        fillLayerBuilder,
        enqueue,
      ],
    );

    useEffect(
      () {
        final currentMode = latestMode.value;
        final shouldShow =
            latestIntensity.value != null &&
            currentMode != EarthquakeHistoryMapLayerMode.none &&
            currentMode != EarthquakeHistoryMapLayerMode.station;
        if (styleController == null || !isInitialized.value || !shouldShow) {
          return null;
        }

        final currentIntensity = latestIntensity.value;
        if (currentIntensity == null) {
          return null;
        }

        unawaited(
          enqueue(() async {
            for (final id in addedLayerIds.value.reversed) {
              try {
                await styleController.removeLayer(id);
              } on Exception catch (e) {
                talker.log(e);
              }
            }

            final newIds = <String>[];
            try {
              final layers = fillLayerBuilder.build(
                intensity: currentIntensity,
                colorModel: latestColorModel.value,
                mode: currentMode,
                showingLpgmIntensity: latestShowingLpgmIntensity.value,
                parameter: parameter,
              );
              for (final layer in layers) {
                await styleController.addLayer(
                  layer,
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
                newIds.add(layer.id);
              }
            } on Exception catch (e) {
              talker.log(e);
            }
            addedLayerIds.value = newIds;
          }),
        );

        return null;
      },
      [styleController, parameter, enqueue],
    );

    if (!shouldShowLayers || styleController == null) {
      return const SizedBox.shrink();
    }

    return const SizedBox.shrink();
  }
}

const _regionSourceLayerId = 'areaForecastLocalE';
const _citySourceLayerId = 'areaInformationCityQuake';

class EarthquakeHistoryFillLayerBuilder {
  const EarthquakeHistoryFillLayerBuilder({required this.modeResolver});

  final EarthquakeHistoryMapLayerModeResolver modeResolver;

  List<StyleLayer> build({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required bool showingLpgmIntensity,
    required EarthquakeHistoryMapLayerParameter parameter,
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
            parameter: parameter,
          )
        : buildJmaLayers(
            intensity: intensity,
            colorModel: colorModel,
            mode: mode,
            parameter: parameter,
          );
  }

  List<StyleLayer> buildJmaLayers({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerParameter parameter,
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
            parameter: parameter,
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
            parameter: parameter,
          ),
        );
      }
    }
    return layers;
  }

  List<StyleLayer> buildLpgmLayers({
    required EarthquakeIntensity intensity,
    required IntensityColors colorModel,
    required EarthquakeHistoryMapLayerMode mode,
    required EarthquakeHistoryMapLayerParameter parameter,
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
            parameter: parameter,
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
            parameter: parameter,
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
    required EarthquakeHistoryMapLayerParameter parameter,
  }) {
    final fillId = '$idPrefix-region-fill';
    final lineId = '$idPrefix-region-line';
    final filter = regionCodeFilter(codes);
    return [
      FillStyleLayer(
        id: fillId,
        sourceId: 'eqmonitor_map',
        sourceLayerId: _regionSourceLayerId,
        filter: filter,
        paint: {
          'fill-color': color,
          'fill-opacity': modeResolver.regionFillOpacity(
            mode: mode,
            regionToCity: parameter.regionToCity,
            visibleOpacity: parameter.regionFillOpacity,
          ),
        },
      ),
      LineStyleLayer(
        id: lineId,
        sourceId: 'eqmonitor_map',
        sourceLayerId: _regionSourceLayerId,
        filter: filter,
        paint: {
          'line-color': '#ffffff',
          'line-width': 0.5,
          'line-opacity': modeResolver.regionFillOpacity(
            mode: mode,
            regionToCity: parameter.regionToCity,
            visibleOpacity: parameter.regionLineOpacity,
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
    required EarthquakeHistoryMapLayerParameter parameter,
  }) {
    return FillStyleLayer(
      id: '$idPrefix-city-fill',
      sourceId: 'eqmonitor_map',
      sourceLayerId: _citySourceLayerId,
      filter: cityCodeFilter(codes),
      paint: {
        'fill-color': color,
        'fill-opacity': modeResolver.cityFillOpacity(
          mode: mode,
          regionToCity: parameter.regionToCity,
          visibleOpacity: parameter.cityFillOpacity,
        ),
      },
    );
  }

  List<Object> regionCodeFilter(List<String> codes) => [
    'in',
    ['get', 'code'],
    ['literal', codes],
  ];

  List<Object> cityCodeFilter(List<String> codes) => [
    'in',
    ['get', 'regioncode'],
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
