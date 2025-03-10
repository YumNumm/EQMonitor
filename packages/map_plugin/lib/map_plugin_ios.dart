// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:objective_c/objective_c.dart';

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
      key: key,
      viewType: "plugins.net.yumnumm.map_plugin",
      layoutDirection: TextDirection.ltr,
      onPlatformViewCreated: (id) {
        _cachedMapView = MLNMapView.castFrom(
          MapLibreRegistry.getMapWithViewId_(id) ??
              (throw Exception('Map not found for id $id')),
        );

        mapView.debugMask =
            MLNMapDebugMaskOptions.MLNMapDebugCollisionBoxesMask;

        final coordinate =
            Struct.create<CLLocationCoordinate2D>()
              ..latitude = 35.681236
              ..longitude = 139.767125;
        final ffiCamera = mapView.camera;
        ffiCamera.centerCoordinate = coordinate;

        mapView.setCamera_animated_(ffiCamera, false);
        final nsUrl =
            NSURL.URLWithString_(
              "https://v2.map.eqmonitor.app/style-light.json".toNSString(),
            )!;
        print(nsUrl.standardizedURL?.toString());
        mapView.styleURL = nsUrl;
      },
    );
  }
}
