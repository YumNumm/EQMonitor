// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geobase/geobase.dart' as geo;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

class TsunamiDetailsMapView extends HookConsumerWidget {
  const TsunamiDetailsMapView({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null =>
        MapOperationQueueScope(
          child: MapLibreEventProvider(
            child: _MapContent(
              styleString: value.styleString!,
              tsunami: tsunami,
            ),
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
  const _MapContent({required this.styleString, required this.tsunami});

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
    final (:maxZoom, :gestures) = sharedMapOptionsFromSettings(mapSettings);
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
    final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;
    if (coords != null) {
      return Geographic(
        lon: coords.longitude.toDouble(),
        lat: coords.latitude.toDouble(),
      );
    }
    return _kDefaultCenter;
  }

  Future<void> _fitBounds(MapController controller) async {
    final points = <Geographic>[];

    // 震源
    final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;
    if (coords != null) {
      points.add(
        Geographic(
          lon: coords.longitude.toDouble(),
          lat: coords.latitude.toDouble(),
        ),
      );
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
  const _TsunamiRegionLineLayer({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final jmaMapAsync = ref.watch(jmaMapProvider);
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final jmaMap = jmaMapAsync.value;
      if (jmaMap == null) {
        return null;
      }

      final addedLayerIds = <String>[];

      unawaited(
        enqueue(() async {
          try {
            final tsunamiMapData = jmaMap.areaTsunami;
            final geoJson = _buildTsunamiRegionGeoJson(
              tsunamiMapData,
              tsunami.regions,
            );

            await styleController.addSource(
              GeoJsonSource(
                id: _MapContent._tsunamiLineSourceId,
                data: geoJson,
              ),
            );

            // 警報種別ごとにラインレイヤーを追加（重要度順: 予報 → 注意報 → 警報 → 大津波警報）
            final kindOrder = [
              TsunamiWarningKind.forecast,
              TsunamiWarningKind.advisory,
              TsunamiWarningKind.warning,
              TsunamiWarningKind.majorWarning,
            ];

            for (final kind in kindOrder) {
              final color = TsunamiWarningColor.mapBorderColor(
                kind,
              ).toHexStringRGB();
              final layerId =
                  '${_MapContent._tsunamiLineLayerIdPrefix}${kind.name}';
              await styleController.addLayer(
                LineStyleLayer(
                  id: layerId,
                  sourceId: _MapContent._tsunamiLineSourceId,
                  filter: [
                    '==',
                    ['get', 'kind'],
                    kind.name,
                  ],
                  paint: {
                    'line-color': color,
                    'line-width': switch (kind) {
                      .majorWarning => 5.0,
                      .warning => 4.0,
                      .advisory => 3.0,
                      .forecast => 2.0,
                      .none => 1.0,
                      .advisoryCancel => 0,
                      .warningCancel => 0,
                    },
                    'line-opacity': 0.9,
                  },
                ),
              );
              addedLayerIds.add(layerId);
            }
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            for (final id in addedLayerIds.reversed) {
              try {
                await styleController.removeLayer(id);
              } on Exception catch (e) {
                talker.log(e);
              }
            }
            try {
              await styleController.removeSource(
                _MapContent._tsunamiLineSourceId,
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, jmaMapAsync, tsunami.regions]);

    return const SizedBox.shrink();
  }

  /// JMA protobuf の津波予報区 LINE_STRING/MULTI_LINE_STRING データから
  /// GeoJSON FeatureCollection を構築する。
  String _buildTsunamiRegionGeoJson(
    JmaMap_JmaMapData tsunamiMapData,
    List<TsunamiRegion> regions,
  ) {
    // forecastRegion の code → kind マッピング
    final codeToKind = <String, TsunamiWarningKind>{};
    for (final region in regions) {
      codeToKind[region.code] = region.kind;
    }

    final features = <Map<String, dynamic>>[];

    for (final item in tsunamiMapData.data) {
      final code = item.property.code;
      final kind = codeToKind[code];
      if (kind == null || kind == .none) {
        continue;
      }

      final bytes = Uint8List.fromList(item.bytes);
      final geometry = _decodeGeometry(item.dataType, bytes);
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

  /// protobuf バイナリを GeoJSON geometry オブジェクトにデコードする。
  Map<String, dynamic>? _decodeGeometry(
    JmaMap_JmaMapData_DataType dataType,
    Uint8List bytes,
  ) {
    switch (dataType) {
      case JmaMap_JmaMapData_DataType.LINE_STRING:
        final lineString = geo.LineString.decode(bytes);
        return {
          'type': 'LineString',
          'coordinates': _chainToCoordinates(lineString.chain),
        };
      case JmaMap_JmaMapData_DataType.MULTI_LINE_STRING:
        final multiLineString = geo.MultiLineString.decode(bytes);
        return {
          'type': 'MultiLineString',
          'coordinates': [
            for (final chain in multiLineString.chains)
              _chainToCoordinates(chain),
          ],
        };
      case JmaMap_JmaMapData_DataType.POLYGON:
      case JmaMap_JmaMapData_DataType.MULTI_POLYGON:
        // 津波予報区はライン系ジオメトリのみ
        return null;
    }
    return null;
  }

  /// PositionSeries を GeoJSON coordinates 配列 ([[lng, lat], ...]) に変換。
  List<List<double>> _chainToCoordinates(geo.PositionSeries chain) {
    final coords = <List<double>>[];
    for (var i = 0; i < chain.positionCount; i++) {
      coords.add([chain.x(i), chain.y(i)]);
    }
    return coords;
  }
}

// ---------------------------------------------------------------------------
// 震源マーカーレイヤー
// ---------------------------------------------------------------------------

class _TsunamiHypocenterLayer extends HookConsumerWidget {
  const _TsunamiHypocenterLayer({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      final coords = tsunami.earthquakes.firstOrNull?.hypocenter.coordinates;
      if (coords == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          try {
            await styleController.addImageFromAssets(
              id: _MapContent._hypocenterIconId,
              asset: Assets.images.map.normalHypocenter.path,
            );

            await styleController.addSource(
              GeoJsonSource(
                id: _MapContent._hypocenterSourceId,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': [
                    {
                      'type': 'Feature',
                      'geometry': {
                        'type': 'Point',
                        'coordinates': [coords.longitude, coords.latitude],
                      },
                      'properties': <String, dynamic>{},
                    },
                  ],
                }),
              ),
            );

            await styleController.addLayer(
              const SymbolStyleLayer(
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
              ),
            );
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            try {
              await styleController.removeLayer(_MapContent._hypocenterLayerId);
            } on Exception catch (e) {
              talker.log(e);
            }
            try {
              await styleController.removeSource(
                _MapContent._hypocenterSourceId,
              );
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, tsunami.earthquakes]);

    return const SizedBox.shrink();
  }
}

// ---------------------------------------------------------------------------
// 観測点マーカーレイヤー
// ---------------------------------------------------------------------------

class _TsunamiObservationStationLayer extends HookConsumerWidget {
  const _TsunamiObservationStationLayer({required this.tsunami});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final jmaParamAsync = ref.watch(jmaParameterProvider);
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }
      final jmaParam = jmaParamAsync.value;
      if (jmaParam == null) {
        return null;
      }

      var labelLayerAdded = false;

      unawaited(
        enqueue(() async {
          try {
            final geoJson = _buildObservationStationGeoJson(
              tsunami,
              jmaParam.tsunami,
            );

            await styleController.addSource(
              GeoJsonSource(id: _MapContent._stationSourceId, data: geoJson),
            );

            await styleController.addLayer(
              const CircleStyleLayer(
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
              ),
            );

            await styleController.addLayer(
              const SymbolStyleLayer(
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
              ),
            );
            labelLayerAdded = true;
          } on Exception catch (e) {
            talker.log(e);
          }
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            if (labelLayerAdded) {
              try {
                await styleController.removeLayer(
                  _MapContent._stationLabelLayerId,
                );
              } on Exception catch (e) {
                talker.log(e);
              }
            }
            try {
              await styleController.removeLayer(
                _MapContent._stationCircleLayerId,
              );
            } on Exception catch (e) {
              talker.log(e);
            }
            try {
              await styleController.removeSource(_MapContent._stationSourceId);
            } on Exception catch (e) {
              talker.log(e);
            }
          }),
        );
      };
    }, [styleController, jmaParamAsync, tsunami]);

    return const SizedBox.shrink();
  }

  /// 津波観測点を GeoJSON FeatureCollection に構築する。
  ///
  /// forecastRegions 内の observation.stations と TsunamiParameter の
  /// 観測点位置情報を照合し、色を maxHeight の条件に基づいて決定する。
  String _buildObservationStationGeoJson(
    TsunamiState tsunami,
    TsunamiParameter tsunamiParam,
  ) {
    // TsunamiParameter から観測点コード → 位置のマップを構築
    final stationLocations = <String, ({double lat, double lon})>{};
    for (final pref in tsunamiParam.prefectures) {
      for (final area in pref.areas) {
        for (final station in area.stations) {
          stationLocations[station.code] = (
            lat: station.location.lat,
            lon: station.location.lon,
          );
        }
      }
    }

    final features = <Map<String, dynamic>>[];

    // regions 内の observation stations
    for (final region in tsunami.regions) {
      for (final station in region.stations) {
        if (station.observation == null) {
          continue;
        }
        final location = stationLocations[station.code];
        if (location == null) {
          continue;
        }

        final color = _stationColor(station);
        features.add({
          'type': 'Feature',
          'geometry': {
            'type': 'Point',
            'coordinates': [location.lon, location.lat],
          },
          'properties': {
            'name': station.name,
            'color': color,
            'code': station.code,
          },
        });
      }
    }

    // offshoreStations（沖合観測点）
    for (final obs in tsunami.offshoreStations) {
      final location = stationLocations[obs.code];
      if (location == null) {
        continue;
      }

      final color = _offshoreStationColor(obs);
      features.add({
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [location.lon, location.lat],
        },
        'properties': {'name': obs.name, 'color': color, 'code': obs.code},
      });
    }

    return jsonEncode({'type': 'FeatureCollection', 'features': features});
  }

  /// 観測点の色を maxHeight の条件に基づいて決定する。
  ///
  /// - IMPORTANT or >= 1.0m → 赤
  /// - OBSERVING or isRising → オレンジ
  /// - MINOR or < 1.0m → 黄
  /// - データなし → グレー
  String _stationColor(TsunamiRegionStation station) {
    final maxHeight = station.observation?.maxHeight;
    if (maxHeight == null) {
      return '#9E9E9E'; // grey
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.important ||
        (maxHeight.value != null && maxHeight.value! >= 1.0)) {
      return '#F44336'; // red
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.observing ||
        (maxHeight.isRising ?? false)) {
      return '#FF9800'; // orange
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.minor ||
        (maxHeight.value != null && maxHeight.value! < 1.0)) {
      return '#FFEB3B'; // yellow
    }

    return '#9E9E9E'; // grey
  }

  /// 沖合観測点の色を同様のロジックで決定する。
  String _offshoreStationColor(TsunamiOffshoreStation obs) {
    final maxHeight = obs.maxHeight;
    if (maxHeight == null) {
      return '#9E9E9E'; // grey
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.important ||
        (maxHeight.value != null && maxHeight.value! >= 1.0)) {
      return '#F44336'; // red
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.observing ||
        (maxHeight.isRising ?? false)) {
      return '#FF9800'; // orange
    }

    if (maxHeight.condition == ObservationMaxHeightCondition.minor ||
        (maxHeight.value != null && maxHeight.value! < 1.0)) {
      return '#FFEB3B'; // yellow
    }

    return '#9E9E9E'; // grey
  }
}

// ---------------------------------------------------------------------------
// 地図右上コントローラカード
// ---------------------------------------------------------------------------

class _MapControllerCard extends StatelessWidget {
  const _MapControllerCard({required this.onFitBoundsTap});

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
