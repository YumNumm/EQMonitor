// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/map_libre/provider/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final earthquake = item.earthquake;
    final intensity = earthquake.intensity;
    final colorModel = ref.watch(intensityColorProvider);
    final citiesItem = useMemoized(() {
      if (intensity == null) {
        return null;
      }
      // cities
      if (intensity.cities == null) {
        return null;
      }
      final cities = intensity.cities!;
      final result = <_RegionColorItem>[];
      for (final e in mapData[LandLayerType.municipalityEarthquakeTsunamiArea]!
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
    });
    final regionsItem = useMemoized(() {
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
    });
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mapStyle = ref.watch(mapStyleProvider);
    final styleJsonFuture = useFuture(mapStyle.getStyle(isDark: isDark));
    final path = styleJsonFuture.data;
    if (path == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final isInitialized = useState(false);

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

    final map = RepaintBoundary(
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

          await addImageFromAsset(
            controller,
            'hypocenter',
            'assets/images/hypocenter.png',
          );
          await _FillAction(
            citiesItem: citiesItem,
            regionsItem: regionsItem,
            earthquake: earthquake,
          ).init(
            controller,
          );
          isInitialized.value = true;
          return;
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );

    return Stack(
      children: [
        map,
        if (!isInitialized.value)
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
      ],
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
              6,
              0.2,
              20,
              2,
            ],
            iconOpacity: [
              'interpolate',
              ['linear'],
              ['zoom'],
              20,
              1,
              25,
              0.4,
            ],
            iconAllowOverlap: true,
          ),
        );
      }
    }

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
          belowLayerId: 'areaForecastLocalEew_line',
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
          belowLayerId: 'areaForecastLocalEew_line',
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

class _StationAction extends _MapLibreAction {
  _StationAction({
    required super.citiesItem,
    required super.regionsItem,
    required super.earthquake,
  });

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> init(map_libre.MaplibreMapController controller) {
    // TODO: implement init
    throw UnimplementedError();
  }
}
