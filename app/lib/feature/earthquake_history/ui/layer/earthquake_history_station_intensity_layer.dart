import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = earthquake.intensity;

    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final iconData = ref.watch(intensityIconProvider).value;
    final enqueue = useMapOperationQueue();
    final layerBuilder = useMemoized(
      EarthquakeHistoryStationIntensityLayerBuilder.new,
    );
    final geoJsonBuilder = useMemoized(
      EarthquakeHistoryStationGeoJsonBuilder.new,
    );

    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final imagesAdded = useRef(false);
    final latestLayerConfiguration = useRef<Object?>(null);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final latestParameter = useRef(parameter);
    latestParameter.value = parameter;
    final latestStationDisplayMode = useRef(stationDisplayMode);
    latestStationDisplayMode.value = stationDisplayMode;
    final latestShowStationLabel = useRef(showStationLabel);
    latestShowStationLabel.value = showStationLabel;
    final latestIconData = useRef(iconData);
    latestIconData.value = iconData;
    final geoJson = geoJsonBuilder.build(
      intensity: intensity,
      colorModel: colorModel,
      stationDisplayMode: stationDisplayMode,
      showingLpgmIntensity: showingLpgmIntensity,
    );

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      imagesAdded.value = false;
      latestLayerConfiguration.value = null;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: EarthquakeHistoryStationIntensityLayerBuilder.sourceId,
            data: '{"type":"FeatureCollection","features":[]}',
          ),
        );
        final cachedBytes = latestIconData.value?.toMapStyleImages;
        if (cachedBytes != null && lifecycleToken.value == token) {
          await styleController.addImages(cachedBytes);
          imagesAdded.value = true;
        }
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addLayer(
          layerBuilder.buildCircleLayer(
            parameter: latestParameter.value,
            stationDisplayMode: latestStationDisplayMode.value,
          ),
        );
        if (latestIconData.value != null) {
          await styleController.addLayer(
            layerBuilder.buildIconLayer(parameter: latestParameter.value),
          );
        }
        if (latestShowStationLabel.value) {
          await styleController.addLayer(
            layerBuilder.buildLabelLayer(parameter: latestParameter.value),
          );
        }
        latestLayerConfiguration.value = (
          parameter: latestParameter.value,
          stationDisplayMode: latestStationDisplayMode.value,
          showStationLabel: latestShowStationLabel.value,
          hasIcon: latestIconData.value != null,
        );
      });

      return () {
        if (lifecycleToken.value == token) {
          lifecycleToken.value = null;
        }
        geoJsonUpdater.reset();
        unawaited(
          enqueue(
            () => removeMapStyleResources(
              styleController: styleController,
              layerIds: const [
                EarthquakeHistoryStationIntensityLayerBuilder.labelLayerId,
                EarthquakeHistoryStationIntensityLayerBuilder.iconLayerId,
                EarthquakeHistoryStationIntensityLayerBuilder.circleLayerId,
              ],
              sourceIds: const [
                EarthquakeHistoryStationIntensityLayerBuilder.sourceId,
              ],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      final initialized = initialization.value;
      if (styleController == null ||
          token == null ||
          initialized == null ||
          iconData == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await initialized;
          if (lifecycleToken.value != token || imagesAdded.value) {
            return;
          }
          await styleController.addImages(iconData.toMapStyleImages);
          imagesAdded.value = true;
        }),
      );
      return null;
    }, [styleController, iconData]);

    useEffect(
      () {
        final token = lifecycleToken.value;
        final initialized = initialization.value;
        if (styleController == null || token == null || initialized == null) {
          return null;
        }
        final configuration = (
          parameter: parameter,
          stationDisplayMode: stationDisplayMode,
          showStationLabel: showStationLabel,
          hasIcon: iconData != null,
        );
        unawaited(
          enqueue(() async {
            await initialized;
            if (lifecycleToken.value != token ||
                latestLayerConfiguration.value == configuration) {
              return;
            }
            await removeMapStyleResources(
              styleController: styleController,
              layerIds: const [
                EarthquakeHistoryStationIntensityLayerBuilder.labelLayerId,
                EarthquakeHistoryStationIntensityLayerBuilder.iconLayerId,
                EarthquakeHistoryStationIntensityLayerBuilder.circleLayerId,
              ],
            );
            if (lifecycleToken.value != token) {
              return;
            }
            await styleController.addLayer(
              layerBuilder.buildCircleLayer(
                parameter: parameter,
                stationDisplayMode: stationDisplayMode,
              ),
            );
            if (iconData != null) {
              await styleController.addLayer(
                layerBuilder.buildIconLayer(parameter: parameter),
              );
            }
            if (showStationLabel) {
              await styleController.addLayer(
                layerBuilder.buildLabelLayer(parameter: parameter),
              );
            }
            latestLayerConfiguration.value = configuration;
          }),
        );
        return null;
      },
      [
        styleController,
        parameter,
        stationDisplayMode,
        showStationLabel,
        iconData,
      ],
    );

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: EarthquakeHistoryStationIntensityLayerBuilder.sourceId,
            geoJson: geoJson,
            initialization: initialization.value,
            isDisposed: () => lifecycleToken.value != token,
          ),
        ),
      );
      return null;
    }, [styleController, geoJson]);

    return const SizedBox.shrink();
  }
}

class EarthquakeHistoryStationGeoJsonBuilder {
  const EarthquakeHistoryStationGeoJsonBuilder();

  static const iconSmallPrefix = 'JmaIntensity.small.';
  static const iconSmallNoTextPrefix = 'JmaIntensity.smallWithoutText.';
  static const lpgmIconSmallPrefix = 'JmaLpgmIntensity.small.';
  static const lpgmIconSmallNoTextPrefix = 'JmaLpgmIntensity.smallWithoutText.';

  String build({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
    required StationDisplayMode stationDisplayMode,
    required bool showingLpgmIntensity,
  }) => showingLpgmIntensity
      ? buildLpgmGeoJson(
          intensity: intensity,
          colorModel: colorModel,
          stationDisplayMode: stationDisplayMode,
        )
      : buildJmaGeoJson(
          intensity: intensity,
          colorModel: colorModel,
          stationDisplayMode: stationDisplayMode,
        );

  String iconIdForStation({
    required String intensityName,
    required bool isFocused,
    required StationDisplayMode stationDisplayMode,
  }) {
    final useSmall = switch (stationDisplayMode) {
      StationDisplayMode.normal => true,
      StationDisplayMode.maxFocused => isFocused,
      StationDisplayMode.allMinimized => false,
    };
    final prefix = useSmall ? iconSmallPrefix : iconSmallNoTextPrefix;
    return '$prefix$intensityName';
  }

  String lpgmIconIdForStation({
    required String lpgmName,
    required StationDisplayMode stationDisplayMode,
  }) {
    final useSmall = stationDisplayMode != StationDisplayMode.allMinimized;
    final prefix = useSmall ? lpgmIconSmallPrefix : lpgmIconSmallNoTextPrefix;
    return '$prefix$lpgmName';
  }

  String buildJmaGeoJson({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
    required StationDisplayMode stationDisplayMode,
  }) {
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
            final iconId = iconIdForStation(
              intensityName: jmaIntensity.name,
              isFocused: isFocused,
              stationDisplayMode: stationDisplayMode,
            );
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
                'sortKey': jmaIntensity.index,
              },
            });
          }
        }
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String buildLpgmGeoJson({
    required EarthquakeIntensity? intensity,
    required IntensityColors colorModel,
    required StationDisplayMode stationDisplayMode,
  }) {
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
            final iconId = lpgmIconIdForStation(
              lpgmName: lpgmIntensity.name,
              stationDisplayMode: stationDisplayMode,
            );
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

class EarthquakeHistoryStationIntensityLayerBuilder {
  const EarthquakeHistoryStationIntensityLayerBuilder();

  static const sourceId = 'eq-history-station-intensity';
  static const circleLayerId = 'eq-history-station-intensity-circle';
  static const iconLayerId = 'eq-history-station-intensity-icon';
  static const labelLayerId = 'eq-history-station-intensity-label';

  CircleStyleLayer buildCircleLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
    required StationDisplayMode stationDisplayMode,
  }) {
    return CircleStyleLayer(
      id: circleLayerId,
      sourceId: sourceId,
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
    );
  }

  SymbolStyleLayer buildIconLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
  }) {
    return SymbolStyleLayer(
      id: iconLayerId,
      sourceId: sourceId,
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
    );
  }

  SymbolStyleLayer buildLabelLayer({
    required EarthquakeHistoryMapLayerParameter parameter,
  }) {
    return SymbolStyleLayer(
      id: labelLayerId,
      sourceId: sourceId,
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
    );
  }
}
