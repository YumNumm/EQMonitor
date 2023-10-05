import 'dart:math';

import 'package:eqmonitor/feature/map_libre/provider/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

class MapLibreMapScreen extends HookConsumerWidget {
  MapLibreMapScreen({super.key});

  late MaplibreMapController mapController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mapStyle = ref.watch(mapStyleProvider);
    final styleJsonFuture = useFuture(mapStyle.getStyle(isDark: isDark));
    final path = styleJsonFuture.data;
    if (path == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('AppBar'),
        ),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: MaplibreMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(35.681236, 139.767125),
          zoom: 4,
        ),
        styleString: path,
        onMapCreated: (controller) => mapController = controller,
        onStyleLoadedCallback: () {},
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('FILL'),
        icon: const Icon(Icons.add),
        onPressed: () {
          mapController
            ..removeLayer('areaForecastLocalE-100')
            ..addLayer(
              'eqmonitor_map',
              'areaForecastLocalE-100',
              const FillLayerProperties(
                fillColor: '#00FF00',
              ),
              sourceLayer: 'areaInformationCityQuake',
              filter: [
                'in',
                ['get', 'regioncode'],
                [
                  'literal',
                  <void>[].where((element) => Random().nextBool()).toList(),
                ],
              ],
            );
        },
      ),
    );
  }
}
