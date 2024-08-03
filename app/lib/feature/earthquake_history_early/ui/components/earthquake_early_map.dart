// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqapi_types/model/v1/earthquake_early.dart';
import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/earthquake_history_config_provider.dart';
import 'package:eqmonitor/core/provider/config/earthquake_history/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/map_style.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart' as map_libre;
import 'package:maplibre_gl/maplibre_gl.dart';

class EarthquakeEarlyMapWidget extends HookConsumerWidget {
  const EarthquakeEarlyMapWidget({
    required this.item,
    required this.showIntensityIcon,
    required this.registerNavigateToHome,
    super.key,
  });

  final EarthquakeEarlyEvent item;
  final bool showIntensityIcon;
  final void Function(void Function() func) registerNavigateToHome;

  Future<void> addImageFromAsset(
    MapLibreMapController controller,
    String name,
    String assetName,
  ) async {
    final bytes = await rootBundle.load(assetName);
    final list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  Future<void> addImageFromBuffer(
    MapLibreMapController controller,
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

    final mapController = useState<MapLibreMapController?>(null);

    final cameraUpdate = useMemoized(
      () {
        final (latitude, longitude) = (item.lat, item.lon);
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
      },
      [item],
    );

    final stationsItem = useMemoized(
      () {
        final points =
            item.cities.map((city) => city.observationPoints).flattened;
        return (
          points.groupListsBy((element) => element.intensity),
          points.length
        );
      },
      [item.cities],
    );

    // * Display mode related
    List<_Action> getActions(EarthquakeHistoryDetailConfig config) => [
          _HypocenterAction(
            earthquake: item,
          ),
          ...[
            _StationAction(
              stations: stationsItem.$1,
              showSmallIcon: stationsItem.$2 < 100,
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
      required map_libre.MapLibreMapController controller,
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
          (_) {
            registerNavigateToHome(() {
              final controller = mapController.value;
              if (controller == null) {
                return;
              }
              controller.animateCamera(
                cameraUpdate,
              );
            });
            final controller = mapController.value;
            if (controller == null) {
              return;
            }
            onDisplayModeChanged(
              controller: mapController.value!,
              config: config,
            );
          },
        );
        return null;
      },
      [item],
    );
    final maxZoomLevel = useState<double>(6);

    return RepaintBoundary(
      child: MapLibreMap(
        initialCameraPosition: CameraPosition(
          target: map_libre.LatLng(
            item.lat ?? 35,
            item.lon ?? 139,
          ),
          zoom: 7,
        ),
        styleString: path,
        minMaxZoomPreference: MinMaxZoomPreference(0, maxZoomLevel.value),
        onMapCreated: (controller) => mapController.value = controller,
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
}

sealed class _Action {
  Future<void> init(map_libre.MapLibreMapController controller);
  Future<void> dispose(map_libre.MapLibreMapController controller);
}

class _StationAction extends _Action {
  _StationAction({
    required this.stations,
    required this.colorModel,
    required this.showSmallIcon,
  });

  final Map<JmaForecastIntensity?, List<EarthquakeEarlyObservationPoint>>
      stations;
  final IntensityColorModel colorModel;
  final bool showSmallIcon;

  @override
  Future<void> init(
    map_libre.MapLibreMapController controller,
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
                  : colorModel.fromJmaForecastIntensity(e.key!);
              return e.value.map(
                (point) => {
                  'type': 'Feature',
                  'geometry': {
                    'type': 'Point',
                    'coordinates': [
                      point.lon,
                      point.lat,
                    ],
                  },
                  'properties': {
                    'color': color.background.toHexStringRGB(),
                    'intensity': e.key?.type,
                    'name': point.name,
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
            0.2,
            20,
            1,
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
            0.04,
            7,
            0.3,
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
        textSize: 13,
        textColor: Colors.black.toHexStringRGB(),
        textHaloColor: Colors.white.toHexStringRGB(),
        textHaloWidth: 2,
        textFont: ['Noto Sans CJK JP Bold'],
        textOffset: [
          map_libre.Expressions.literal,
          [0, 2],
        ],
      ),
      sourceLayer: 'station-intensity',
      minzoom: 9,
    );
  }

  @override
  Future<void> dispose(map_libre.MapLibreMapController controller) async {
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

  final EarthquakeEarlyEvent earthquake;

  @override
  Future<void> init(map_libre.MapLibreMapController controller) async {
    final (latitude, longitude) = (earthquake.lat, earthquake.lon);
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
              'magnitude': earthquake.magnitude?.toString(),
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
  Future<void> dispose(map_libre.MapLibreMapController controller) async {
    await controller.removeLayer('hypocenter');
    await controller.removeSource('hypocenter');
  }
}
