// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/map_libre/provider/map_style.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:lat_lng/lat_lng.dart' as lat_lng;
import 'package:latlong2/latlong.dart' as lat_lng2;
import 'package:maplibre_gl/maplibre_gl.dart' as map_libre;
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:topo_map/topo_map.dart';

typedef _RegionColorItem = ({
  TextColorModel color,
  List<String> codes,
  JmaIntensity intensity,
});

/*
typedef _RegionLpgmColorItem = ({
  TextColorModel color,
  List<String> codes,
  JmaLgIntensity intensity,
});
*/
class EarthquakeMapWidget extends HookConsumerWidget {
  const EarthquakeMapWidget({
    super.key,
    required this.item,
    required this.showIntensityIcon,
    required this.mapData,
    required this.registerNavigateToHome,
  });
  final EarthquakeHistoryItem item;
  final bool showIntensityIcon;
  final Map<LandLayerType, ZoomCachedProjectedFeatureLayer> mapData;
  final void Function(void Function() func) registerNavigateToHome;

  Future<void> addImageFromAsset(
    MaplibreMapController controller,
    String name,
    String assetName,
  ) async {
    final bytes = await rootBundle.load(assetName);
    final list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  Future<void> addImageFromBuffer(
    MaplibreMapController controller,
    String name,
    Uint8List buffer,
  ) =>
      controller.addImage(name, buffer);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earthquake = item.earthquake;
    final intensity = earthquake.intensity;
    final colorModel = ref.watch(intensityColorProvider);
    final earthquakeParams =
        ref.watch(jmaParameterProvider).valueOrNull?.earthquake;
    final intensityIconData = ref.watch(intensityIconRenderProvider);
    final hypocenterIconRender = ref.watch(hypocenterIconRenderProvider);
    final intensityIconFillData = ref.watch(intensityIconFillRenderProvider);
    if (earthquakeParams == null ||
        !intensityIconData.isAllRendered() ||
        !intensityIconFillData.isAllRendered() ||
        hypocenterIconRender == null) {
      if (earthquakeParams == null) {
        print('earthquakeParams is null');
      } else if (!intensityIconData.isAllRendered()) {
        print('intensityIconData is not rendered');
      } else if (!intensityIconFillData.isAllRendered()) {
        print('intensityIconFillData is not rendered');
      } else if (hypocenterIconRender == null) {
        print('hypocenterIconRender is null');
      }
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mapStyle = ref.watch(mapStyleProvider);
    final styleJsonFuture = useFuture(mapStyle.getStyle(isDark: isDark));
    final path = styleJsonFuture.data;
    if (path == null) {
      print('styleJsonFuture.data is null');
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final citiesItem = useMemoized(
      () {
        if (intensity == null) {
          return null;
        }
        // cities
        if (intensity.cities == null) {
          return null;
        }
        final cities = intensity.cities!;
        final result = <_RegionColorItem>[];
        for (final e
            in mapData[LandLayerType.municipalityEarthquakeTsunamiArea]!
                .projectedPolygonFeatures) {
          final cityIntensity = cities.firstWhereOrNull(
            (cityIntensity) =>
                (int.tryParse(cityIntensity.code) ?? -2) == (e.code ?? -1),
          );
          if (cityIntensity != null && cityIntensity.maxInt != null) {
            result.add(
              (
                color: colorModel.fromJmaIntensity(cityIntensity.maxInt!),
                codes: [
                  e.code.toString().padLeft(7, '0'),
                ],
                intensity: cityIntensity.maxInt!,
              ),
            );
          }
        }
        // 同じ色の地域をまとめる
        final grouped = groupBy<_RegionColorItem, JmaIntensity>(
          result,
          (e) => e.intensity,
        ).entries.map((e) {
          final codes = <String>[];
          for (final item in e.value) {
            codes.addAll(item.codes);
          }
          return (
            color: e.value.first.color,
            codes: codes,
            intensity: e.key,
          );
        }).toList();
        return grouped;
      },
      [intensity],
    );
    final regionsItem = useMemoized(
      () {
        if (intensity == null) {
          return null;
        }
        // regionsの探索
        {
          final regions = intensity.regions;
          final result = <_RegionColorItem>[];
          for (final e
              in mapData[LandLayerType.earthquakeInformationSubdivisionArea]!
                  .projectedPolygonFeatures) {
            final regionIntensity = regions.firstWhereOrNull(
              (cityIntensity) => cityIntensity.code == e.code.toString(),
            );
            if (regionIntensity != null && regionIntensity.maxInt != null) {
              result.add(
                (
                  color: colorModel.fromJmaIntensity(regionIntensity.maxInt!),
                  codes: [
                    e.code.toString().padLeft(3, '0'),
                  ],
                  intensity: regionIntensity.maxInt!,
                ),
              );
            }
          }
          // 同じ色の地域をまとめる
          final grouped = groupBy<_RegionColorItem, JmaIntensity>(
            result,
            (e) => e.intensity,
          ).entries.map((e) {
            final codes = <String>[];
            for (final item in e.value) {
              codes.addAll(item.codes);
            }
            return (
              color: e.value.first.color,
              codes: codes,
              intensity: e.key,
            );
          }).toList();
          return grouped;
        }
      },
      [intensity],
    );
    /*
    final regionsLpgmItem = useMemoized(
      () {
        final lgIntensity = item.earthquake.lgIntensity;
        if (lgIntensity == null) {
          return null;
        }
        // regionsの探索
        {
          final regions = lgIntensity.regions;
          final result = <_RegionLpgmColorItem>[];
          for (final e
              in mapData[LandLayerType.earthquakeInformationSubdivisionArea]!
                  .projectedPolygonFeatures) {
            final regionIntensity = regions.firstWhereOrNull(
              (cityIntensity) => cityIntensity.code == e.code.toString(),
            );
            if (regionIntensity != null && regionIntensity.maxLgInt != null) {
              result.add(
                (
                  color:
                      colorModel.fromJmaLgIntensity(regionIntensity.maxLgInt!),
                  codes: [
                    e.code.toString().padLeft(3, '0'),
                  ],
                  intensity: regionIntensity.maxLgInt!,
                ),
              );
            }
          }
          // 同じ色の地域をまとめる
          final grouped = groupBy<_RegionLpgmColorItem, JmaLgIntensity>(
            result,
            (e) => e.intensity,
          ).entries.map((e) {
            final codes = <String>[];
            for (final item in e.value) {
              codes.addAll(item.codes);
            }
            return (
              color: e.value.first.color,
              codes: codes,
              intensity: e.key,
            );
          }).toList();
          return grouped;
        }
      },
      [intensity],
    );
    */
    final stationsItem = useMemoized(
      () {
        final stations = intensity?.stations;
        if (stations == null) {
          return null;
        }
        final allStations = earthquakeParams.regions
            .map(
              (region) => region.cities.map(
                (city) => city.stations,
              ),
            )
            .flattened
            .flattened;
        final stationsParamMerged = stations.map(
          (e) => (
            item: e,
            param: allStations.firstWhereOrNull(
              (element) => element.code == e.code,
            ),
          ),
        );
        final grouped = stationsParamMerged.groupListsBy((e) => e.item.maxInt);
        return grouped;
      },
      [intensity],
    );

    final mapController = useState<MaplibreMapController?>(null);
    final bounds = useMemoized(
      () => _getShowBounds(item, mapData),
      [item, mapData],
    );
    useEffect(
      () {
        WidgetsBinding.instance.endOfFrame.then(
          (_) => registerNavigateToHome(() {
            final controller = mapController.value;
            if (controller == null) {
              return;
            }
            controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    (bounds.northEast.lat + bounds.southWest.lat) / 2,
                    (bounds.northEast.lon + bounds.southWest.lon) / 2,
                  ),
                  zoom: 6,
                ),
              ),
            );
          }),
        );
        return null;
      },
      [],
    );

    return RepaintBoundary(
      child: MaplibreMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            (bounds.northEast.lat + bounds.southWest.lat) / 2,
            (bounds.northEast.lon + bounds.southWest.lon) / 2,
          ),
          zoom: 6,
        ),
        styleString: path,
        onMapCreated: (controller) => mapController.value = controller,
        onStyleLoadedCallback: () async {
          final controller = mapController.value!;

          await [
            addImageFromBuffer(
              controller,
              'hypocenter',
              hypocenterIconRender,
            ),
            for (final intensity in JmaIntensity.values)
              addImageFromBuffer(
                controller,
                'intensity-${intensity.type}',
                intensityIconData.getOrNull(intensity)!,
              ),
            for (final intensity in JmaIntensity.values)
              addImageFromBuffer(
                controller,
                'intensity-${intensity.type}-fill',
                intensityIconFillData.getOrNull(intensity)!,
              ),
          ].wait;

          await _FillAction(
            citiesItem: citiesItem,
            regionsItem: regionsItem,
            earthquake: earthquake,
          ).init(
            controller,
          );

          if (stationsItem != null) {
            await _StationAction(
              citiesItem: citiesItem,
              regionsItem: regionsItem,
              earthquake: earthquake,
              stations: stationsItem,
              colorModel: colorModel,
            ).init(
              controller,
            );
          }

          await _HypocenterAction(
            citiesItem: citiesItem,
            regionsItem: regionsItem,
            earthquake: earthquake,
          ).init(
            controller,
          );
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }
}

lat_lng.LatLngBoundary _getShowBounds(
  EarthquakeHistoryItem item,
  Map<LandLayerType, ZoomCachedProjectedFeatureLayer> mapData,
) {
  if (item.earthquake.intensity != null) {
    final map = mapData[LandLayerType.earthquakeInformationSubdivisionArea]!;
    final result = <lat_lng.LatLng>[];
    final onlyOver4 = item.earthquake.intensity!.maxInt > JmaIntensity.four;
    for (final region in item.earthquake.intensity!.regions.where(
      (element) =>
          (!onlyOver4 || element.maxInt! > JmaIntensity.four) &&
          element.maxInt != null,
    )) {
      final e = map.projectedPolygonFeatures
          .firstWhere((e) => e.code.toString() == region.code);
      result.addAll([e.bbox.northEast, e.bbox.southWest]);
    }
    return lat_lng.LatLngBoundary.fromList(result);
  }
  if (item.earthquake.earthquake != null &&
      item.earthquake.earthquake!.hypocenter.coordinate != null) {
    final lists = [
      const lat_lng2.Distance().offset(
        lat_lng2.LatLng(
          item.earthquake.earthquake!.hypocenter.coordinate!.lat,
          item.earthquake.earthquake!.hypocenter.coordinate!.lon,
        ),
        100 * 1000,
        360 - 45,
      ),
      const lat_lng2.Distance().offset(
        lat_lng2.LatLng(
          item.earthquake.earthquake!.hypocenter.coordinate!.lat,
          item.earthquake.earthquake!.hypocenter.coordinate!.lon,
        ),
        100 * 1000,
        90 + 45,
      ),
    ];
    return lat_lng.LatLngBoundary.fromList(
      lists
          .map(
            (e) => lat_lng.LatLng(e.latitude, e.longitude),
          )
          .toList(),
    );
  }

  final lists = [
    const lat_lng.LatLng(45.3, 145.1),
    const lat_lng.LatLng(30, 128.8),
  ];
  return lat_lng.LatLngBoundary.fromList(lists);
}

sealed class _MapLibreAction {
  _MapLibreAction({
    required this.citiesItem,
    required this.regionsItem,
    required this.earthquake,
  });

  final List<
          ({List<String> codes, TextColorModel color, JmaIntensity intensity})>?
      citiesItem;
  final List<
          ({List<String> codes, TextColorModel color, JmaIntensity intensity})>?
      regionsItem;
  final EarthquakeData earthquake;

  Future<void> init(
    MaplibreMapController controller,
  );

  Future<void> dispose(MaplibreMapController controller);
}

class _FillAction extends _MapLibreAction {
  _FillAction({
    required super.citiesItem,
    required super.regionsItem,
    required super.earthquake,
  });

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震度分布塗りつぶし (市区町村)
    if (citiesItem != null) {
      const name = 'areaInformationCityQuake';
      for (final item in citiesItem!) {
        await controller.removeLayer(
          '$name-fill-${item.color.background.toHexStringRGB()}-'
          '${item.intensity.type}',
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-fill-${item.color.background.toHexStringRGB()}-'
              '${item.intensity.type}',
          FillLayerProperties(
            fillColor: item.color.background.toHexStringRGB(),
          ),
          belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          sourceLayer: name,
          filter: [
            'in',
            ['get', 'regioncode'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-line-${item.color.foreground.toHexStringRGB()}-'
              '${item.intensity.type}',
          LineLayerProperties(
            lineWidth: 0.4,
            lineColor: item.color.foreground.toHexStringRGB(),
            lineOpacity: 0.2,
          ),
          belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          sourceLayer: name,
          filter: [
            'in',
            ['get', 'regioncode'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
      }
    } else if (regionsItem != null) {
      const name = 'areaForecastLocalE';
      for (final item in regionsItem!) {
        await controller.removeLayer(
          '$name-fill-${item.color.background.toHexStringRGB()}-'
          '${item.intensity.type}',
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-fill-${item.color.background.toHexStringRGB()}-'
              '${item.intensity.type}',
          FillLayerProperties(
            fillColor: item.color.background.toHexStringRGB(),
          ),
          sourceLayer: name,
          belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          filter: [
            'in',
            ['get', 'code'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-line-${item.color.foreground.toHexStringRGB()}${item.intensity.type}',
          LineLayerProperties(
            lineWidth: 0.4,
            lineColor: item.color.foreground.toHexStringRGB(),
            lineOpacity: 0.8,
          ),
          sourceLayer: name,
          belowLayerId: BaseLayer.areaForecastLocalEewLine.name,
          filter: [
            'in',
            ['get', 'regioncode'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
      }
    }
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) async {}
}

class _StationAction extends _MapLibreAction {
  _StationAction({
    required super.citiesItem,
    required super.regionsItem,
    required super.earthquake,
    required this.stations,
    required this.colorModel,
  });

  final Map<JmaIntensity?,
          List<({RegionIntensity item, EarthquakeParameterStationItem? param})>>
      stations;
  final IntensityColorModel colorModel;

  @override
  Future<void> init(
    map_libre.MaplibreMapController controller,
  ) async {
    await controller.setSymbolIconAllowOverlap(true);
    await controller.setSymbolIconIgnorePlacement(true);
    await controller.addGeoJsonSource(
      'station-intensity',
      {
        'type': 'FeatureCollection',
        'features': stations.entries
            .map((e) {
              final color = e.key == null
                  ? const TextColorModel(
                      background: Color(0x00000000),
                      foreground: Color(0x00000000),
                    )
                  : colorModel.fromJmaIntensity(e.key!);
              return e.value.map(
                (point) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [
                      point.param?.longitude ?? 0,
                      point.param?.latitude ?? 0,
                    ],
                  },
                  'properties': {
                    'color': color.background.toHexStringRGB(),
                    'intensity': e.key?.type,
                    'name': point.param?.name,
                  },
                },
              );
            })
            .flattened
            .toList(),
      },
    );
    for (final intensity in JmaIntensity.values) {
      await controller.removeLayer('station-intensity-${intensity.type}');
      await controller.addLayer(
        'station-intensity',
        'station-intensity-${intensity.type}',
        SymbolLayerProperties(
          iconImage: 'intensity-${intensity.type}',
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            6,
            1,
            20,
            2,
          ],
          iconOpacity: [
            'step',
            ['zoom'],
            0.0,
            7,
            1.0,
          ],
          textAllowOverlap: true,
          iconAllowOverlap: true,
        ),
        filter: [
          '==',
          'intensity',
          intensity.type,
        ],
        sourceLayer: 'station-intensity',
      );

      await controller.addLayer(
        'station-intensity',
        'station-intensity-${intensity.type}-circle',
        SymbolLayerProperties(
          iconImage: 'intensity-${intensity.type}-fill',
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            2,
          ],
          iconOpacity: [
            'step',
            ['zoom'],
            1.0,
            7,
            0.0,
          ],
          textAllowOverlap: true,
          iconAllowOverlap: true,
        ),
        filter: [
          '==',
          'intensity',
          intensity.type,
        ],
        sourceLayer: 'station-intensity',
      );
    }
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) => [
        controller.removeSource('station-intensity'),
        controller.removeLayer('station-intensity'),
        for (final intensity in JmaIntensity.values)
          controller.removeLayer('station-intensity-${intensity.type}'),
      ].wait;
}

class _HypocenterAction extends _MapLibreAction {
  _HypocenterAction({
    required super.citiesItem,
    required super.regionsItem,
    required super.earthquake,
  });

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震源地
    final hypocenter = earthquake.earthquake?.hypocenter;
    if (hypocenter != null) {
      final coord = hypocenter.coordinate;
      if (coord != null) {
        await controller.setSymbolIconAllowOverlap(true);
        await controller.setSymbolIconIgnorePlacement(true);
        await controller.addGeoJsonSource('hypocenter', {
          'type': 'FeatureCollection',
          'features': [
            {
              'type': 'Feature',
              'geometry': {
                'type': 'Point',
                'coordinates': [coord.lon, coord.lat],
              },
              'properties': {
                'magnitude':
                    earthquake.earthquake?.magnitude.value.toString() ??
                        earthquake.earthquake?.magnitude.condition ??
                        '調査中',
              },
            }
          ],
        });
        await controller.addSymbolLayer(
          'hypocenter',
          'hypocenter',
          const SymbolLayerProperties(
            iconImage: 'hypocenter',
            iconSize: [
              'interpolate',
              ['linear'],
              ['zoom'],
              3,
              0.3,
              20,
              5,
            ],
            iconOpacity: [
              'interpolate',
              ['linear'],
              ['zoom'],
              6,
              1.0,
              10,
              0.5,
            ],
            iconAllowOverlap: true,
          ),
        );
      }
    }
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) => (
        controller.removeSource('hypocenter'),
        controller.removeLayer('hypocenter')
      ).wait;
}

/*
class _FillLpgmAction extends _MapLibreAction {
  _FillLpgmAction({
    required super.citiesItem,
    required super.regionsItem,
    required super.earthquake,
    required this.regionsLpgmItem,
  });

  final List<_RegionLpgmColorItem> regionsLpgmItem;

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震度分布塗りつぶし (市区町村)
    if (regionsItem != null) {
      const name = 'areaForecastLocalE';
      for (final item in regionsLpgmItem) {
        await controller.removeLayer(
          '$name-fill-${item.color.background.toHexStringRGB()}-'
          '${item.intensity.type}',
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-fill-${item.color.background.toHexStringRGB()}-'
              '${item.intensity.type}-lpgm',
          FillLayerProperties(
            fillColor: item.color.background.toHexStringRGB(),
          ),
          sourceLayer: name,
          belowLayerId: 'areaForecastLocalEew_line',
          filter: [
            'in',
            ['get', 'code'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
        await controller.addLayer(
          'eqmonitor_map',
          '$name-line-${item.color.foreground.toHexStringRGB()}${item.intensity.type}',
          LineLayerProperties(
            lineWidth: 0.4,
            lineColor: item.color.foreground.toHexStringRGB(),
            lineOpacity: 0.8,
          ),
          sourceLayer: name,
          belowLayerId: 'areaForecastLocalEew_line',
          filter: [
            'in',
            ['get', 'regioncode'],
            [
              'literal',
              item.codes,
            ],
          ],
        );
      }
    }
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) async {}
}

*/
