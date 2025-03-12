// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

// ignore: must_be_immutable
class MapPluginIos extends StatelessWidget {
  MapPluginIos({super.key});

  MLNMapView? _cachedMapView;

  late final int _mapViewId;

  MLNMapView get mapView =>
      _cachedMapView ??= MLNMapView.castFrom(
        MapLibreRegistry.getMapWithViewId_(_mapViewId) ??
            (throw Exception('Map not found for id $_mapViewId')),
      );

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: "plugins.net.yumnumm.map_plugin",
      layoutDirection: TextDirection.ltr,
      onPlatformViewCreated: (id) async {
        _cachedMapView = MLNMapView.castFrom(
          MapLibreRegistry.getMapWithViewId_(id) ??
              (throw Exception('Map not found for id $id')),
        );

        await Future<void>.delayed(Duration(seconds: 1));

        mapView.debugMask = MLNMapDebugMaskOptions.MLNMapDebugTileInfoMask;

        final coordinate =
            Struct.create<CLLocationCoordinate2D>()
              ..latitude = 35.681236
              ..longitude = 139.767125;

        mapView.setCenterCoordinate_zoomLevel_animated_(coordinate, 7, false);

        final nsUrl = NSURL.URLWithString_(
          'https://v2.map.eqmonitor.app/style-light.json'.toNSString(),
        );
        mapView.styleURL = nsUrl!;
        mapView.triggerRepaint();

        final mapOverlay = CustomStyleLayer.initWithIdentifier_1(
          "map-overlay".toNSString(),
        );

        mapView.style!.addLayer_(MLNStyleLayer.castFrom(mapOverlay));
      },
    );
  }
}
