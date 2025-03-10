import 'dart:io';

import 'package:flutter/material.dart';
import 'package:map_plugin/gen/maplibre_ffi.dart';
import 'package:map_plugin/map_plugin_ios.dart';

class MapPluginView extends StatelessWidget {
  const MapPluginView({super.key, required this.onMapCreated});

  final void Function(MLNMapView) onMapCreated;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return MapPluginIos(
        key: UniqueKey(),
      );
    }
    throw UnimplementedError(
      'MapPluginView is not supported on ${Platform.operatingSystem}',
    );
  }
}
