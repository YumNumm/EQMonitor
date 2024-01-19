// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/lat_lng_bounds_list.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/map_style.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as map_libre;
import 'package:maplibre_gl/maplibre_gl.dart';

typedef _RegionColorItem = ({
  TextColorModel color,
  List<String> codes,
  JmaIntensity intensity,
});

typedef _RegionLpgmColorItem = ({
  TextColorModel color,
  List<String> codes,
  JmaLgIntensity intensity,
});

class EarthquakeMapWidget extends HookConsumerWidget {
  const EarthquakeMapWidget({
    super.key,
    required this.item,
    required this.showIntensityIcon,
    required this.registerNavigateToHome,
  });
  final EarthquakeHistoryItem item;
  final bool showIntensityIcon;
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
    final jmaMap = ref.watch(jmaMapProvider).valueOrNull;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mapStyle = ref.watch(mapStyleProvider);
    final styleJsonFutureing =
        useMemoized(() => mapStyle.getStyle(isDark: isDark), [isDark]);
    final styleJsonFuture = useFuture(styleJsonFutureing);
    final path = styleJsonFuture.data;
    if (earthquakeParams == null ||
        !intensityIconData.isAllRendered() ||
        !intensityIconFillData.isAllRendered() ||
        jmaMap == null ||
        hypocenterIconRender == null ||
        path == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final citiesItem = useMemoized(
      () => intensity?.cities
          ?.groupListsBy((e) => e.maxInt)
          .entries
          .where((e) => e.key != null)
          .map(
            (e) => (
              color: colorModel.fromJmaIntensity(e.key!),
              codes: e.value.map((e) => e.code).toList(),
              intensity: intensity.maxInt,
            ),
          )
          .toList(),
      [intensity],
    );
    final regionsItem = useMemoized(
      () => intensity?.regions
          .groupListsBy((e) => e.maxInt)
          .entries
          .where((e) => e.key != null)
          .map(
            (e) => (
              color: colorModel.fromJmaIntensity(e.key!),
              codes: e.value.map((e) => e.code.padLeft(3, '0')).toList(),
              intensity: intensity.maxInt,
            ),
          )
          .toList(),
      [intensity],
    );
    final regionsLpgmItem = useMemoized(
      () => intensity?.regions
          .groupListsBy((e) => e.maxLgInt)
          .entries
          .where((e) => e.key != null)
          .map(
            (e) => (
              color: colorModel.fromJmaLgIntensity(e.key!),
              codes: e.value.map((e) => e.code.padLeft(3, '0')).toList(),
              intensity: intensity,
            ),
          )
          .toList(),
      [intensity],
    );
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
    final bbox = useMemoized(
      () {
        // 最大震度5弱以上の場合、最大震度4以上の地域を表示する
        final maxInt = intensity?.maxInt;
        if (maxInt == null || regionsItem == null) {
          return null;
        }

        final List<String> codes;
        if (maxInt.index >= JmaIntensity.fiveLower.index) {
          codes = regionsItem
              .where((e) => e.intensity.index >= JmaIntensity.four.index)
              .map((e) => e.codes)
              .flattened
              .toList();
        } else {
          codes = regionsItem
              .where((e) => e.intensity.index >= maxInt.index)
              .map((e) => e.codes)
              .flattened
              .toList();
        }
        final bboxs = codes
            .map(
              (e) => jmaMap[JmaMapType.areaForecastLocalE]!
                  .firstWhereOrNull((region) => region.property.code == e)
                  ?.bounds,
            )
            .whereNotNull()
            .toList();
        final bbox = bboxs.marge();
        return bbox;
      },
      [regionsItem],
    );

    final mapController = useState<MaplibreMapController?>(null);

    final cameraUpdate = useMemoized(
      () => CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            bbox!.southWest.lat,
            bbox.southWest.lng,
          ),
          northeast: LatLng(
            bbox.northEast.lat,
            bbox.northEast.lng,
          ),
        ),
      ),
      [bbox],
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
              cameraUpdate,
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
            earthquake.earthquake?.hypocenter.coordinate?.lat ?? 35,
            earthquake.earthquake?.hypocenter.coordinate?.lon ?? 139,
          ),
          zoom: 6,
        ),
        styleString: path,
        minMaxZoomPreference: const MinMaxZoomPreference(0, 10),
        onMapCreated: (controller) {
          mapController.value = controller;
        },
        onStyleLoadedCallback: () async {
          final controller = mapController.value!;
          await controller.moveCamera(cameraUpdate);
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

          if (citiesItem != null) {
            await _FillCityAction(
              citiesItem: citiesItem,
            ).init(
              controller,
            );
          } else if (regionsItem != null) {
            await _FillRegionAction(
              regionsItem: regionsItem,
            ).init(
              controller,
            );
          }
          if (stationsItem != null) {
            await _StationAction(
              stations: stationsItem,
              colorModel: colorModel,
            ).init(
              controller,
            );
          }

          await _HypocenterAction(
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

class _FillCityAction {
  _FillCityAction({
    required this.citiesItem,
  });

  final List<_RegionColorItem> citiesItem;

  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震度分布塗りつぶし (市区町村)
    await dispose(controller);
    for (final item in citiesItem) {
      await controller.addLayer(
        'eqmonitor_map',
        '$name-fill-${item.hashCode}',
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
        '$name-line-${item.hashCode}',
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
  }

  Future<void> dispose(map_libre.MaplibreMapController controller) async => [
        for (final type in ['fill', 'line'])
          for (final item in citiesItem)
            controller.removeLayer(
              '$name-$type-${item.hashCode}',
            ),
      ].wait;

  static const name = 'areaInformationCityQuake';
}

class _FillRegionAction {
  _FillRegionAction({
    required this.regionsItem,
  });

  final List<_RegionColorItem>? regionsItem;

  Future<void> init(map_libre.MaplibreMapController controller) async {
    if (regionsItem != null) {
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

  Future<void> dispose(map_libre.MaplibreMapController controller) async {}
}

class _StationAction {
  _StationAction({
    required this.stations,
    required this.colorModel,
  });

  final Map<JmaIntensity?,
          List<({RegionIntensity item, EarthquakeParameterStationItem? param})>>
      stations;
  final IntensityColorModel colorModel;

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
        minzoom: 7,
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
          textAllowOverlap: true,
          iconAllowOverlap: true,
        ),
        maxzoom: 7,
        filter: [
          '==',
          'intensity',
          intensity.type,
        ],
        sourceLayer: 'station-intensity',
      );
    }
  }

  Future<void> dispose(map_libre.MaplibreMapController controller) => [
        controller.removeSource('station-intensity'),
        controller.removeLayer('station-intensity'),
        for (final intensity in JmaIntensity.values)
          controller.removeLayer('station-intensity-${intensity.type}'),
      ].wait;
}

class _HypocenterAction {
  _HypocenterAction({
    required this.earthquake,
  });

  final EarthquakeData earthquake;

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

  Future<void> dispose(map_libre.MaplibreMapController controller) => (
        controller.removeSource('hypocenter'),
        controller.removeLayer('hypocenter')
      ).wait;
}

class _FillLpgmAction {
  _FillLpgmAction({
    required this.regionsLpgmItem,
  });

  final List<_RegionLpgmColorItem> regionsLpgmItem;

  static const name = 'areaForecastLocalE';

  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震度分布塗りつぶし (市区町村)
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

  Future<void> dispose(map_libre.MaplibreMapController controller) async {
    await [
      for (final prefix in ['$name-fill', '$name-line'])
        for (final item in regionsLpgmItem)
          controller.removeLayer(
            '$prefix-${item.color.background.toHexStringRGB()}-'
            '${item.intensity.type}-lpgm',
          ),
    ].wait;
  }
}
