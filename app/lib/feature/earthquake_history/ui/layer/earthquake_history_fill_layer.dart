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

class EarthquakeHistoryFillLayer extends ConsumerWidget {
  const EarthquakeHistoryFillLayer({
    required this.earthquake,
    required this.parameter,
    this.fillMode = EarthquakeHistoryFillMode.auto,
    this.showingLpgmIntensity = false,
    super.key,
  });

  final Earthquake earthquake;
  final EarthquakeHistoryMapLayerParameter parameter;
  final EarthquakeHistoryFillMode fillMode;
  final bool showingLpgmIntensity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const SizedBox.shrink();
    }

    const modeResolver = EarthquakeHistoryMapLayerModeResolver();
    final mode = modeResolver.resolveFillLayerMode(
      earthquake: earthquake,
      fillMode: fillMode,
      showingLpgmIntensity: showingLpgmIntensity,
    );
    // resolveFillLayerMode は .station を返さないため、.none のみ判定する。
    if (mode == EarthquakeHistoryMapLayerMode.none) {
      return const SizedBox.shrink();
    }

    return _EarthquakeHistoryFillLayerBody(
      intensity: intensity,
      parameter: parameter,
      mode: mode,
      showingLpgmIntensity: showingLpgmIntensity,
      modeResolver: modeResolver,
    );
  }
}

class _EarthquakeHistoryFillLayerBody extends HookConsumerWidget {
  const _EarthquakeHistoryFillLayerBody({
    required this.intensity,
    required this.parameter,
    required this.mode,
    required this.showingLpgmIntensity,
    required this.modeResolver,
  });

  final EarthquakeIntensity intensity;
  final EarthquakeHistoryMapLayerParameter parameter;
  final EarthquakeHistoryMapLayerMode mode;
  final bool showingLpgmIntensity;
  final EarthquakeHistoryMapLayerModeResolver modeResolver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorSet = ref.watch(activeColorSetProvider);
    final colorModel = colorSet.intensity;
    final fillLayerBuilder = useMemoized(
      () => EarthquakeHistoryFillLayerBuilder(modeResolver: modeResolver),
      [modeResolver],
    );
    final enqueue = useMapOperationQueue();

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

        unawaited(
          enqueue(() async {
            try {
              final layers = fillLayerBuilder.build(
                intensity: intensity,
                colorModel: colorModel,
                mode: mode,
                showingLpgmIntensity: showingLpgmIntensity,
                parameter: parameter,
              );
              for (final layer in layers) {
                if (disposed) {
                  return;
                }
                await styleController.addLayer(
                  layer,
                  belowLayerId: BaseLayer.areaForecastLocalELine.name,
                );
                addedLayerIds.add(layer.id);
              }
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );

        return () {
          disposed = true;
          unawaited(enqueue(removeAdded));
        };
      },
      [
        styleController,
        intensity,
        colorModel,
        mode,
        showingLpgmIntensity,
        parameter,
        fillLayerBuilder,
      ],
    );

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
    final nodes = intensity.intensityTree[intensityLevel];
    if (nodes == null) {
      return [];
    }
    // 複数レベルの観測点を持つ市区町村は各レベルのバケツに重複して現れる。
    // 半透明 fill が重なって混色しないよう、最大レベルにのみ含める。
    final maxLevels = _cityMaxJmaLevels(intensity);
    final codes = <String>{};
    for (final region in nodes) {
      for (final city in region.cities) {
        if (city.maxIntensity != null &&
            maxLevels[city.city.code] == intensityLevel) {
          codes.add(city.city.code);
        }
      }
    }
    return codes.toList();
  }

  /// 市区町村コード → 全レベル横断での最大震度レベル
  Map<String, JmaIntensity> _cityMaxJmaLevels(EarthquakeIntensity intensity) {
    final maxLevels = <String, JmaIntensity>{};
    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          if (city.maxIntensity == null) {
            continue;
          }
          final current = maxLevels[city.city.code];
          if (current == null || entry.key.orderIndex > current.orderIndex) {
            maxLevels[city.city.code] = entry.key;
          }
        }
      }
    }
    return maxLevels;
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
    final nodes = intensity.lpgmIntensityTree[intensityLevel];
    if (nodes == null) {
      return [];
    }
    // 複数階級に跨る細分区域は最大階級にのみ含める (jmaCityCodes と同様)。
    final maxLevels = _regionMaxLpgmLevels(intensity);
    final codes = <String>{};
    for (final region in nodes) {
      if (region.maxLpgmIntensity != null &&
          maxLevels[region.region.code] == intensityLevel) {
        codes.add(region.region.code);
      }
    }
    return codes.toList();
  }

  /// 細分区域コード → 全階級横断での最大長周期地震動階級
  Map<String, JmaLpgmIntensity> _regionMaxLpgmLevels(
    EarthquakeIntensity intensity,
  ) {
    final maxLevels = <String, JmaLpgmIntensity>{};
    for (final entry in intensity.lpgmIntensityTree.entries) {
      for (final region in entry.value) {
        if (region.maxLpgmIntensity == null) {
          continue;
        }
        final current = maxLevels[region.region.code];
        if (current == null || entry.key.orderIndex > current.orderIndex) {
          maxLevels[region.region.code] = entry.key;
        }
      }
    }
    return maxLevels;
  }

  List<String> lpgmCityCodes(
    EarthquakeIntensity intensity,
    JmaLpgmIntensity intensityLevel,
  ) {
    final nodes = intensity.lpgmIntensityTree[intensityLevel];
    if (nodes == null) {
      return [];
    }
    // 複数階級に跨る市区町村は最大階級にのみ含める (jmaCityCodes と同様)。
    final maxLevels = _cityMaxLpgmLevels(intensity);
    final codes = <String>{};
    for (final region in nodes) {
      for (final city in region.cities) {
        if (city.maxLpgmIntensity != null &&
            maxLevels[city.city.code] == intensityLevel) {
          codes.add(city.city.code);
        }
      }
    }
    return codes.toList();
  }

  /// 市区町村コード → 全階級横断での最大長周期地震動階級
  Map<String, JmaLpgmIntensity> _cityMaxLpgmLevels(
    EarthquakeIntensity intensity,
  ) {
    final maxLevels = <String, JmaLpgmIntensity>{};
    for (final entry in intensity.lpgmIntensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          if (city.maxLpgmIntensity == null) {
            continue;
          }
          final current = maxLevels[city.city.code];
          if (current == null || entry.key.orderIndex > current.orderIndex) {
            maxLevels[city.city.code] = entry.key;
          }
        }
      }
    }
    return maxLevels;
  }
}
