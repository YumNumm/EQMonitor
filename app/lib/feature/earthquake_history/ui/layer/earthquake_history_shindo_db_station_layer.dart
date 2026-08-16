import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_icon_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart';
import 'package:eqmonitor/feature/map/features/icon/data/provider/intensity_icon_provider.dart';
import 'package:material_ui/material_ui.dart';
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

  static const sourceId = 'eq-history-shindo-db-station';
  static const iconLayerId = 'eq-history-shindo-db-station-icon';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final iconData = ref.watch(intensityIconProvider).value;
    final dbIconData = ref.watch(shindoDbIntensityIconProvider).value;
    final enqueue = useMapOperationQueue();
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final isLayerInitialized = useRef(false);
    final imagesAdded = useRef(false);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final geoJson = const EarthquakeHistoryShindoDbStationGeoJsonBuilder()
        .build(tree: tree);

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      isLayerInitialized.value = false;
      imagesAdded.value = false;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: sourceId,
            data: '{"type":"FeatureCollection","features":[]}',
          ),
        );
      });

      return () {
        if (lifecycleToken.value == token) {
          lifecycleToken.value = null;
        }
        geoJsonUpdater.reset();
        unawaited(
          enqueue(
            () => MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: const [iconLayerId],
              sourceIds: const [sourceId],
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
          iconData == null ||
          dbIconData == null) {
        return null;
      }
      unawaited(
        enqueue(() async {
          await initialized;
          if (lifecycleToken.value != token) {
            return;
          }
          if (!imagesAdded.value) {
            await styleController.addImages({
              ...iconData.toMapStyleImages,
              ...dbIconData.toMapStyleImages,
            });
            imagesAdded.value = true;
          }
          if (isLayerInitialized.value) {
            await styleController.removeLayer(iconLayerId);
          }
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            EarthquakeHistoryShindoDbStationLayerBuilder.build(
              parameter: parameter,
            ),
          );
          isLayerInitialized.value = true;
        }),
      );
      return null;
    }, [styleController, parameter, iconData, dbIconData]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: sourceId,
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

class EarthquakeHistoryShindoDbStationLayerBuilder {
  const EarthquakeHistoryShindoDbStationLayerBuilder._();

  static SymbolStyleLayer build({
    required EarthquakeHistoryMapLayerParameter parameter,
  }) => SymbolStyleLayer(
    id: EarthquakeHistoryShindoDbStationLayer.iconLayerId,
    sourceId: EarthquakeHistoryShindoDbStationLayer.sourceId,
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

class EarthquakeHistoryShindoDbStationGeoJsonBuilder {
  const EarthquakeHistoryShindoDbStationGeoJsonBuilder();

  String build({required ShindoDbIntensityTree tree}) {
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
