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
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      AsyncData(:final value) when value.styleString != null =>
        MapLibreEventProvider(
          child: _MapContent(
            styleString: value.styleString!,
            earthquake: earthquake,
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
  });

  final String styleString;
  final Earthquake earthquake;

  static const _stationLayerId = 'eq-history-station-intensity-circle';
  // Fill layers are created per intensity level (e.g. 'eq-history-jma-one-region-fill'),
  // so we detect taps by source layer ID instead of individual layer IDs.
  static const _regionSourceLayerId = 'areaForecastLocalE';
  static const _citySourceLayerId = 'areaInformationCityQuake';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      earthquakeHistoryConfigProvider.select((v) => v.requireValue.detail),
    );
    final jmaMap = ref.watch(jmaMapProvider).requireValue;

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
    const debugDialogAction = EarthquakeHistoryMapLayerDebugDialogAction();

    return Stack(
      children: [
        MapLibreMap(
          options: mapOptions,
          onEvent: (event) async {
            MapLibreEventProvider.of(context).emit(event);
            if (event is MapEventClick) {
              await _handleTap(
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
              onLayersTap: () async {
                await EarthquakeHistoryMapDisplayModeModal.show(
                  context: context,
                  hasLpgmIntensity:
                      earthquake.intensity?.maxLpgmIntensity != null,
                  hasTileUrl: tileUrl != null,
                );
              },
              onFitBoundsTap: () async {
                await _fitBounds(context);
              },
              onDebugTap: kDebugMode
                  ? () async {
                      await debugDialogAction.show(
                        context: context,
                        earthquake: earthquake,
                        config: config,
                      );
                    }
                  : null,
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
  }

  Future<void> _handleTap({
    required BuildContext context,
    required MapEventClick event,
    required EarthquakeHistoryDetailConfig config,
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

    // 観測点タップ
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

/// 地図右上のコントローラカード（レイヤー設定 + Fit to Bounds）
class _MapControllerCard extends StatelessWidget {
  const _MapControllerCard({
    required this.onLayersTap,
    required this.onFitBoundsTap,
    required this.onDebugTap,
  });

  final Future<void> Function() onLayersTap;
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
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                await HapticFeedback.lightImpact();
                await onLayersTap();
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.layers_rounded),
              ),
            ),
            divider,
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

class EarthquakeHistoryMapLayerDebugDialogAction {
  const EarthquakeHistoryMapLayerDebugDialogAction();

  Future<void> show({
    required BuildContext context,
    required Earthquake earthquake,
    required EarthquakeHistoryDetailConfig config,
  }) {
    const modeResolver = EarthquakeHistoryMapLayerModeResolver();
    final availability = modeResolver.resolveAvailability(
      earthquake: earthquake,
      showingLpgmIntensity: config.showingLpgmIntensity,
    );
    final iconLayerMode = modeResolver.resolveMapLayerMode(
      earthquake: earthquake,
      config: config,
    );
    final fillLayerMode = modeResolver.resolveFillLayerMode(
      earthquake: earthquake,
      config: config,
    );

    return showDialog<void>(
      context: context,
      builder: (context) => _MapLayerModeDebugDialog(
        availability: availability,
        config: config,
        iconLayerMode: iconLayerMode,
        fillLayerMode: fillLayerMode,
      ),
    );
  }
}

class _MapLayerModeDebugDialog extends StatelessWidget {
  const _MapLayerModeDebugDialog({
    required this.availability,
    required this.config,
    required this.iconLayerMode,
    required this.fillLayerMode,
  });

  final EarthquakeHistoryMapLayerAvailability availability;
  final EarthquakeHistoryDetailConfig config;
  final EarthquakeHistoryMapLayerMode iconLayerMode;
  final EarthquakeHistoryMapLayerMode fillLayerMode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Map Layer Mode Debug'),
      content: SingleChildScrollView(
        child: _MapLayerModeDebugContent(
          availability: availability,
          config: config,
          iconLayerMode: iconLayerMode,
          fillLayerMode: fillLayerMode,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}

class _MapLayerModeDebugContent extends StatelessWidget {
  const _MapLayerModeDebugContent({
    required this.availability,
    required this.config,
    required this.iconLayerMode,
    required this.fillLayerMode,
  });

  final EarthquakeHistoryMapLayerAvailability availability;
  final EarthquakeHistoryDetailConfig config;
  final EarthquakeHistoryMapLayerMode iconLayerMode;
  final EarthquakeHistoryMapLayerMode fillLayerMode;

  @override
  Widget build(BuildContext context) {
    const zoomThresholds = defaultEarthquakeHistoryMapLayerZoomThresholds;
    const modeResolver = EarthquakeHistoryMapLayerModeResolver();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DebugSection(
          title: 'Resolved',
          children: [
            _DebugRow(label: 'iconLayerMode', value: iconLayerMode.name),
            _DebugRow(label: 'fillLayerMode', value: fillLayerMode.name),
          ],
        ),
        _DebugSection(
          title: 'Layer Visibility',
          children: [
            _DebugRow(
              label: 'regionIcon',
              value: modeResolver.showsRegionIcon(iconLayerMode).toString(),
            ),
            _DebugRow(
              label: 'cityIcon',
              value: modeResolver.showsCityIcon(iconLayerMode).toString(),
            ),
            _DebugRow(
              label: 'stationIcon',
              value: modeResolver.showsStationIcon(iconLayerMode).toString(),
            ),
            _DebugRow(
              label: 'regionFill',
              value: modeResolver.showsRegionFill(fillLayerMode).toString(),
            ),
            _DebugRow(
              label: 'cityFill',
              value: modeResolver.showsCityFill(fillLayerMode).toString(),
            ),
          ],
        ),
        _DebugSection(
          title: 'Availability',
          children: [
            _DebugRow(
              label: 'region',
              value: availability.region.toString(),
            ),
            _DebugRow(label: 'city', value: availability.city.toString()),
            _DebugRow(
              label: 'station',
              value: availability.station.toString(),
            ),
          ],
        ),
        _DebugSection(
          title: 'Config',
          children: [
            _DebugRow(label: 'iconMode', value: config.iconMode.name),
            _DebugRow(label: 'fillMode', value: config.fillMode.name),
            _DebugRow(
              label: 'showingLpgmIntensity',
              value: config.showingLpgmIntensity.toString(),
            ),
            _DebugRow(
              label: 'showStation',
              value: config.showStation.toString(),
            ),
            _DebugRow(
              label: 'showStationLabel',
              value: config.showStationLabel.toString(),
            ),
            _DebugRow(
              label: 'stationDisplayMode',
              value: config.stationDisplayMode.name,
            ),
          ],
        ),
        _DebugSection(
          title: 'Zoom Thresholds',
          children: [
            _DebugRow(
              label: 'regionToCity',
              value: zoomThresholds.regionToCity.toString(),
            ),
            _DebugRow(
              label: 'cityToStation',
              value: zoomThresholds.cityToStation.toString(),
            ),
          ],
        ),
      ],
    );
  }
}

class _DebugSection extends StatelessWidget {
  const _DebugSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _DebugRow extends StatelessWidget {
  const _DebugRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: textTheme.bodySmall),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
