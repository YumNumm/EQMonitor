import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_camera_controller.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_legend.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_popup.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_map_display_mode_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_intensity_icon_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryDetailsMapView extends HookConsumerWidget {
  const EarthquakeHistoryDetailsMapView({
    required this.earthquake,
    required this.eventId,
    super.key,
  });

  final Earthquake earthquake;
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
        earthquake: earthquake,
        eventId: eventId,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({
    required this.styleString,
    required this.earthquake,
    required this.eventId,
  });

  final String styleString;
  final Earthquake earthquake;
  final String eventId;

  static const _stationLayerId = 'eq-history-station-intensity-circle';
  static const _regionFillLayerId = 'eq-history-fill-region';
  static const _cityFillLayerId = 'eq-history-fill-city';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config =
        ref.watch(
          earthquakeHistoryConfigProvider.select((v) => v.value?.detail),
        ) ??
        const EarthquakeHistoryDetailConfig();
    final jmaMapAsync = ref.watch(jmaMapProvider);

    final tileUrl = earthquake.estimatedIntensityTileUrl;

    // エフェメラル override 状態: 画面を開いたとき tileUrl があり、且つ設定で有効なら true
    final isOverriding = useState(
      tileUrl != null && config.useEstimatedIntensityWhenAvailable,
    );

    final center = initialGeographicForEarthquake(earthquake);
    final zoom = initialZoomForEarthquake(earthquake);
    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: zoom,
      initStyle: styleString,
    );

    final intensity = earthquake.intensity;

    // データ可用性に応じた iconMode のフォールバック解決
    final hasCityData =
        intensity != null &&
        intensity.intensityTree.values.any(
          (r) => r.any((n) => n.cities.isNotEmpty),
        );
    final hasStationData =
        intensity != null &&
        intensity.intensityTree.values.any(
          (r) => r.any((n) => n.cities.any((c) => c.stations.isNotEmpty)),
        );

    final resolvedIconMode = switch (config.iconMode) {
      EarthquakeHistoryIconMode.station when !hasStationData =>
        EarthquakeHistoryIconMode.region,
      EarthquakeHistoryIconMode.municipality when !hasCityData =>
        EarthquakeHistoryIconMode.region,
      _ => config.iconMode,
    };

    // 推計震度タイル表示中は塗りつぶしを強制 none
    final effectiveFillMode = (tileUrl != null && isOverriding.value)
        ? EarthquakeHistoryFillMode.none
        : config.fillMode;

    final hypocenterLayer = EarthquakeHistoryHypocenterLayer(
      earthquake: earthquake,
      displayMode: config.hypocenterDisplayMode,
    );

    void openModal(BuildContext ctx) {
      unawaited(
        EarthquakeHistoryMapDisplayModeModal.show(
          context: ctx,
          hasLpgmIntensity: earthquake.intensity?.maxLpgmIntensity != null,
          hasTileUrl: tileUrl != null,
        ),
      );
    }

    return MapLibreEventProvider(
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              MapLibreMap(
                options: mapOptions,
                onEvent: (event) {
                  MapLibreEventProvider.of(context).emit(event);
                  if (event is MapEventClick) {
                    _handleTap(
                      context: context,
                      event: event,
                      config: config,
                      effectiveFillMode: effectiveFillMode,
                      jmaMap: jmaMapAsync.value,
                    );
                  }
                },
                children: [
                  // 塗りつぶし（最背面）
                  if (effectiveFillMode ==
                          EarthquakeHistoryFillMode.matchIcon &&
                      intensity != null)
                    EarthquakeHistoryFillLayer(
                      intensity: intensity,
                      iconMode: resolvedIconMode,
                      showingLpgmIntensity: config.showingLpgmIntensity,
                    ),
                  // 地域・市区町村アイコン（塗りつぶしの上）
                  if (intensity != null)
                    EarthquakeHistoryIntensityIconLayer(
                      intensity: intensity,
                      iconMode: resolvedIconMode,
                      hasStationData: hasStationData,
                      showingLpgmIntensity: config.showingLpgmIntensity,
                    ),
                  // 推計震度ラスタ
                  if (tileUrl != null)
                    EarthquakeHistoryDetailsEstimatedIntensityLayer(
                      tileUrl: tileUrl,
                    ),
                  // 震央誤差矩形
                  if (config.showHypocenterError)
                    EarthquakeHistoryHypocenterErrorLayer(
                      earthquake: earthquake,
                    ),
                  // 観測点・震央（z 順を HypocenterDisplayMode で制御）
                  if (config.hypocenterDisplayMode ==
                      HypocenterDisplayMode.belowStations)
                    hypocenterLayer,
                  if (intensity != null && config.showStation)
                    EarthquakeHistoryStationIntensityLayer(
                      intensity: intensity,
                      iconMode: resolvedIconMode,
                      stationDisplayMode: config.stationDisplayMode,
                      showLabel: config.showStationLabel,
                      showingLpgmIntensity: config.showingLpgmIntensity,
                    ),
                  if (config.hypocenterDisplayMode !=
                      HypocenterDisplayMode.belowStations)
                    hypocenterLayer,
                  EarthquakeHistoryDetailsMapCameraController(
                    eventId: eventId,
                    earthquake: earthquake,
                  ),
                ],
              ),

              // 推計震度表示中バナー（右上）— タップで override を解除
              if (tileUrl != null && isOverriding.value)
                Positioned(
                  top: 8,
                  right: 8,
                  child: SafeArea(
                    child: FilledButton.tonal(
                      onPressed: () => isOverriding.value = false,
                      child: const Text('推計震度データ表示中'),
                    ),
                  ),
                ),

              // コントローラカード（右上）
              Positioned(
                top: tileUrl != null && isOverriding.value ? 56 : 8,
                right: 8,
                child: SafeArea(
                  child: _MapControllerCard(
                    onLayersTap: () => openModal(context),
                    onFitBoundsTap: () => _fitBounds(context),
                  ),
                ),
              ),

              // 震度凡例（右下）
              if (config.showLegend)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: SafeArea(
                    child: EarthquakeHistoryMapLegend(
                      intensity: earthquake.intensity,
                      showingLpgmIntensity: config.showingLpgmIntensity,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _handleTap({
    required BuildContext context,
    required MapEventClick event,
    required EarthquakeHistoryDetailConfig config,
    required EarthquakeHistoryFillMode effectiveFillMode,
    required Map<JmaMapType, JmaMap_JmaMapData>? jmaMap,
  }) {
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }

    final hits = controller.queryLayers(event.screenPoint);
    if (hits.isEmpty) {
      return;
    }

    final hitIds = hits.map((h) => h.layerId).toSet();

    // 観測点タップ
    if (hitIds.contains(_stationLayerId)) {
      final stationNode = _findNearestStation(event.point);
      if (stationNode == null) {
        return;
      }
      unawaited(
        showStationPopup(
          context,
          stationName: stationNode.station.name,
          intensity: stationNode.intensity?.maxIntensity,
          lpgmIntensity: stationNode.intensity?.maxLpgmIntensity,
        ),
      );
      return;
    }

    // 塗りつぶしレイヤータップ（塗りつぶし表示中のみ）
    if (effectiveFillMode == EarthquakeHistoryFillMode.none || jmaMap == null) {
      return;
    }
    final isCity = hitIds.contains(_cityFillLayerId);
    final isRegion = hitIds.contains(_regionFillLayerId);
    if (!isCity && !isRegion) {
      return;
    }

    final mapData = isCity
        ? jmaMap.areaInformationCity
        : jmaMap.areaForecastLocalE;
    final latLng = JmaMap_LatLng(
      lat: event.point.lat,
      lng: event.point.lon,
    );
    final result = JmaMapUtility().findNearestItem(latLng, mapData);
    final item = result.item;
    if (item == null) {
      return;
    }

    final code = item.property.code;
    final name = item.property.name;

    if (isCity) {
      final cityNode = _findCityByCode(code);
      unawaited(
        showAreaPopup(
          context,
          areaName: name,
          maxIntensity: cityNode?.maxIntensity,
        ),
      );
    } else {
      final region = earthquake.intensity?.regions.firstWhereOrNull(
        (r) => r.region.code == code,
      );
      unawaited(
        showAreaPopup(
          context,
          areaName: name,
          maxIntensity: region?.maxIntensity,
        ),
      );
    }
  }

  StationIntensityNode? _findNearestStation(Geographic point) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return null;
    }

    StationIntensityNode? nearest;
    var minDist = double.infinity;

    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          for (final stationNode in city.stations) {
            final station = stationNode.station;
            if (!station.hasLatitude() || !station.hasLongitude()) {
              continue;
            }
            final dist =
                math.pow(station.latitude - point.lat, 2) +
                math.pow(station.longitude - point.lon, 2);
            if (dist < minDist) {
              minDist = dist.toDouble();
              nearest = stationNode;
            }
          }
        }
      }
    }

    return nearest;
  }

  CityIntensityNode? _findCityByCode(String code) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return null;
    }
    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        for (final city in region.cities) {
          if (city.city.code == code) {
            return city;
          }
        }
      }
    }
    return null;
  }

  void _fitBounds(BuildContext context) {
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }

    final intensity = earthquake.intensity;
    final points = <Geographic>[];

    if (intensity != null) {
      for (final entry in intensity.intensityTree.entries) {
        for (final region in entry.value) {
          for (final city in region.cities) {
            for (final stationNode in city.stations) {
              final s = stationNode.station;
              if (!s.hasLatitude() || !s.hasLongitude()) {
                continue;
              }
              points.add(Geographic(lon: s.longitude, lat: s.latitude));
            }
          }
        }
      }
    }

    final coords = earthquake.hypocenter?.coordinates;
    if (coords is CoordinateLatLng) {
      points.add(Geographic(lon: coords.longitude, lat: coords.latitude));
    }

    if (points.isEmpty) {
      return;
    }

    unawaited(
      controller.fitBounds(
        bounds: LngLatBounds.fromPoints(points),
        padding: const EdgeInsets.all(48),
        webMaxZoom: 10,
      ),
    );
  }
}

/// 地図右上のコントローラカード（レイヤー設定 + Fit to Bounds）
class _MapControllerCard extends StatelessWidget {
  const _MapControllerCard({
    required this.onLayersTap,
    required this.onFitBoundsTap,
  });

  final VoidCallback onLayersTap;
  final VoidCallback onFitBoundsTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Divider(height: 0),
    );

    void haptic() => unawaited(HapticFeedback.lightImpact());

    return Card(
      color: colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                haptic();
                onLayersTap();
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.layers_rounded),
              ),
            ),
            divider,
            InkWell(
              onTap: () {
                haptic();
                onFitBoundsTap();
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.zoom_out_map_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
