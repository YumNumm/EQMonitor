import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/theme/model/intensity_colors.dart';
import 'package:eqmonitor/core/theme/provider/app_theme_notifier.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryShindoDbStationLayer extends HookConsumerWidget {
  const EarthquakeHistoryShindoDbStationLayer({
    required this.tree,
    required this.parameter,
    super.key,
  });

  final ShindoDbIntensityTree tree;
  final EarthquakeHistoryMapLayerParameter parameter;

  static const _sourceId = 'eq-history-shindo-db-station';
  static const _circleLayerId = 'eq-history-shindo-db-station-circle';
  static const _iconLayerId = 'eq-history-shindo-db-station-icon';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final colorModel = ref.watch(activeColorSetProvider).intensity;
    final iconData = ref.watch(intensityIconProvider).value;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      var disposed = false;
      var iconLayerAdded = false;

      unawaited(
        enqueue(() async {
          try {
            final geoJson = buildShindoDbStationGeoJson(
              tree: tree,
              colorModel: colorModel,
            );

            if (disposed) {
              return;
            }
            await styleController.addSource(
              GeoJsonSource(id: _sourceId, data: geoJson),
            );

            if (disposed) {
              return;
            }
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
                  'circle-radius': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    4,
                    parameter.stationCircleRadiusMin,
                    10,
                    parameter.stationCircleRadiusMax,
                  ],
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
                  filter: const ['has', 'iconId'],
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
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        disposed = true;
        unawaited(
          enqueue(() async {
            if (iconLayerAdded) {
              try {
                await styleController.removeLayer(_iconLayerId);
              } on Exception catch (e) {
                talker.log(e);
              }
            }
            try {
              await styleController.removeLayer(_circleLayerId);
            } on Exception catch (e) {
              talker.log(e);
            }
            try {
              await styleController.removeSource(_sourceId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, tree, colorModel, parameter, iconData]);

    return const SizedBox.shrink();
  }
}

const shindoDbStationGeoJsonFeatureLimit = 5000;

String buildShindoDbStationGeoJson({
  required ShindoDbIntensityTree tree,
  required IntensityColors colorModel,
}) {
  final builder = ShindoDbStationGeoJsonBuilder(colorModel: colorModel);
  return builder.build(tree: tree);
}

class ShindoDbStationGeoJsonBuilder {
  const ShindoDbStationGeoJsonBuilder({required this.colorModel});

  final IntensityColors colorModel;

  String build({required ShindoDbIntensityTree tree}) {
    final features = <Map<String, dynamic>>[];
    final addedStationCodes = <String>{};

    for (final entry in tree.tree.entries) {
      for (final pref in entry.value) {
        for (final cityNode in pref.cities) {
          for (final station in cityNode.stations) {
            addStation(
              features: features,
              addedStationCodes: addedStationCodes,
              station: station,
              cls: entry.key,
            );
            if (features.length >= shindoDbStationGeoJsonFeatureLimit) {
              return encodeFeatures(features);
            }
          }
        }
      }
    }

    for (final entry in tree.unresolvedStations.entries) {
      for (final station in entry.value) {
        addStation(
          features: features,
          addedStationCodes: addedStationCodes,
          station: station,
          cls: entry.key,
        );
        if (features.length >= shindoDbStationGeoJsonFeatureLimit) {
          return encodeFeatures(features);
        }
      }
    }

    return encodeFeatures(features);
  }

  String encodeFeatures(List<Map<String, dynamic>> features) {
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  void addStation({
    required List<Map<String, dynamic>> features,
    required Set<String> addedStationCodes,
    required ShindoDbStationNode station,
    required ShindoDbIntensityClass cls,
  }) {
    final loc = station.location;
    if (loc == null ||
        features.length >= shindoDbStationGeoJsonFeatureLimit ||
        !addedStationCodes.add(station.record.stationCode)) {
      return;
    }

    final colorJma = cls.colorJmaIntensity;
    final color = colorJma != null
        ? colorModel.fromJmaIntensity(colorJma).background.toHexStringRGB()
        : '#9e9e9e';
    final props = <String, dynamic>{
      'color': color,
      'name': station.name,
      'sortKey': cls.orderIndex,
    };
    final exactJma = cls.exactJmaIntensity;
    if (exactJma != null) {
      props['iconId'] = 'JmaIntensity.small.${exactJma.name}';
    }
    features.add({
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [loc.lon, loc.lat],
      },
      'properties': props,
    });
  }
}
