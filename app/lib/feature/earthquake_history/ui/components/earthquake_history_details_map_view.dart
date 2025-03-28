import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/util/map_layer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_v1_extended.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_controller_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/layers/earthquake_hypocenter_layer.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
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
  ) {
    if (earthquake.latitude != null && earthquake.longitude != null) {
      final lat = earthquake.latitude!;
      final lng = earthquake.longitude!;

      double zoom = 7.0;

      if (earthquake.maxIntensity != null) {
        switch (earthquake.maxIntensity!.index) {
          case >= 6:
            zoom = 6.0;
          case >= 5:
            zoom = 6.5;
          case >= 4:
            zoom = 7.0;
          case >= 3:
            zoom = 7.5;
          case >= 2:
            zoom = 8.0;
          default:
            zoom = 8.5;
        }
      }

      return MapCameraPosition(target: LatLng(lat, lng), zoom: zoom);
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

    ref.listen(
      homeConfigurationNotifierProvider.select((v) => v.showLocation),
      (_, showLocation) {
        if (controller.value != null) {
          if (showLocation) {
            unawaited(
              controller.value!.enableLocation(
                pulse: false,
                pulseFade: false,
                compassAnimation: false,
              ),
            );
          } else {
            unawaited(controller.value!.disableLocation());
          }
        }
      },
    );

    final hypocenter = switch ((earthquake.latitude, earthquake.longitude)) {
      (final double lat, final double lng) => LatLng(lat, lng),
      _ => null,
    };

    return SizedBox.expand(
      child: MapLibreMap(
        acceptLicense: true,
        options: MapOptions(
          initStyle: 'file://$styleString',
          initZoom: initialCameraPosition.zoom,
          initCenter: Position(
            initialCameraPosition.target.lon,
            initialCameraPosition.target.lat,
          ),
          minZoom: 1,
          maxZoom: 12,
        ),
        onStyleLoaded: (styleController) async {
          final c = controller.value;
          final location =
              ref.read(homeConfigurationNotifierProvider).showLocation;
          if (c != null) {
            if (location) {
              await c.enableLocation(
                pulse: false,
                pulseFade: false,
                compassAnimation: false,
              );
            } else {
              await c.disableLocation();
            }
          }
          isInitialized.value = true;
        },
        onMapCreated: (c) => controller.value = c,
        children: [
          if (isInitialized.value) ...<MapLayer>[
            EarthquakeHypocenterLayer(
              hypocenterType: HypocenterType.earthquake,
              latLng: hypocenter ?? const LatLng(0, 0),
              isVisible: hypocenter != null,
            ),
          ],
          SafeArea(child: _MapHeader(initialPosition: initialCameraPosition)),
        ],
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
          onLayerButtonTap: () async => HomeMapLayerModal.show(context),
          onLocationButtonTap:
              () async => MapController.of(context).animateCamera(
                nativeDuration: const Duration(milliseconds: 400),
                pitch: 0,
                bearing: 0,
                center: Position(
                  initialPosition.target.lon,
                  initialPosition.target.lat,
                ),
                zoom: initialPosition.zoom,
              ),
        ),
      ],
    );
  }
}
