import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_controller_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_hypocenter_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_intensity_city_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_intensity_region_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_intensity_region_symbol_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_details_map_layer_modal.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_inherited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart' as app_lat_lng;
import 'package:maplibre/maplibre.dart';

class EarthquakeHistoryDetailsMapView extends HookConsumerWidget {
  const EarthquakeHistoryDetailsMapView({required this.earthquake, super.key});

  final EarthquakeV1Extended earthquake;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => LayoutBuilder(
        builder: (context, constraints) {
          final cameraPosition = _calculateCameraPosition(
            earthquake,
            constraints.maxWidth,
            constraints.maxHeight,
            earthquake.headline?.contains('遠地') ?? false,
          );

          return _MapView(
            earthquake: earthquake,
            styleString: value.styleString!,
            initialCameraPosition: cameraPosition,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }

  MapCameraPosition _calculateCameraPosition(
    EarthquakeV1Extended earthquake,
    double screenWidth,
    double screenHeight,
    bool isFarEarthquake,
  ) {
    if (earthquake.latitude != null && earthquake.longitude != null) {
      final lat = earthquake.latitude!;
      final lng = earthquake.longitude!;

      final maxIntensity = earthquake.maxIntensity;
      final zoom = switch (maxIntensity) {
        _ when isFarEarthquake => 4.0,
        _ => 5.0,
      };

      return MapCameraPosition(
        target: app_lat_lng.LatLng(lat, lng),
        zoom: zoom,
      );
    } else {
      return MapCameraPosition.fitBounds(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        bounds: (minLat: 30.0, minLng: 128.8, maxLat: 45.8, maxLng: 145.1),
        padding: 16,
      );
    }
  }
}

class _MapView extends HookConsumerWidget {
  const _MapView({
    required this.earthquake,
    required this.styleString,
    required this.initialCameraPosition,
  });

  final EarthquakeV1Extended earthquake;
  final String styleString;
  final MapCameraPosition initialCameraPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInitialized = useState(false);
    final controller = useState<MapController?>(null);

    final hypocenter = switch ((earthquake.latitude, earthquake.longitude)) {
      (final double lat, final double lng) => Position(lng, lat),
      _ => null,
    };

    final map = MapLibreMap(
      options: MapOptions(
        initCenter: Position(
          initialCameraPosition.target.lon,
          initialCameraPosition.target.lat,
        ),
        initZoom: initialCameraPosition.zoom,
        initStyle: styleString,
        minZoom: 0,
        maxZoom: 12,
      ),
      onStyleLoaded: (style) async {
        isInitialized.value = true;
      },
      onMapCreated: (c) => controller.value = c,
      children: [
        if (isInitialized.value) ...[
          EarthquakeHypocenterLayer(
            hypocenterType: HypocenterType.earthquake,
            latLng: hypocenter ?? Position(0, 0),
            isVisible: hypocenter != null,
          ),
          EarthquakeIntensityRegionLayer(
            eventId: earthquake.eventId,
            visible: earthquake.maxIntensity != null,
          ),
          EarthquakeIntensityCityLayer(
            eventId: earthquake.eventId,
            visible: earthquake.maxIntensity != null,
          ),
          EarthquakeIntensityRegionSymbolLayer(
            eventId: earthquake.eventId,
            visible: earthquake.maxIntensity != null,
          ),
        ],
        SafeArea(child: _MapHeader(initialPosition: initialCameraPosition)),
      ],
    );

    return SizedBox.expand(
      child: MapLibreInherited(
        controller: controller.value,
        child: map,
      ),
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader({required this.initialPosition});

  final MapCameraPosition initialPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox.shrink(),
        const Column(),
        EarthquakeHistoryControllerCard(
          onLayerButtonTap:
              () async => EarthquakeHistoryDetailsMapLayerModal.show(context),
          onLocationButtonTap: () async {
            final controller = MapLibreInherited.of(context);
            await controller.animateCamera(
              center: Position(
                initialPosition.target.lon,
                initialPosition.target.lat,
              ),
              zoom: initialPosition.zoom,
              nativeDuration: const Duration(milliseconds: 400),
            );
          },
        ),
      ],
    );
  }
}
