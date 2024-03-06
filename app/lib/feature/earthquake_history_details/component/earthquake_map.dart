// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/extension/lat_lng_bounds_list.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/earthquake_history_config_provider.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/map_style.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart' as jma_map;
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
    required this.item,
    required this.showIntensityIcon,
    required this.registerNavigateToHome,
    super.key,
  });

  final EarthquakeV1Extended item;
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
    final colorModel = ref.watch(intensityColorProvider);
    final earthquakeParams =
        ref.watch(jmaParameterProvider).valueOrNull?.earthquake;
    final intensityIconData = ref.watch(intensityIconRenderProvider);
    final intensityIconFillData = ref.watch(intensityIconFillRenderProvider);
    final lpgmIntensityIconData = ref.watch(lpgmIntensityIconRenderProvider);
    final lpgmIntensityIconFillData =
        ref.watch(lpgmIntensityIconFillRenderProvider);

    final hypocenterIconRender = ref.watch(hypocenterIconRenderProvider);
    final jmaMap = ref.watch(jmaMapProvider).valueOrNull;
    final mapStyle = ref.watch(mapStyleProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final styleJsonFutureing = useMemoized(
      () => mapStyle.getStyle(
        isDark: isDark,
        scheme: Theme.of(context).colorScheme,
      ),
      [isDark],
    );
    final styleJsonFuture = useFuture(styleJsonFutureing);
    final path = styleJsonFuture.data;

    if (earthquakeParams == null ||
        !intensityIconData.isAllRendered() ||
        !intensityIconFillData.isAllRendered() ||
        !lpgmIntensityIconData.isAllRendered() ||
        !lpgmIntensityIconFillData.isAllRendered() ||
        jmaMap == null ||
        hypocenterIconRender == null ||
        path == null) {
      // どれが条件を満たしていないのか表示
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final itemCalcurateFutureing = useMemoized(
      () {
        return _compute(colorModel, item, earthquakeParams);
      },
      [item, jmaMap],
    );
    final itemCalcurateFuture = useFuture(itemCalcurateFutureing);
    final result = itemCalcurateFuture.data;
    if (itemCalcurateFuture.hasError) {
      return Scaffold(
        body: Center(
          child: Text('地図情報の取得に失敗しました\nエラー: ${itemCalcurateFuture.error}'),
        ),
      );
    }
    if (result == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    final (
      regionsItem,
      citiesItem,
      stationsItem,
      regionsLpgmItem,
      stationsLpgmItem
    ) = result;
    final bbox = useMemoized(
      () {
        final maxInt = item.maxIntensity;
        if (maxInt == null || regionsItem == null) {
          return null;
        }

        // 最大震度5弱以上の場合、最大震度4以上の地域を表示する
        final codes = regionsItem.map((e) => e.codes).flattened.toList();
        final bboxs = codes
            .map(
              (e) => jmaMap[JmaMapType.areaForecastLocalE]!
                  .firstWhereOrNull((region) => region.property.code == e)
                  ?.bounds,
            )
            .whereNotNull()
            .toList();
        var bbox = bboxs.marge();
        // 震源地を含める
        final (latitude, longitude) = (item.latitude, item.longitude);
        if (latitude != null && longitude != null) {
          bbox = bbox.add(
            jma_map.LatLng(lat: latitude, lng: longitude),
          );
        }
        return bbox;
      },
      [regionsItem],
    );

    final mapController = useState<MaplibreMapController?>(null);

    final cameraUpdate = useMemoized(
      () {
        if (bbox == null) {
          final (latitude, longitude) = (item.latitude, item.longitude);
          if (latitude != null && longitude != null) {
            return CameraUpdate.newLatLngZoom(
              map_libre.LatLng(latitude, longitude),
              2,
            );
          } else {
            return CameraUpdate.newLatLngZoom(
              const map_libre.LatLng(35, 139),
              6,
            );
          }
        }
        return CameraUpdate.newLatLngBounds(
          map_libre.LatLngBounds(
            southwest: map_libre.LatLng(
              bbox.southWest.lat,
              bbox.southWest.lng,
            ),
            northeast: map_libre.LatLng(
              bbox.northEast.lat,
              bbox.northEast.lng,
            ),
          ),
          bottom: 10,
          left: 10,
          right: 10,
          top: 10,
        );
      },
      [bbox, item],
    );

    // * Display mode related
    List<_Action> getActions(EarthquakeHistoryDetailConfig config) => [
          _HypocenterAction(
            earthquake: item,
          ),
          if (config.showingLpgmIntensity) ...[
            if (config.intensityFillMode != IntensityFillMode.none)
              _FillRegionLpgmIntensityAction(
                regionsItem: regionsLpgmItem ?? [],
              ),
            if (config.showIntensityIcon)
              _StationIntensityLpgmAction(
                stations: stationsLpgmItem ?? {},
                colorModel: colorModel,
              ),
          ] else ...[
            if (config.intensityFillMode == IntensityFillMode.fillCity)
              if (citiesItem != null)
                _FillCityAction(
                  citiesItem: citiesItem,
                )
              else
                _FillRegionAction(
                  regionsItem: regionsItem ?? [],
                ),
            if (config.intensityFillMode == IntensityFillMode.fillRegion)
              _FillRegionAction(
                regionsItem: regionsItem ?? [],
              ),
            if (config.showIntensityIcon)
              _StationAction(
                stations: stationsItem ?? {},
                colorModel: colorModel,
              ),
          ],
        ];
    final config = ref.watch(
      earthquakeHistoryConfigProvider.select((value) => value.detail),
    );
    final currentActions = useState<List<_Action>>(getActions(config));

    Future<void> disposeActions(List<_Action> actions) async {
      for (final action in actions) {
        await action.dispose(mapController.value!);
      }
    }

    Future<void> initActions(List<_Action> actions) async {
      await actions
          .map<Future<void>>(
            (e) => e.init(mapController.value!),
          )
          .wait;
    }

    Future<void> onDisplayModeChanged({
      required map_libre.MaplibreMapController controller,
      required EarthquakeHistoryDetailConfig config,
    }) async {
      // まずはdispose
      await disposeActions(currentActions.value);
      // 次にinit
      final actions = getActions(config);

      // 状態更新
      currentActions.value = actions;
      await initActions(actions);
    }

    ref.listen(
      earthquakeHistoryConfigProvider.select((v) => v.detail),
      (_, next) async => onDisplayModeChanged(
        controller: mapController.value!,
        config: next,
      ),
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
    final maxZoomLevel = useState<double>(6);

    return RepaintBoundary(
      child: MaplibreMap(
        initialCameraPosition: CameraPosition(
          target: map_libre.LatLng(
            item.latitude ?? 35,
            item.longitude ?? 139,
          ),
          zoom: 7,
        ),
        styleString: path,
        minMaxZoomPreference: MinMaxZoomPreference(0, maxZoomLevel.value),
        onMapCreated: (controller) async {
          mapController.value = controller;
        },
        onStyleLoadedCallback: () async {
          final controller = mapController.value!;
          await [
            addImageFromBuffer(
              controller,
              'hypocenter',
              hypocenterIconRender,
            ),
            for (final intensity in JmaIntensity.values) ...[
              addImageFromBuffer(
                controller,
                'intensity-${intensity.type}',
                intensityIconData.getOrNull(intensity)!,
              ),
              addImageFromBuffer(
                controller,
                'intensity-${intensity.type}-fill',
                intensityIconFillData.getOrNull(intensity)!,
              ),
            ],
            for (final intensity in JmaLgIntensity.values) ...[
              addImageFromBuffer(
                controller,
                'lpgm-intensity-${intensity.type}',
                lpgmIntensityIconData.getOrNull(intensity)!,
              ),
              addImageFromBuffer(
                controller,
                'lpgm-intensity-${intensity.type}-fill',
                lpgmIntensityIconFillData.getOrNull(intensity)!,
              ),
            ],
          ].wait;
          await initActions(currentActions.value);
          await controller.moveCamera(cameraUpdate);
          maxZoomLevel.value = 12;
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }

  Future<
      (
        List<
            ({
              List<String> codes,
              TextColorModel color,
              JmaIntensity intensity
            })>?,
        List<
            ({
              List<String> codes,
              TextColorModel color,
              JmaIntensity intensity
            })>?,
        Map<
            JmaIntensity?,
            List<
                ({
                  ObservedRegionIntensity item,
                  EarthquakeParameterStationItem? param
                })>>?,
        List<
            ({
              List<String> codes,
              TextColorModel color,
              JmaLgIntensity intensity
            })>?,
        Map<
            JmaLgIntensity?,
            List<
                ({
                  ObservedRegionLpgmIntensity item,
                  EarthquakeParameterStationItem? param
                })>>?
      )> _compute(
    IntensityColorModel colorModel,
    EarthquakeV1Extended earthquake,
    EarthquakeParameter earthquakeParams,
  ) async {
    return compute(
      (arg) {
        final earthquake = arg.$1;
        final earthquakeParams = arg.$2;
        final colorModel = arg.$3;
        final regionsItem = earthquake.intensityRegions
            ?.groupListsBy((e) => e.intensity)
            .entries
            .where((e) => e.key != null)
            .map(
              (e) => (
                color: colorModel.fromJmaIntensity(e.key!),
                codes: e.value.map((e) => e.code.padLeft(3, '0')).toList(),
                intensity: e.key!,
              ),
            )
            .toList();
        final citiesItem = earthquake.intensityCities
            ?.groupListsBy((e) => e.intensity)
            .entries
            .where((e) => e.key != null)
            .map(
              (e) => (
                color: colorModel.fromJmaIntensity(e.key!),
                codes: e.value.map((e) => e.code).toList(),
                intensity: e.key!,
              ),
            )
            .toList();

        final stationsItem = () {
          final stations = earthquake.intensityStations;
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
          final grouped =
              stationsParamMerged.groupListsBy((e) => e.item.intensity);
          return grouped;
        }();

        final regionsLpgmItem = earthquake.lpgmIntensityRegions
            ?.groupListsBy((e) => e.lpgmIntensity)
            .entries
            .where((e) => e.key != null)
            .map(
              (e) => (
                color: colorModel.fromJmaLgIntensity(e.key!),
                codes: e.value.map((e) => e.code.padLeft(3, '0')).toList(),
                intensity: e.key!,
              ),
            )
            .toList();
        final stationsLpgmItem = () {
          final stations = earthquake.lpgmIntenstiyStations;
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
          final grouped =
              stationsParamMerged.groupListsBy((e) => e.item.lpgmIntensity);
          return grouped;
        }();
        return (
          regionsItem,
          citiesItem,
          stationsItem,
          regionsLpgmItem,
          stationsLpgmItem,
        );
      },
      (
        earthquake,
        earthquakeParams,
        colorModel,
      ),
    );
  }
}

sealed class _Action {
  Future<void> init(map_libre.MaplibreMapController controller);
  Future<void> dispose(map_libre.MaplibreMapController controller);
}

class _FillRegionAction extends _Action {
  _FillRegionAction({
    required this.regionsItem,
  });

  final List<_RegionColorItem> regionsItem;

  static const name = 'areaForecastLocalE';
  static String getLineLayerName(JmaIntensity intensity) =>
      '$name-line-${intensity.type}-${intensity.hashCode}';
  static String getFillLayerName(JmaIntensity intensity) =>
      '$name-fill-${intensity.type}-${intensity.hashCode}';

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    await dispose(controller);
    await [
      for (final item in regionsItem) ...[
        controller.addLayer(
          'eqmonitor_map',
          getFillLayerName(item.intensity),
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
        ),
        controller.addLayer(
          'eqmonitor_map',
          getLineLayerName(item.intensity),
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
        ),
      ],
    ].wait;
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) => [
        for (final item in regionsItem) ...[
          controller.removeLayer(
            getLineLayerName(item.intensity),
          ),
          controller.removeLayer(
            getFillLayerName(item.intensity),
          ),
        ],
      ].wait;
}

class _FillCityAction extends _Action {
  _FillCityAction({
    required this.citiesItem,
  });

  final List<_RegionColorItem> citiesItem;

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    await dispose(controller);
    for (final item in citiesItem) {
      await controller.addLayer(
        'eqmonitor_map',
        getFillLayerName(item.intensity),
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
        getLineLayerName(item.intensity),
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

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) => [
        for (final item
            in citiesItem.groupListsBy((e) => e.intensity).entries) ...[
          controller.removeLayer(
            getLineLayerName(item.key),
          ),
          controller.removeLayer(
            getFillLayerName(item.key),
          ),
        ],
      ].wait;

  static String getLineLayerName(JmaIntensity intensity) =>
      '$name-line-${intensity.type}${intensity.hashCode}';
  static String getFillLayerName(JmaIntensity intensity) =>
      '$name-fill-${intensity.type}${intensity.hashCode}';

  static const name = 'areaInformationCityQuake';
}

class _StationAction extends _Action {
  _StationAction({
    required this.stations,
    required this.colorModel,
  });

  final Map<
      JmaIntensity?,
      List<
          ({
            ObservedRegionIntensity item,
            EarthquakeParameterStationItem? param
          })>> stations;
  final IntensityColorModel colorModel;

  @override
  Future<void> init(
    map_libre.MaplibreMapController controller,
  ) async {
    await dispose(controller);
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
      await controller.addLayer(
        'station-intensity',
        'station-intensity-${intensity.type}',
        SymbolLayerProperties(
          iconImage: 'intensity-${intensity.type}',
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            1,
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
            0.1,
            7,
            0.4,
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
        belowLayerId: 'hypocenter',
      );
    }

    await controller.addSymbolLayer(
      'station-intensity',
      'station-intensity-symbol',
      SymbolLayerProperties(
        textField: ['get', 'name'],
        textSize: 12,
        textHaloColor: Colors.white.toHexStringRGB(),
        textHaloWidth: 0.5,
        textOffset: [
          map_libre.Expressions.literal,
          [0, 2],
        ],
      ),
      sourceLayer: 'station-intensity',
      minzoom: 10,
    );
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) async {
    // Layer
    await [
      for (final intensity in JmaIntensity.values)
        controller.removeLayer('station-intensity-${intensity.type}'),
      for (final intensity in JmaIntensity.values)
        controller.removeLayer('station-intensity-${intensity.type}-circle'),
      controller.removeLayer('station-intensity-symbol'),
    ].wait;
    // Source
    await controller.removeSource('station-intensity');
  }
}

class _HypocenterAction extends _Action {
  _HypocenterAction({
    required this.earthquake,
  });

  final EarthquakeV1Extended earthquake;

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    /// 震源地
    final (latitude, longitude) = (earthquake.latitude, earthquake.longitude);
    if (latitude != null && longitude != null) {
      await controller.setSymbolIconAllowOverlap(true);
      await controller.setSymbolIconIgnorePlacement(true);
      await controller.addGeoJsonSource('hypocenter', {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'geometry': {
              'type': 'Point',
              'coordinates': [longitude, latitude],
            },
            'properties': {
              'magnitude': earthquake.magnitude?.toString() ??
                  earthquake.magnitudeCondition ??
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
            1,
          ],
          iconOpacity: [
            'interpolate',
            ['linear'],
            ['zoom'],
            6,
            1.0,
            10,
            0.8,
          ],
          iconAllowOverlap: true,
        ),
      );
    }
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) async {
    await controller.removeLayer('hypocenter');
    await controller.removeSource('hypocenter');
  }
}

class _FillRegionLpgmIntensityAction extends _Action {
  _FillRegionLpgmIntensityAction({
    required this.regionsItem,
  });

  final List<_RegionLpgmColorItem> regionsItem;

  static const name = 'areaForecastLocalE';
  static String getLineLayerName(JmaLgIntensity intensity) =>
      '$name-LPGM-line-${intensity.type}-${intensity.hashCode}';
  static String getFillLayerName(JmaLgIntensity intensity) =>
      '$name-LPGM-fill-${intensity.type}-${intensity.hashCode}';

  @override
  Future<void> init(map_libre.MaplibreMapController controller) async {
    await dispose(controller);
    await [
      for (final item in regionsItem) ...[
        controller.addLayer(
          'eqmonitor_map',
          getFillLayerName(item.intensity),
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
        ),
        controller.addLayer(
          'eqmonitor_map',
          getLineLayerName(item.intensity),
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
        ),
      ],
    ].wait;
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) => [
        for (final item in regionsItem) ...[
          controller.removeLayer(
            getLineLayerName(item.intensity),
          ),
          controller.removeLayer(
            getFillLayerName(item.intensity),
          ),
        ],
      ].wait;
}

class _StationIntensityLpgmAction extends _Action {
  _StationIntensityLpgmAction({
    required this.stations,
    required this.colorModel,
  });

  final Map<
      JmaLgIntensity?,
      List<
          ({
            ObservedRegionLpgmIntensity item,
            EarthquakeParameterStationItem? param
          })>> stations;
  final IntensityColorModel colorModel;

  static const sourceName = 'station-lpgm-intensity';
  static String layerName(JmaLgIntensity intenstiy) =>
      'station-lpgm-intensity-${intenstiy.type}';
  static String circleLayerName(JmaLgIntensity intenstiy) =>
      'station-lpgm-intensity-${intenstiy.type}-circle';
  static const symbolLayerName = 'station-lpgm-intensity-symbol';

  @override
  Future<void> init(
    map_libre.MaplibreMapController controller,
  ) async {
    await dispose(controller);
    await controller.setSymbolIconAllowOverlap(true);
    await controller.setSymbolIconIgnorePlacement(true);
    await controller.addGeoJsonSource(
      sourceName,
      {
        'type': 'FeatureCollection',
        'features': stations.entries
            .map((e) {
              final color = colorModel.fromJmaLgIntensity(e.key!);
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
                    'lgIntensity': e.key?.type,
                    'name': point.param?.name,
                  },
                },
              );
            })
            .flattened
            .toList(),
      },
    );
    for (final intensity in JmaLgIntensity.values) {
      await controller.addLayer(
        sourceName,
        layerName(intensity),
        SymbolLayerProperties(
          iconImage: 'lpgm-intensity-${intensity.type}',
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.3,
            20,
            1,
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
          'lgIntensity',
          intensity.type,
        ],
        sourceLayer: sourceName,
        minzoom: 7,
      );

      await controller.addLayer(
        sourceName,
        circleLayerName(intensity),
        SymbolLayerProperties(
          iconImage: 'lpgm-intensity-${intensity.type}-fill',
          iconSize: [
            'interpolate',
            ['linear'],
            ['zoom'],
            3,
            0.1,
            7,
            0.4,
          ],
          iconOptional: 0.8,
          textAllowOverlap: true,
          iconAllowOverlap: true,
        ),
        maxzoom: 7,
        filter: [
          '==',
          'lgIntensity',
          intensity.type,
        ],
        sourceLayer: sourceName,
      );
    }

    await controller.addSymbolLayer(
      sourceName,
      symbolLayerName,
      SymbolLayerProperties(
        textField: ['get', 'name'],
        textSize: 12,
        textHaloColor: Colors.white.toHexStringRGB(),
        textHaloWidth: 0.5,
        textOffset: [
          map_libre.Expressions.literal,
          [0, 2],
        ],
      ),
      sourceLayer: sourceName,
      minzoom: 10,
    );
  }

  @override
  Future<void> dispose(map_libre.MaplibreMapController controller) async {
    // Layer
    await [
      for (final intensity in JmaLgIntensity.values)
        controller.removeLayer(layerName(intensity)),
      for (final intensity in JmaLgIntensity.values)
        controller.removeLayer(circleLayerName(intensity)),
      controller.removeLayer(symbolLayerName),
    ].wait;
    // Source
    await controller.removeSource(sourceName);
  }
}
