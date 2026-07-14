import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_icon_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
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
  static const _iconLayerId = 'eq-history-shindo-db-station-icon';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final iconData = ref.watch(intensityIconProvider).value;
    final dbIconData = ref.watch(shindoDbIntensityIconProvider).value;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null || iconData == null || dbIconData == null) {
        return null;
      }

      var disposed = false;

      unawaited(
        enqueue(() async {
          try {
            final geoJson = _buildGeoJson(tree);

            if (disposed) {
              return;
            }
            await styleController.addSource(
              GeoJsonSource(id: _sourceId, data: geoJson),
            );

            if (disposed) {
              return;
            }
            await styleController.addImages({
              ...iconData.toMapStyleImages,
              ...dbIconData.toMapStyleImages,
            });

            if (disposed) {
              return;
            }
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
              await styleController.removeLayer(_iconLayerId);
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
    }, [styleController, tree, parameter, iconData, dbIconData]);

    return const SizedBox.shrink();
  }

  static String _buildGeoJson(ShindoDbIntensityTree tree) {
    final features = <Map<String, dynamic>>[];

    void addStation(ShindoDbStationNode station, ShindoDbIntensityClass cls) {
      final loc = station.location;
      if (loc == null) {
        return;
      }
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [loc.lon, loc.lat],
        },
        'properties': {
          'name': station.name,
          'iconId': cls.mapIconId,
          // 高震度が上に描画されるようソートキーに使用
          'sortKey': cls.orderIndex,
        },
      });
    }

    for (final entry in tree.tree.entries) {
      final cls = entry.key;
      for (final pref in entry.value) {
        for (final cityNode in pref.cities) {
          for (final station in cityNode.stations) {
            addStation(station, cls);
          }
        }
      }
    }

    for (final entry in tree.unresolvedStations.entries) {
      final cls = entry.key;
      for (final station in entry.value) {
        addStation(station, cls);
      }
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }
}
