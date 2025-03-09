import 'dart:convert';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/model/camera_position.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationNotifierProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => LayoutBuilder(
        builder: (context, constraints) {
          final cameraPosition = MapCameraPosition.fitBounds(
            screenWidth: constraints.maxWidth,
            screenHeight: constraints.maxHeight,
            bounds: (minLat: 30, minLng: 128.8, maxLat: 45.8, maxLng: 145.1),
            padding: 16,
          );

          return _MapView(
            styleString: value.styleString!,
            initialCenter: Position(
              cameraPosition.target.lon,
              cameraPosition.target.lat,
            ),
            initialZoomLevel: cameraPosition.zoom,
          );
        },
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _MapView extends HookConsumerWidget {
  const _MapView({
    required this.styleString,
    required this.initialCenter,
    required this.initialZoomLevel,
  });

  final String styleString;
  final Position initialCenter;
  final double initialZoomLevel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text("MapView"),
    );
    // return MapLibreMap(
    //   acceptLicense: true,
    //   options: MapOptions(
    //     initStyle: 'file://$styleString',
    //     initCenter: initialCenter,
    //     initZoom: initialZoomLevel,
    //   ),
    //   onStyleLoaded: (controller) async {
    //     await controller.addSource(
    //       GeoJsonSource(id: 'kyoshin-monitor', data: jsonEncode({})),
    //     );
    //     await controller.addLayer(
    //       const CircleStyleLayer(
    //         id: 'kyoshin-monitor',
    //         sourceId: 'kyoshin-monitor',
    //       ),
    //     );
    //     await controller.updateGeoJsonSource(
    //       id: 'kyoshin-monitor',
    //       data: jsonEncode({}),
    //     );
    //   },
    // );
  }
}
