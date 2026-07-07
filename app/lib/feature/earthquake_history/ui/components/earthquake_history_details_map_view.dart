import 'dart:math' as math;

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_map_layer_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_focus_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_map_layer_parameter_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_legend.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_popup.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_error_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_fill_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
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
    required this.showingDb,
    super.key,
  });

  final Earthquake earthquake;
  final IntensityDisplayMode displayMode;
  final bool showingDb;

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
            showingDb: showingDb,
          ),
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
    required this.displayMode,
    required this.showingDb,
  });

  final String styleString;
  final Earthquake earthquake;
  final IntensityDisplayMode displayMode;
  final bool showingDb;

  static const _stationLayerId = 'eq-history-station-intensity-circle';
  static const _dbStationLayerId = 'eq-history-shindo-db-station-circle';
  static const _regionSourceLayerId = 'areaForecastLocalE';
  static const _citySourceLayerId = 'areaInformationCityQuake';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parameter = ref.watch(
      earthquakeHistoryMapLayerParameterProvider.select(
        (v) => v.value ?? const EarthquakeHistoryMapLayerParameter(),
      ),
    );
    final mapSettings = ref.watch(
      homeConfigurationProvider.select(
        (v) => v.value?.map ?? const HomeMapSettings(),
      ),
    );
    final isDebugger = kDebugMode || (ref.watch(debugProvider).value ?? false);

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

    final ShindoDbIntensityTree? dbTree = switch (showingDb
        ? ref.watch(shindoDbIntensityTreeProvider(earthquake.eventId))
        : null) {
      AsyncData(:final value) => value,
      _ => null,
    };

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
                  ref: ref,
                  event: event,
                  jmaMap: jmaMap,
                  dbTree: dbTree,
                );
              }
            }
          },
          children: [
            if (showingDb) ...[
              if (dbTree != null) ...[
                EarthquakeHistoryShindoDbFillLayer(
                  key: const ValueKey('shindo-db-fill'),
                  tree: dbTree,
                  parameter: parameter,
                ),
                EarthquakeHistoryShindoDbStationLayer(
                  key: const ValueKey('shindo-db-station'),
                  tree: dbTree,
                  parameter: parameter,
                ),
              ],
            ] else ...[
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
                  showingLpgmIntensity: showingLpgmIntensity,
                ),
                EarthquakeHistoryHypocenterErrorLayer(
                  key: const ValueKey('hypocenter-error'),
                  earthquake: earthquake,
                  parameter: parameter,
                ),
                EarthquakeHistoryStationIntensityLayer(
                  key: const ValueKey('station'),
                  earthquake: earthquake,
                  parameter: parameter,
                  showingLpgmIntensity: showingLpgmIntensity,
                ),
              ],
            ],
            hypocenterLayer,
          ],
        ),

        // コントローラカード（右上）
        Positioned(
          top: 8,
          right: 8,
          child: SafeArea(
            child: _MapControllerCard(
              onFitBoundsTap: () async {
                await _fitBounds(context, dbTree: dbTree);
              },
              onDebugTap: isDebugger
                  ? () async {
                      await EarthquakeHistoryDebugModal.show(context: context);
                    }
                  : null,
            ),
          ),
        ),

        // 震度凡例（右下）
        if (showingDb || !showEstimated)
          Positioned(
            bottom: 8,
            right: 8,
            child: SafeArea(
              child: EarthquakeHistoryMapLegend(
                intensity: showingDb ? null : earthquake.intensity,
                showingLpgmIntensity: showingLpgmIntensity,
                shindoDbTree: showingDb ? dbTree : null,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _handleTap({
    required BuildContext context,
    required WidgetRef ref,
    required MapEventClick event,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    ShindoDbIntensityTree? dbTree,
  }) async {
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }

    final hits = controller.queryLayers(event.screenPoint);
    if (hits.isEmpty) {
      return;
    }

    if (dbTree != null && hits.any((h) => h.layerId == _dbStationLayerId)) {
      final result = _findNearestDbStation(event.point, dbTree);
      if (result == null) {
        return;
      }
      final (station, cls) = result;
      await showStationPopup(
        context,
        stationName: station.name,
        intensity: cls.exactJmaIntensity,
        lpgmIntensity: null,
        intensityLabel: cls.exactJmaIntensity == null ? cls.label : null,
      );
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

    // 都道府県コードを解決してディープリンクルートを構築する
    final prefectures =
        ref
            .read(parameterSetProvider)
            .whenOrNull(data: (p) => p.earthquake.prefectures) ??
        [];

    if (isCity) {
      final cityNode = _findCityByCode(code);
      final prefCode = prefectureCodeOfCity(code, prefectures);
      final intensityHistoryRoute = prefCode != null
          ? IntensityHistoryRoute(prefectureCode: prefCode, cityCode: code)
          : null;
      await showAreaPopup(
        context,
        areaName: name,
        maxIntensity: cityNode?.maxIntensity,
        intensityHistoryRoute: intensityHistoryRoute,
      );
    } else {
      final region = _findRegionByCode(code);
      final prefInfo = prefectureOfRegionCode(code, prefectures);
      final intensityHistoryRoute = prefInfo != null
          ? IntensityHistoryRoute(prefectureCode: prefInfo.code)
          : null;
      await showAreaPopup(
        context,
        areaName: name,
        maxIntensity: region?.maxIntensity,
        intensityHistoryRoute: intensityHistoryRoute,
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

  (ShindoDbStationNode, ShindoDbIntensityClass)? _findNearestDbStation(
    Geographic point,
    ShindoDbIntensityTree tree,
  ) {
    ShindoDbStationNode? nearest;
    ShindoDbIntensityClass? nearestClass;
    var minDist = double.infinity;

    void check(ShindoDbStationNode station, ShindoDbIntensityClass cls) {
      final loc = station.location;
      if (loc == null) {
        return;
      }
      final dist =
          math.pow(loc.lat - point.lat, 2) + math.pow(loc.lon - point.lon, 2);
      if (dist < minDist) {
        minDist = dist.toDouble();
        nearest = station;
        nearestClass = cls;
      }
    }

    for (final entry in tree.tree.entries) {
      final cls = entry.key;
      for (final pref in entry.value) {
        for (final cityNode in pref.cities) {
          for (final station in cityNode.stations) {
            check(station, cls);
          }
        }
      }
    }
    for (final entry in tree.unresolvedStations.entries) {
      final cls = entry.key;
      for (final station in entry.value) {
        check(station, cls);
      }
    }

    if (nearest == null || nearestClass == null) {
      return null;
    }
    return (nearest!, nearestClass!);
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

  Future<void> _fitBounds(
    BuildContext context, {
    ShindoDbIntensityTree? dbTree,
  }) async {
    final controller = MapController.maybeOf(context);
    if (controller == null) {
      return;
    }

    final points = <Geographic>[];

    if (dbTree != null) {
      for (final entry in dbTree.tree.entries) {
        for (final pref in entry.value) {
          for (final cityNode in pref.cities) {
            for (final station in cityNode.stations) {
              final loc = station.location;
              if (loc != null) {
                points.add(Geographic(lon: loc.lon, lat: loc.lat));
              }
            }
          }
        }
      }
      for (final entry in dbTree.unresolvedStations.entries) {
        for (final station in entry.value) {
          final loc = station.location;
          if (loc != null) {
            points.add(Geographic(lon: loc.lon, lat: loc.lat));
          }
        }
      }
    } else {
      final intensity = earthquake.intensity;
      if (intensity != null) {
        for (final entry in intensity.intensityTree.entries) {
          for (final region in entry.value) {
            for (final city in region.cities) {
              for (final stationNode in city.stations) {
                final s = stationNode.station;
                points.add(
                  Geographic(lon: s.location.lon, lat: s.location.lat),
                );
              }
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
    final colorTheme = context.designSystem.colorTheme;
    const divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Divider(height: 0),
    );

    return Card(
      color: colorTheme.surfaceContainerHighest,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
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
