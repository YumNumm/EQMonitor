import 'dart:async';
import 'dart:math' as math;

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
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
    super.key,
  });

  final Earthquake earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
        earthquake: earthquake,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({
    required this.styleString,
    required this.earthquake,
  });

  final String styleString;
  final Earthquake earthquake;

  static const _stationLayerId = 'eq-history-station-intensity-circle';
  static const _regionFillLayerId = 'eq-history-fill-region';
  static const _cityFillLayerId = 'eq-history-fill-city';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      earthquakeHistoryConfigProvider.select((v) => v.requireValue.detail),
    );
    final jmaMap = ref.watch(jmaMapProvider).requireValue;

    final builderContextRef = useRef<BuildContext?>(null);
    ref.listen(earthquakeHistoryMapFocusProvider(earthquake.eventId), (_, next) {
      if (next == null) {
        return;
      }
      final ctx = builderContextRef.value;
      if (ctx == null) {
        return;
      }
      final controller = MapController.maybeOf(ctx);
      if (controller == null) {
        return;
      }
      final geo = geographicForEarthquakeIntensityFocus(earthquake, next);
      if (geo == null) {
        return;
      }
      unawaited(
        controller.animateCamera(
          center: geo,
          zoom: kEarthquakeHistoryMapFocusZoom,
        ),
      );
      ref
          .read(earthquakeHistoryMapFocusProvider(earthquake.eventId).notifier)
          .select(null);
    });

    final tileUrl = earthquake.estimatedIntensityTileUrl;

    final center = initialGeographicForEarthquake(earthquake);
    final zoom = initialZoomForEarthquake(earthquake);
    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: zoom,
      initStyle: styleString,
    );
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
          builderContextRef.value = context;
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
                      jmaMap: jmaMap,
                    );
                  }
                },
                children: [
                  EarthquakeHistoryFillLayer(
                    key: const ValueKey('fill'),
                    earthquake: earthquake,
                    config: config,
                  ),
                  // 地域・市区町村アイコン（塗りつぶしの上）
                  EarthquakeHistoryIntensityIconLayer(
                    key: const ValueKey('area-icon'),
                    earthquake: earthquake,
                    config: config,
                  ),
                  // 推計震度
                  if (tileUrl != null)
                    EarthquakeHistoryDetailsEstimatedIntensityLayer(
                      key: const ValueKey('estimated'),
                      tileUrl: tileUrl,
                    ),
                  // 震央誤差矩形
                  if (config.showHypocenterError)
                    EarthquakeHistoryHypocenterErrorLayer(
                      key: const ValueKey('hypocenter-error'),
                      earthquake: earthquake,
                    ),
                  // 観測点・震央（z 順を HypocenterDisplayMode で制御）
                  if (config.hypocenterDisplayMode ==
                      HypocenterDisplayMode.belowStations)
                    hypocenterLayer,
                  if (config.showStation)
                    EarthquakeHistoryStationIntensityLayer(
                      key: const ValueKey('station'),
                      earthquake: earthquake,
                      config: config,
                    ),
                  if (config.hypocenterDisplayMode !=
                      HypocenterDisplayMode.belowStations)
                    hypocenterLayer,
                ],
              ),

              // コントローラカード（右上）
              Positioned(
                top: 8,
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
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
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

    final isCity = hitIds.contains(_cityFillLayerId);
    final isRegion = hitIds.contains(_regionFillLayerId);
    if (!isCity && !isRegion) {
      return;
    }

    final mapData = isCity
        ? jmaMap.areaInformationCity
        : jmaMap.areaForecastLocalE;
    final latLng = JmaMap_LatLng(lat: event.point.lat, lng: event.point.lon);
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
      final region = _findRegionByCode(code);
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

  IntensityRegion? _findRegionByCode(String code) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return null;
    }
    for (final entry in intensity.intensityTree.entries) {
      for (final region in entry.value) {
        if (region.region.region.code == code) {
          return region.region;
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

    void haptic() => unawaited(
      HapticFeedback.lightImpact(),
    );

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
