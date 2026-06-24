import 'dart:math' as math;

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_legend.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_popup.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryDetailsMapView extends HookConsumerWidget {
  const EarthquakeHistoryDetailsMapView({
    required this.earthquake,
    required this.displayMode,
    super.key,
  });

  final Earthquake earthquake;
  final IntensityDisplayMode displayMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null =>
        MapLibreEventProvider(
          child: _MapContent(
            styleString: value.styleString!,
            earthquake: earthquake,
            displayMode: displayMode,
          ),
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
    required this.displayMode,
  });

  final String styleString;
  final Earthquake earthquake;
  final IntensityDisplayMode displayMode;

  static const _stationLayerId = 'eq-history-station-intensity-circle';
  static const _regionSourceLayerId = 'areaForecastLocalE';
  static const _citySourceLayerId = 'areaInformationCityQuake';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = ref.watch(
      earthquakeHistoryMapLayerParameterProvider.select(
        (v) => v.valueOrNull ?? const EarthquakeHistoryMapLayerParameter(),
      ),
    );
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (v) => v.value?.map ?? const HomeMapSettings(),
      ),
    );
    final isDebugger = kDebugMode ||
        (ref.watch(debugProvider).valueOrNull ?? false);

    ref.listen(earthquakeHistoryMapFocusProvider(earthquake.eventId), (
      _,
      next,
    ) async {
      if (next == null) {
        return;
      }
      if (!context.mounted) {
        return;
      }
      final controller = MapController.maybeOf(context);
      if (controller == null) {
        return;
      }
      final geo = geographicForEarthquakeIntensityFocus(earthquake, next);
      if (geo == null) {
        return;
      }
      await controller.animateCamera(
        center: geo,
        zoom: kEarthquakeHistoryMapFocusZoom,
      );
      ref
          .read(earthquakeHistoryMapFocusProvider(earthquake.eventId).notifier)
          .select(null);
    });

    final tileUrl = earthquake.estimatedIntensityTileUrl;
    final showingLpgmIntensity = displayMode == IntensityDisplayMode.lpgm;
    final showEstimated = displayMode == IntensityDisplayMode.estimated;

    final center = initialGeographicForEarthquake(earthquake);
    final zoom = initialZoomForEarthquake(earthquake);
    final (:maxZoom, :gestures) = sharedMapOptionsFromSettings(mapSettings);
    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: zoom,
      initStyle: styleString,
      maxZoom: maxZoom,
      gestures: gestures,
    );
    final hypocenterLayer = EarthquakeHistoryHypocenterLayer(
      earthquake: earthquake,
      displayMode: HypocenterDisplayMode.zoomFade,
      parameter: parameter,
    );

    return Stack(
      children: [
        MapLibreMap(
          options: mapOptions,
          onEvent: (event) async {
            MapLibreEventProvider.of(context).emit(event);
            if (event is MapEventClick) {
              final jmaMap = await ref.read(jmaMapProvider.future);

              if (context.mounted) {
                await _handleTap(
                  context: context,
                  event: event,
                  jmaMap: jmaMap,
                );
              }
            }
          },
          children: [
            if (showEstimated && tileUrl != null)
              EarthquakeHistoryDetailsEstimatedIntensityLayer(
                key: const ValueKey('estimated'),
                tileUrl: tileUrl,
              ),
            if (!showEstimated) ...[
              EarthquakeHistoryFillLayer(
                key: const ValueKey('fill'),
                earthquake: earthquake,
                parameter: parameter,
                fillMode: EarthquakeHistoryFillMode.auto,
                showingLpgmIntensity: showingLpgmIntensity,
              ),
              EarthquakeHistoryHypocenterErrorLayer(
                key: const ValueKey('hypocenter-error'),
                earthquake: earthquake,
                parameter: parameter,
              ),
              hypocenterLayer,
              EarthquakeHistoryStationIntensityLayer(
                key: const ValueKey('station'),
                earthquake: earthquake,
                parameter: parameter,
                stationDisplayMode: StationDisplayMode.maxFocused,
                showingLpgmIntensity: showingLpgmIntensity,
              ),
            ],
          ],
        ),

        // コントローラカード（右上）
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            child: _MapControllerCard(
              onFitBoundsTap: () async {
                await _fitBounds(context);
              },
              onDebugTap: isDebugger
                  ? () async {
                      await EarthquakeHistoryDebugModal.show(
                        context: context,
                      );
                    }
                  : null,
            ),
          ),
        ),

        // 震度凡例（右下）
        if (!showEstimated)
          Positioned(
            bottom: 8,
            right: 8,
            child: SafeArea(
              child: EarthquakeHistoryMapLegend(
                intensity: earthquake.intensity,
                showingLpgmIntensity: showingLpgmIntensity,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _handleTap({
    required BuildContext context,
    required MapEventClick event,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
  }) async {
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }

    final hits = controller.queryLayers(event.screenPoint);
    if (hits.isEmpty) {
      return;
    }

    if (hits.any((h) => h.layerId == _stationLayerId)) {
      final stationNode = _findNearestStation(event.point);
      if (stationNode == null) {
        return;
      }
      await showStationPopup(
        context,
        stationName: stationNode.station.name.ja,
        intensity: stationNode.intensity?.maxIntensity,
        lpgmIntensity: stationNode.intensity?.maxLpgmIntensity,
      );
      return;
    }

    final isCity = hits.any((h) => h.sourceLayer == _citySourceLayerId);
    final isRegion = hits.any((h) => h.sourceLayer == _regionSourceLayerId);
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
      await showAreaPopup(
        context,
        areaName: name,
        maxIntensity: cityNode?.maxIntensity,
      );
    } else {
      final region = _findRegionByCode(code);
      await showAreaPopup(
        context,
        areaName: name,
        maxIntensity: region?.maxIntensity,
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
            final dist =
                math.pow(station.location.lat - point.lat, 2) +
                math.pow(station.location.lon - point.lon, 2);
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
    for (final regions in intensity.regions.values) {
      for (final region in regions) {
        if (region.region.code == code) {
          return region;
        }
      }
    }
    return null;
  }

  Future<void> _fitBounds(BuildContext context) async {
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
              points.add(Geographic(lon: s.location.lon, lat: s.location.lat));
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

    await controller.fitBounds(
      bounds: LngLatBounds.fromPoints(points),
      padding: const EdgeInsets.all(48),
      webMaxZoom: 10,
    );
  }
}

class _MapControllerCard extends StatelessWidget {
  const _MapControllerCard({
    required this.onFitBoundsTap,
    required this.onDebugTap,
  });

  final Future<void> Function() onFitBoundsTap;
  final Future<void> Function()? onDebugTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Divider(height: 0),
    );

    return Card(
      color: colorScheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await HapticFeedback.lightImpact();
                await onFitBoundsTap();
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.zoom_out_map_rounded),
              ),
            ),
            if (onDebugTap != null) ...[
              divider,
              InkWell(
                onTap: () async {
                  await HapticFeedback.lightImpact();
                  await onDebugTap?.call();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.bug_report_rounded),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
