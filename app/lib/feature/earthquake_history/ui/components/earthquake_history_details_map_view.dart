import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_details_map_camera_controller.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_map_camera.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_region_intensity_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      AsyncError(:final error) => Center(
        child: ErrorCard(error: error),
      ),
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
    required this.eventId,
  });

  final String styleString;
  final Earthquake earthquake;
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final center = initialGeographicForEarthquake(earthquake);
    final zoom = initialZoomForEarthquake(earthquake);
    final mapOptions = MapOptions(
      initCenter: center,
      initZoom: zoom,
      initStyle: styleString,
    );

    final tileUrl = earthquake.estimatedIntensityTileUrl;

    return MapLibreEventProvider(
      child: Builder(
        builder: (context) {
          return MapLibreMap(
            options: mapOptions,
            onEvent: (event) => MapLibreEventProvider.of(context).emit(event),
            children: [
              // 区域塗りつぶし（最背面）
              EarthquakeHistoryRegionIntensityLayer(
                intensity: earthquake.intensity,
              ),
              // 推計震度ラスタ（区域塗りつぶしの上）
              if (tileUrl != null)
                EarthquakeHistoryDetailsEstimatedIntensityLayer(
                  tileUrl: tileUrl,
                ),
              // 観測点
              EarthquakeHistoryStationIntensityLayer(
                intensity: earthquake.intensity,
              ),
              // 震源マーク（最前面）
              EarthquakeHistoryHypocenterLayer(earthquake: earthquake),
              EarthquakeHistoryDetailsMapCameraController(
                eventId: eventId,
                earthquake: earthquake,
              ),
            ],
          );
        },
      ),
    );
  }
}
