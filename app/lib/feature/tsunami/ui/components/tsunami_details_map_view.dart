import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/core/util/map/map_geo_json_source_updater.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_offshore_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geobase/geobase.dart' as geo;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

class TsunamiDetailsMapView extends HookConsumerWidget {
  const new({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(value: MapConfiguration(:final styleString?)) =>
        MapOperationQueueScope(
          child: MapLibreEventProvider(
            child: _MapContent(styleString: styleString, tsunami: tsunami),
          ),
        ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

/// 日本付近のデフォルト表示位置
const _kDefaultCenter = Geographic(lon: 138, lat: 36.5);
const _kDefaultZoom = 4.5;

class _MapContent extends HookConsumerWidget {
  const new({required this.styleString, required this.tsunami});

  final String styleString;
  final TsunamiState tsunami;

  // --- Source / Layer IDs ---
  static const _tsunamiLineSourceId = 'tsunami-region-lines';
  static const _tsunamiLineLayerIdPrefix = 'tsunami-region-line-';
  static const _hypocenterSourceId = 'tsunami-hypocenter';
  static const _hypocenterLayerId = 'tsunami-hypocenter-symbol';
  static const _hypocenterIconId = 'tsunami-hypocenter-icon';
  static const _stationSourceId = 'tsunami-observation-stations';
  static const _stationCircleLayerId = 'tsunami-observation-station-circle';
  static const _stationLabelLayerId = 'tsunami-observation-station-label';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (v) => v.value?.map ?? const HomeMapSettings(),
      ),
    );

    final center = _initialCenter();
    final (:maxZoom, :gestures) = const HomeMapOptionsBuilder().sharedOptions(
      mapSettings,
    );
    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: _kDefaultZoom,
      initStyle: styleString,
      maxZoom: maxZoom,
      gestures: gestures,
    );
    final mapController = useState<MapController?>(null);

    return Stack(
      children: [
        MapLibreMap(
          options: mapOptions,
          onMapCreated: (controller) {
            mapController.value = controller;
          },
          onEvent: (event) {
            MapLibreEventProvider.maybeOf(context)?.emit(event);
          },
          children: [
            _TsunamiRegionLineLayer(tsunami: tsunami),
            _TsunamiHypocenterLayer(tsunami: tsunami),
            _TsunamiObservationStationLayer(tsunami: tsunami),
          ],
        ),

        // コントローラカード（右上）
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            child: _MapControllerCard(
              onFitBoundsTap: () async {
                final controller = mapController.value;
                if (controller == null) {
                  return;
                }
                await _fitBounds(controller);
              },
            ),
          ),
        ),
      ],
    );
  }

  Geographic _initialCenter() {
    final hypocenter = tsunami.earthquakes.firstOrNull?.hypocenter;
    final latitude = hypocenter?.latitude;
    final longitude = hypocenter?.longitude;
    if (latitude != null && longitude != null) {
      return Geographic(lon: longitude, lat: latitude);
    }
    return _kDefaultCenter;
  }

  Future<void> _fitBounds(MapController controller) async {
    final points = <Geographic>[];

    // 震源
    final hypocenter = tsunami.earthquakes.firstOrNull?.hypocenter;
    final latitude = hypocenter?.latitude;
    final longitude = hypocenter?.longitude;
    if (latitude != null && longitude != null) {
      points.add(Geographic(lon: longitude, lat: latitude));
    }

    if (points.isEmpty) {
      // 日本付近をデフォルト表示
      points
        ..add(const Geographic(lon: 123, lat: 24))
        ..add(const Geographic(lon: 148, lat: 46));
    }

    await controller.fitBounds(
      bounds: LngLatBounds.fromPoints(points),
      padding: const EdgeInsets.all(48),
      webMaxZoom: 8,
    );
  }
}

// ---------------------------------------------------------------------------
// 津波予報区 海岸線ラインレイヤー
// ---------------------------------------------------------------------------

class _TsunamiRegionLineLayer extends HookConsumerWidget {
  const new({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final jmaMapAsync = ref.watch(jmaMapProvider);
    final enqueue = useMapOperationQueue();
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    const geoJsonBuilder = TsunamiMapGeoJsonBuilder();
    final jmaMap = jmaMapAsync.value;
    final geoJson = jmaMap == null
        ? TsunamiMapGeoJsonBuilder.emptyFeatureCollection
        : geoJsonBuilder.buildRegions(
            tsunamiMapData: jmaMap.areaTsunami,
            regions: tsunami.regions,
          );
    final layerIds = TsunamiMapLayerBuilder.warningKinds
        .map((kind) => TsunamiMapLayerBuilder.regionLayerId(kind: kind))
        .toList();

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: _MapContent._tsunamiLineSourceId,
            data: TsunamiMapGeoJsonBuilder.emptyFeatureCollection,
          ),
        );
        for (final kind in TsunamiMapLayerBuilder.warningKinds) {
          if (lifecycleToken.value != token) {
            return;
          }
          await styleController.addLayer(
            TsunamiMapLayerBuilder.buildRegionLineLayer(kind: kind),
          );
        }
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
              layerIds: layerIds.reversed.toList(),
              sourceIds: const [_MapContent._tsunamiLineSourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: _MapContent._tsunamiLineSourceId,
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

// ---------------------------------------------------------------------------
// 震源マーカーレイヤー
// ---------------------------------------------------------------------------

class _TsunamiHypocenterLayer extends HookConsumerWidget {
  const new({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final hypocenter = tsunami.earthquakes.firstOrNull?.hypocenter;
    final geoJson = const TsunamiMapGeoJsonBuilder().buildHypocenter(
      latitude: hypocenter?.latitude,
      longitude: hypocenter?.longitude,
    );

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addImageFromAssets(
          id: _MapContent._hypocenterIconId,
          asset: Assets.images.map.normalHypocenter.path,
        );
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: _MapContent._hypocenterSourceId,
            data: TsunamiMapGeoJsonBuilder.emptyFeatureCollection,
          ),
        );
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addLayer(
          TsunamiMapLayerBuilder.buildHypocenterLayer(),
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
              layerIds: const [_MapContent._hypocenterLayerId],
              sourceIds: const [_MapContent._hypocenterSourceId],
              imageIds: const [_MapContent._hypocenterIconId],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: _MapContent._hypocenterSourceId,
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

// ---------------------------------------------------------------------------
// 観測点マーカーレイヤー
// ---------------------------------------------------------------------------

class _TsunamiObservationStationLayer extends HookConsumerWidget {
  const new({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final jmaParamAsync = ref.watch(jmaParameterProvider);
    final enqueue = useMapOperationQueue();
    final lifecycleToken = useRef<Object?>(null);
    final initialization = useRef<Future<void>?>(null);
    final geoJsonUpdater = useMemoized(MapGeoJsonSourceUpdater.new);
    final tsunamiParameter = jmaParamAsync.value?.tsunami;
    final geoJson = tsunamiParameter == null
        ? TsunamiMapGeoJsonBuilder.emptyFeatureCollection
        : const TsunamiMapGeoJsonBuilder().buildObservationStations(
            tsunami: tsunami,
            tsunamiParameter: tsunamiParameter,
          );

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final token = Object();
      lifecycleToken.value = token;
      geoJsonUpdater.reset();
      initialization.value = enqueue(() async {
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addSource(
          const GeoJsonSource(
            id: _MapContent._stationSourceId,
            data: TsunamiMapGeoJsonBuilder.emptyFeatureCollection,
          ),
        );
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addLayer(
          TsunamiMapLayerBuilder.buildStationCircleLayer(),
        );
        if (lifecycleToken.value != token) {
          return;
        }
        await styleController.addLayer(
          TsunamiMapLayerBuilder.buildStationLabelLayer(),
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
              layerIds: const [
                _MapContent._stationLabelLayerId,
                _MapContent._stationCircleLayerId,
              ],
              sourceIds: const [_MapContent._stationSourceId],
            ),
          ),
        );
      };
    }, [styleController]);

    useEffect(() {
      final token = lifecycleToken.value;
      if (styleController == null || token == null) {
        return null;
      }
      unawaited(
        enqueue(
          () => geoJsonUpdater.update(
            styleController: styleController,
            sourceId: _MapContent._stationSourceId,
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

class TsunamiMapGeoJsonBuilder {
  const new();

  static const emptyFeatureCollection =
      '{"type":"FeatureCollection","features":[]}';

  String buildHypocenter({
    required double? latitude,
    required double? longitude,
  }) => jsonEncode({
    'type': 'FeatureCollection',
    'features': <Map<String, dynamic>>[
      if (latitude != null && longitude != null)
        {
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [longitude, latitude],
          },
          'properties': <String, dynamic>{},
        },
    ],
  });

  String buildRegions({
    required JmaMap_JmaMapData tsunamiMapData,
    required List<TsunamiRegion> regions,
  }) {
    final codeToKind = {for (final region in regions) region.code: region.kind};
    final features = <Map<String, dynamic>>[];
    for (final item in tsunamiMapData.data) {
      final code = item.property.code;
      final kind = codeToKind[code];
      if (kind == null || kind == .none) {
        continue;
      }
      final geometry = decodeGeometry(
        dataType: item.dataType,
        bytes: Uint8List.fromList(item.bytes),
      );
      if (geometry == null) {
        continue;
      }
      features.add({
        'type': 'Feature',
        'geometry': geometry,
        'properties': {
          'code': code,
          'name': item.property.name,
          'kind': kind.name,
        },
      });
    }
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  Map<String, dynamic>? decodeGeometry({
    required JmaMap_JmaMapData_DataType dataType,
    required Uint8List bytes,
  }) => switch (dataType) {
    JmaMap_JmaMapData_DataType.LINE_STRING => {
      'type': 'LineString',
      'coordinates': chainToCoordinates(
        chain: geo.LineString.decode(bytes).chain,
      ),
    },
    JmaMap_JmaMapData_DataType.MULTI_LINE_STRING => {
      'type': 'MultiLineString',
      'coordinates': [
        for (final chain in geo.MultiLineString.decode(bytes).chains)
          chainToCoordinates(chain: chain),
      ],
    },
    JmaMap_JmaMapData_DataType.POLYGON ||
    JmaMap_JmaMapData_DataType.MULTI_POLYGON => null,
    _ => null,
  };

  List<List<double>> chainToCoordinates({required geo.PositionSeries chain}) =>
      [
        for (var index = 0; index < chain.positionCount; index++)
          [chain.x(index), chain.y(index)],
      ];

  String buildObservationStations({
    required TsunamiState tsunami,
    required TsunamiParameter tsunamiParameter,
  }) {
    final stationLocations = <String, ({double lat, double lon})>{};
    for (final prefecture in tsunamiParameter.prefectures) {
      for (final area in prefecture.areas) {
        for (final station in area.stations) {
          stationLocations[station.code] = (
            lat: station.location.lat,
            lon: station.location.lon,
          );
        }
      }
    }
    final features = <Map<String, dynamic>>[];
    for (final region in tsunami.regions) {
      for (final station in region.stations) {
        final location = stationLocations[station.code];
        if (station.observation == null || location == null) {
          continue;
        }
        features.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [location.lon, location.lat],
          },
          'properties': {
            'name': station.name,
            'color': stationColor(station: station),
            'code': station.code,
          },
        });
      }
    }
    for (final station in tsunami.offshoreStations) {
      final location = stationLocations[station.code];
      if (location == null) {
        continue;
      }
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [location.lon, location.lat],
        },
        'properties': {
          'name': station.name,
          'color': offshoreStationColor(station: station),
          'code': station.code,
        },
      });
    }
    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  String stationColor({required TsunamiRegionStation station}) {
    final maxHeight = station.observation?.maxHeight;
    return observationColor(
      condition: maxHeight?.condition,
      value: maxHeight?.value,
      isRising: maxHeight?.isRising,
    );
  }

  String offshoreStationColor({required TsunamiOffshoreStation station}) =>
      observationColor(
        condition: station.maxHeight?.condition,
        value: station.maxHeight?.value,
        isRising: station.maxHeight?.isRising,
      );

  String observationColor({
    required ObservationMaxHeightCondition? condition,
    required num? value,
    required bool? isRising,
  }) {
    if (condition == ObservationMaxHeightCondition.important ||
        (value != null && value >= 1)) {
      return '#F44336';
    }
    if (condition == ObservationMaxHeightCondition.observing ||
        (isRising ?? false)) {
      return '#FF9800';
    }
    if (condition == ObservationMaxHeightCondition.minor ||
        (value != null && value < 1)) {
      return '#FFEB3B';
    }
    return '#9E9E9E';
  }
}

class TsunamiMapLayerBuilder {
  const new _();

  static const warningKinds = [
    TsunamiWarningKind.forecast,
    TsunamiWarningKind.advisory,
    TsunamiWarningKind.warning,
    TsunamiWarningKind.majorWarning,
  ];

  static String regionLayerId({required TsunamiWarningKind kind}) =>
      '${_MapContent._tsunamiLineLayerIdPrefix}${kind.name}';

  static LineStyleLayer buildRegionLineLayer({
    required TsunamiWarningKind kind,
  }) => LineStyleLayer(
    id: regionLayerId(kind: kind),
    sourceId: _MapContent._tsunamiLineSourceId,
    filter: [
      '==',
      ['get', 'kind'],
      kind.name,
    ],
    paint: {
      'line-color': TsunamiWarningColor.mapBorderColor(kind).toHexStringRGB(),
      'line-width': switch (kind) {
        .majorWarning => 5.0,
        .warning => 4.0,
        .advisory => 3.0,
        .forecast => 2.0,
        .none => 1.0,
        .advisoryCancel || .warningCancel => 0,
      },
      'line-opacity': 0.9,
    },
  );

  static SymbolStyleLayer buildHypocenterLayer() => const SymbolStyleLayer(
    id: _MapContent._hypocenterLayerId,
    sourceId: _MapContent._hypocenterSourceId,
    layout: {
      'icon-allow-overlap': true,
      'icon-ignore-placement': true,
      'icon-image': _MapContent._hypocenterIconId,
      'icon-size': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.15,
        20,
        0.4,
      ],
    },
  );

  static CircleStyleLayer buildStationCircleLayer() => const CircleStyleLayer(
    id: _MapContent._stationCircleLayerId,
    sourceId: _MapContent._stationSourceId,
    paint: {
      'circle-radius': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        3,
        10,
        8,
      ],
      'circle-color': ['get', 'color'],
      'circle-stroke-color': '#ffffff',
      'circle-stroke-width': [
        'interpolate',
        ['linear'],
        ['zoom'],
        3,
        0.3,
        10,
        1.5,
      ],
    },
  );

  static SymbolStyleLayer buildStationLabelLayer() => const SymbolStyleLayer(
    id: _MapContent._stationLabelLayerId,
    sourceId: _MapContent._stationSourceId,
    minZoom: 8,
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

// ---------------------------------------------------------------------------
// 地図右上コントローラカード
// ---------------------------------------------------------------------------

class _MapControllerCard extends StatelessWidget {
  const new({required this.onFitBoundsTap});

  final Future<void> Function() onFitBoundsTap;

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.designSystem.colorTheme;

    return Card(
      color: colorTheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          await HapticFeedback.lightImpact();
          await onFitBoundsTap();
        },
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.zoom_out_map_rounded),
        ),
      ),
    );
  }
}
